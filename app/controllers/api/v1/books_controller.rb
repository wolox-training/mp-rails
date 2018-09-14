module Api
  module V1
    include OpenLibraryService
    class BooksController < ApplicationController
      before_action :authenticate_api_v1_user!, only: %i[index show]

      def index
        books = Book.filter(params.slice(:genre, :author, :image, :title, :publisher, :year))
        render_paginated books
      end

      def show
        render json: Book.find(params[:id])
      end

      def fetch_book_by_isbn
        puts params[:isbn]
        render json: OpenLibraryService::Main.book_info(params[:isbn])
      end
    end
  end
end
