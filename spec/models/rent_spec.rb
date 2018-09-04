require 'rails_helper'

describe Rent do
  subject(:rent) { build(:rent) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:book) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:from) }
  it { is_expected.to validate_presence_of(:to) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:book) }
  it { expect(rent.to).to be > rent.from }

  context 'when "to date" is lesser than "from date"' do
    subject(:invalid) { build(:rent, to: Time.zone.yesterday) }

    it 'is invalid' do
      expect(invalid).not_to be_valid
    end
  end
end
