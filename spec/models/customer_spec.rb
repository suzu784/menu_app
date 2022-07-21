require 'rails_helper'

Rspec.describe 'Customerモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { customer.valid? }
    
    let!(:other_customer) { create(:customer) }
    let!(:customer) { build(:customer) }
    
    context 'first_nameカラム' do
      it '空欄でないこと' do
        customer.first_name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        customer.first_name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は○' do
        customer.first_name = Faker::Lorem.characters(number:2)
        is_expected.to eq true
      end
    end
    context 'last_nameカラム' do
      it '空欄でないこと' do
        customer.last_name = ''
        is_expected.to eq false
      end
    end
  end
end
