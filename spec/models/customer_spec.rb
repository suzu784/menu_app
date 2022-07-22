require 'rails_helper'

RSpec.describe 'Customerモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { customer.valid? }
    
    let(:other_customer) { create(:customer) } 
    let!(:customer) { build(:customer) }
    
    context 'first_nameカラム' do
      it '空欄でないこと' do
        customer.first_name = ''
        is_expected.to eq false
      end
      it '20文字以下であること: 20文字は◯' do
        customer.first_name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        customer.first_name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
    
    context 'last_nameカラム' do
      it '空欄でないこと' do
        customer.last_name = ''
        is_expected.to eq false
      end
      it '20文字以下であること: 20文字は○' do
        customer.last_name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること :21文字は×' do
        customer.last_name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
    
    context 'emailカラム' do
      it '一意性があること' do
        customer.email = other_customer.email
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end
end
