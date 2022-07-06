class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!
end
