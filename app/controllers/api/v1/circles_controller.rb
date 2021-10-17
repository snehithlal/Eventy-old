# frozen_string_literal: true

module Api
  module V1
    class CirclesController < ApiController
      before_action :set_circle, only: %i[show update destroy]

      # GET /circles
      def index
        circles = Circle.for_user

        render json: CircleSerializer.render_as_json(circles, root: :circles, view: :with_head_and_members), status: :ok
      end

      # GET /circles/1
      def show
        render json: CircleSerializer.render_as_json(@circle, root: :circle, view: :with_head_and_members), status: :ok
      end

      # POST /circles
      def create
        circle = Circle.new(circle_params)

        if circle.save
          render json: CircleSerializer.render_as_json(circle, root: :circle, view: :with_head_and_members),
                 status: :created
        else
          render json: { errors: circle.errors }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /circles/1
      def update
        if @circle.update(circle_params)
          render json: CircleSerializer.render_as_json(@circle, root: :circle, view: :with_head_and_members),
                 status: :ok
        else
          render json: { errors: @circle.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /circles/1
      def destroy
        @circle.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_circle
        @circle = Circle.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def circle_params
        params.require(:circle).permit(:name, :description, :member_ids)
      end
    end
  end
end
