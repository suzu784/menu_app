require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:customer) { create(:customer) }
    let!(:post) { build(:post, customer_id: customer.id) }

    context 'cook_nameカラム' do
      it '空欄でないこと' do
        post.cook_name = ''
        is_expected.to eq false
      end
    end

    context 'opinionカラム' do
      it '200文字以下であること: 200文字は○' do
        post.opinion = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字は×' do
        post.opinion = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
  end
end
