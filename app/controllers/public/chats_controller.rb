class Public::ChatsController < ApplicationController
  before_action :authenticate_customer!

  def show
    # どのカスタマーとチャットするか取得する
    @customer = Customer.find(params[:id])
    # カレントカスタマーのcustomer_roomsにあるroom_idの値の配列をroomsに代入。
    rooms = current_customer.customer_rooms.pluck(:room_id)
    # CustomerRoomモデルから
    # customer_idがチャット相手のidが一致するものと、
    # room_idが上記roomsのどれかに一致するレコードを
    # customer_roomsに代入。
    customer_rooms = CustomerRoom.find_by(customer_id: @customer.id, room_id: rooms)

      # もしcustomer_roomsが空でないなら
    unless customer_rooms.nil?
      # @roomに上記customer_roomsのroomを代入
      @room = customer_rooms.room
    else
      # それ以外は新しくroomを作
      @room = Room.new
      @room.save
      # customer_roomをカレントカスタマー分とチャット相手分を作る
      CustomerRoom.create(customer_id: current_customer.id, room_id: @room.id)
      CustomerRoom.create(customer_id: @customer.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_customer.chats.new(chat_params)
    render :validater unless @chat.save
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def reject_non_related
    customer = Customer.find(params[:id])
    unless current_customer.following?(customer) && customer.following?(current_customer)
      redirect_to posts_path
    end
  end

end
