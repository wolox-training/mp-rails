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

  describe 'GET #fetch_book_by_isbn' do
    context 'when using a valid isbn' do
      let(:expected_response) do
        {
          'isbn': '9780876855577',
          'title': 'Ham on rye',
          'subtitle': 'a novel',
          'number_of_pages': 283,
          'authors': ['Charles Bukowski']
        }
      end

      before do
        body = {
          'ISBN:9780876855577': {
            'subtitle': 'a novel',
            'title': 'Ham on rye',
            'number_of_pages': 283,
            'authors': [{
              'url': 'https://openlibrary.org/authors/OL31084A/Charles_Bukowski',
              'name': 'Charles Bukowski'
            }]
          }
        }
        stub_request(:get, 'https://openlibrary.org/api/books?bibkeys=ISBN:9780876855577&format=json&jscmd=data')
          .to_return(
            headers: { 'Content-Type': 'application/json' },
            body: body.to_json
          )

        get :fetch_book_by_isbn, params: { isbn: '9780876855577' }
      end

      it 'responds with the book json' do
        expect(response.body).to eq expected_response.to_json
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when using an invalid isbn' do
      let(:expected_response) do
        {
          errors: 'Invalid ISBN format.'
        }
      end

      before do
        get :fetch_book_by_isbn, params: { isbn: '123' }
      end

      it 'responds with error message' do
        expect(response.body).to eq expected_response.to_json
      end

      it 'responds with 422 status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when openlibrary responds with an error' do
      let(:expected_response) do
        { 'errors': 'Error fetching book info from OpenLibrary.' }
      end

      before do
        body = {}
        stub_request(:get, 'https://openlibrary.org/api/books?bibkeys=ISBN:9780876855577&format=json&jscmd=data')
          .to_return(
            headers: { 'Content-Type': 'application/json' },
            body: body.to_json,
            status: 500
          )

        get :fetch_book_by_isbn, params: { isbn: '9780876855577' }
      end

      it 'responds with the book json' do
        expect(response.body).to eq expected_response.to_json
      end

      it 'responds with 500 status' do
        expect(response).to have_http_status(:error)
      end
    end
  end
end
