require 'rails_helper'

describe Api::V1::RentsController do
  include_context 'Authenticated User'

  describe 'GET #index' do
    context 'when fetching all the rents' do
      let!(:rents) { create_list(:rent, 3) }

      before do
        get :index
      end

      it 'responds with the rents json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          rents, each_serializer: RentSerializer
        ).to_json
        expect(response.body.to_json) =~ JSON.parse(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when receiving book_id filter' do
      let!(:rents_book) { create_list(:rent, 3, book: create(:book, id: 1), user: user) }

      let!(:rents) { create_list(:rent, 3) } # rubocop:disable RSpec/LetSetup

      before do
        get :index, params: { book_id: 1 }
      end

      it 'responds with the rents json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          rents_book, each_serializer: RentSerializer
        ).to_json
        expect(JSON.parse(response.body)['page']).to eq(JSON.parse(expected))
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when receiving user_id filter' do
      let!(:rents_user) { create_list(:rent, 3, user: user) }

      let!(:rents) { create_list(:rent, 3) } # rubocop:disable RSpec/LetSetup

      before do
        get :index, params: { user_id: user.id }
      end

      it 'responds with the rents json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          rents_user, each_serializer: RentSerializer
        ).to_json
        expect(JSON.parse(response.body)['page']).to eq(JSON.parse(expected))
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:book) { create(:book) }
      let(:user) { create(:user) }
      let(:http_request) do
        post :create, params: { rent: {
          user_id: user.id,
          book_id: book.id,
          from: Time.zone.today,
          to: Time.zone.tomorrow
        } }
      end

      it 'creates a new rent' do
        expect { http_request }.to change(Rent, :count).by(1)
      end

      it 'enqueues notification email' do
        expect { http_request }.to change { Sidekiq::Worker.jobs.size }.by(1)
      end

      it 'is properly serialized' do
        http_request
        expect(JSON.parse(response.body.to_json)).to include 'id'
        expect(JSON.parse(response.body.to_json)).to include 'to'
        expect(JSON.parse(response.body.to_json)).to include 'book'
        expect(JSON.parse(response.body.to_json)).to include 'user'
      end
    end

    context 'with invalid attributes' do
      let(:http_request) do
        post :create, params:  { rent: {
          from: Time.zone.today,
          to: Time.zone.tomorrow
        } }
      end

      it 'does not save the new rent' do
        expect { http_request }.not_to change(Rent, :count)
      end

      it 'responds with 422 status' do
        http_request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
