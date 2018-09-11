module Api
  module V1
    class RentsController < ApplicationController
      before_action :authenticate_api_v1_user!, only: %i[index create]

      def index
        render_paginated Rent.includes(:book, :user).filter(params.slice(:user_id, :book_id))
      end

      def create
        rent = Rent.new(permitted_params)
        if rent.save
          render json: rent
        else
          render json: rent.errors, status: :unprocessable_entity
        end
      end

      private

      def permitted_params
        params.require(:rent).permit(:book_id, :user_id, :from, :to)
      end
    end
  end
end
