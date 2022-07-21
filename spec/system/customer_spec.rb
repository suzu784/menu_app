require 'rails_helper'

describe '会員のテスト' do
  let!(:customer) { create(:customer) }
  describe '会員一覧のテスト' do
    before do
      customers_path
    end
    context '表示の確認' do
    end
  end
end