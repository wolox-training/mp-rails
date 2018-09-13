module Api
  module V1
    class RentsController < ApplicationController
      before_action :authenticate_api_v1_user!, only: %i[index create]

      def index
        rents = Rent.includes(:book, :user).filter(params.slice(:user_id, :book_id))
        authorized_rents = RentPolicy::Scope.new(current_api_v1_user, rents).resolve
        render_paginated authorized_rents
      end

      def show
        rent = RentPolicy::Scope.new(current_api_v1_user, Rent).resolve
        render json: rent.find(params[:id])
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
        params[:user_id] = current_api_v1_user.id
        params.require(:rent).permit(:book_id, :user_id, :from, :to)
      end
    end
  end
end
