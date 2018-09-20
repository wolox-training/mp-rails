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

      def fetch_book_by_isbn
        render json: OpenLibraryService::Main.book_info(params[:isbn])
      rescue OpenLibraryService::OpenLibraryServiceErrors::InvalidISBN => e
        render json: { errors: e.message }, status: :unprocessable_entity
      rescue OpenLibraryService::OpenLibraryServiceErrors::BookInfoFetchError => e
        render json: { errors: e.message }, status: :error
      end
    end
  end
end
