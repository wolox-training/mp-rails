require 'rails_helper'

describe Api::V1::BooksController do
  include_context 'Authenticated User'

  describe 'GET #index' do
    context 'when fetching all the books' do
      let!(:books) { create_list(:book, 3) }

      before do
        get :index
      end

      it 'responds with the books json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          books, each_serializer: BookSerializer
        ).to_json
        expect(response.body.to_json) =~ JSON.parse(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when filtering books by genre' do
      let!(:drama) { create_list(:book, 3, genre: 'drama') }
      let(:books) { create_list(:book, 3) }

      before do
        get :index, params: { genre: 'drama' }
      end

      it 'responds with filtered json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          drama, each_serializer: BookSerializer
        ).to_json
        expect(response.body.to_json) =~ JSON.parse(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'when fetching a book' do
      let!(:book) { create(:book) }

      before do
        get :show, params: { id: book.id }
      end

      it 'responds with the book json' do
        expect(response.body).to eq BookSerializer.new(
          book, root: false
        ).to_json
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when fetching a book with invalid id' do
      let(:book) { create(:book) }

      before do
        get :show, params: { id: 2 }
      end

      it 'responds with error' do
        expected = '{"error":"Nothing found"}'
        expect(response.body).to eq expected
      end

      it 'responds with 404 status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
