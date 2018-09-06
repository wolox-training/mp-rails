module Api
  module V1
    class BooksController < ApplicationController
      before_action :authenticate_api_v1_user!, only: %i[index show]

      def index
        books = Book.filter(params.slice(:genre, :author, :image, :title, :publisher, :year))
        render_paginated books
      end

      def show
        render json: Book.find(params[:id])
      end
    end
  end
end