module Api
  module V1
    class RentsController < ApplicationController
      before_action :authenticate_api_v1_user!, only: %i[index create]

      def index
        params[:user_id] = current_user.id
        render_paginated Rent.includes(:book, :user).filter(params.slice(:user_id, :book_id))
      end

      def show
        authorized_rent = authorize Rent.find(params[:id])
        render json: authorized_rent
      end

      def create
        rent = Rent.new(permitted_params)
        if rent.save
          RentsMailer.new_rent_notification(rent.id).deliver_later
          render json: rent
        else
          render json: rent.errors, status: :unprocessable_entity
        end
      end

      private

      def permitted_params
        params[:user_id] = current_user.id
        params.require(:rent).permit(:book_id, :user_id, :from, :to)
      end
    end
  end
end
