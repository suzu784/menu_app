require 'rails_helper'

describe '投稿のテスト' do
  let!(:post) { create(:post) }
  let!(:customer) { create(:customer) }
  describe 'トップ画面(root_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面にログインボタンが表示されているか' do
        expect(page).to have_link 'ログイン'
      end
    end
  end
  
  
# ログインの処理


  describe '投稿画面(new_post_path)のテスト' do
    before do
      visit new_post_path
    end
    context '表示の確認' do
      it 'new_post_pathが"/posts/new"であるか' do
        expect(current_path).to eq('/posts/new')
      end
      it '投稿ボタンが表示されているか'do
        expect(page).to have_button '投稿'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'post[:cook_name]', with: Faker::Lorem.characters(number:5)
        fill_in 'post[:opinion]', with: Faker::Lorem.characters(number:20)
        click_button '投稿'
        expect(page).to have_current_path post_path(Post.last)
      end
    end
  end

  describe '投稿一覧のテスト' do
    before do
      visit posts_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content post.cook_name
        expect(page).to have_link post.cook_name
      end
    end
  end

  describe '詳細画面のテスト' do
    before do
      visit post_path(post)
    end
    context '表示の確認' do
      it '削除リンクが表示されているか' do
        expect(page).to have_link '削除'
      end
      it '編集リンクが表示されているか' do
        expect(page).to have_link '編集'
      end
    end
    context 'post削除のテスト' do
      it 'postの削除' do
        expect{ post.destroy}.to change{ Post.count }.by(-1)
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      visit edit_post_path(post)
    end
    context '表示の確認' do
      it '編集前の料理名と感想がフォームに表示(セット)されているか' do
        expect(page).to have_field 'post[:cook_name]', with: post.cook_name
        expect(page).to have_field 'post[:opinion]', with: post.opinion
      end
      it '保存ボタンが表示される' do
        expect(page).to have_link '保存'
      end
    end
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'post[:cook_name]', with: Faker::Lorem.characters(number:5)
        fill_in 'post[:opinion]', with: Faker::Lorem.characters(number:20)
        click_button '保存'
        expect(page).to have_current_path post_path(post)
      end
    end
  end
end