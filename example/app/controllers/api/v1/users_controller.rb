module Api
  module V1
    class UsersController < BaseController
      before_action :set_firm, only: %i(index create)
      before_action :set_user, only: %i(show update)

      def index
        users = @firm.users
        render json: users
      end

      def show
        render json: @user
      end

      def create
        user = @firm.users.new create_user_params
        if user.save
          render json: user.reload, status: :created
        else
          render json: user.errors, status: :bad_request
        end
      end

      def update
        if @user.update(update_user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      private

      def set_firm
        @firm = Firm.find_by! uuid: params.require(:firm_uuid)
      end

      def set_user
        @user = User.find_by! uuid: params.require(:uuid)
      end

      def create_user_params
        params.require(:user).permit(:uuid, :name, :email, :phone)
      end

      def update_user_params
        params.require(:user).permit(:name, :email, :phone, :firm_uuid)
      end
    end
  end
end
