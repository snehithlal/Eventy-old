# frozen_string_literal: true

class CirclesController < ApplicationController
  before_action :set_circle, only: [:show, :update, :destroy]

  # GET /circles
  def index
    @circles = Circle.all

    render json: @circles
  end

  # GET /circles/1
  def show
    render json: @circle
  end

  # POST /circles
  def create
    @circle = Circle.new(circle_params)

    if @circle.save
      render json: @circle, status: :created, location: @circle
    else
      render json: @circle.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /circles/1
  def update
    if @circle.update(circle_params)
      render json: @circle
    else
      render json: @circle.errors, status: :unprocessable_entity
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
    params.require(:circle).permit(:name, :description, :head_id, :members)
  end
end
