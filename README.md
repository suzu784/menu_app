# 献立シェアアプリ

[menushareapp.com](https://menushareapp.com)

![スクリーンショット 2022-07-24 10 34 36](https://user-images.githubusercontent.com/85116099/180628569-1a5c8d90-aeac-4e3e-9f91-47fcac46e7fb.png)

## サイト概要
### サイトテーマ
- 作ってみたいと思う料理を献立表にコピーし、日付を指定して献立表に登録できる
- 自分が作って美味しかった料理を共有したい
- 料理動画が献立シェアアプリで見ながら調理できるため、
  動画サイトやレシピサイトで作りたい料理を検索が必要ないこと
- 自炊を継続したい、できるようにしたい人に向けてアプリを開発しました

### テーマを選んだ理由
- 一人暮らしをしている人が、献立に困らずに作りたい料理を可視化できれば
  便利だと考えたため
- 自分で上手く作れるか分からない時に、他の人が作っているのを見て、
  やってみたいという気持ちになれると考えたため

### ターゲットユーザ
- 一人暮らしをしている人
- 動画などを見ながら料理する人

### 主な利用シーン
- 料理前や料理中
- 金欠で自炊したいとき

## Gem
- devise
- kaminari
- rubocop-airbnb
- enum-help
- rails-i18n
- ransack
- google-api-client
- dotenv-rails
- rinku
- bullet
- cocoon
- gretel
- aws-sdk-s3

## 機能一覧

### 設計書
![献立シェアアプリ drawio](https://user-images.githubusercontent.com/85116099/177114247-3dc7c7c3-0a69-4528-947e-ed2dd60176b0.png)

### インフラ構成図
![AWS構成図 drawio (20)](https://user-images.githubusercontent.com/85116099/188300037-f9002341-c70c-4042-864a-2fb1a15a8b44.png)

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9