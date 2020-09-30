module Api
  module V1
    class FirmsController < BaseController
      before_action :set_building, only: %i(index create)
      before_action :set_firm, only: %i(show update)

      def index
        firms = @building.firms
        render json: firms
      end

      def show
        render json: @firm
      end

      def create
        firm = @building.firms.new create_firm_params
        if firm.save
          render json: firm.reload, status: :created
        else
          render json: firm.errors, status: :bad_request
        end
      end

      def update
        if @firm.update(update_firm_params)
          render json: @firm
        else
          render json: @firm.errors, status: :unprocessable_entity
        end
      end

      private

      def set_building
        @building = Building.find_by! uuid: params.require(:building_uuid)
      end

      def set_firm
        @firm = Firm.find_by! uuid: params.require(:uuid)
      end

      def create_firm_params
        params.require(:firm).permit(:uuid, :name)
      end

      def update_firm_params
        params.require(:firm).permit(:name, :building_uuid)
      end
    end
  end
end
