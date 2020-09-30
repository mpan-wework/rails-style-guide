module Api
  module V1
    class BuildingsController < BaseController
      before_action :set_building, only: %i(show update)

      def index
        buildings = Building.all
        render json: buildings
      end

      def show
        render json: @building
      end

      def create
        building = Building.new create_building_params
        if building.save
          render json: building.reload, status: :created
        else
          render json: building.errors, status: :bad_request
        end
      end

      def update
        if @building.update(update_building_params)
          render json: @building
        else
          render json: @building.errors, status: :unprocessable_entity
        end
      end

      private

      def set_building
        @building = Building.find_by! uuid: params.require(:uuid)
      end

      def create_building_params
        params.require(:building).permit(:uuid, :name)
      end

      def update_building_params
        params.require(:building).permit(:name)
      end
    end
  end
end
