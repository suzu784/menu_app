class Public::EventsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @post = Post.new
    render plain: render_to_string(partial: 'form_new', layout: false, locals: { post: @post })
    #views/eventsディレクトリのなかに_form_new.html.erb というファイルを作り
    #そのファイルの中のhtmlコードを文字として返す
  end

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      respond_to do |format|
        format.html { redirect_to events_path }
        format.js  #create.js.erbを探してその中の処理を実行する
      end
    else
      respond_to do |format|
      format.js { render partial: "error" }
        #登録にエラーが起きたときはerrors.js.erbを実行する
      end
    end
  end

  def post_params
    params.require(:post).permit(:cook_name, :opinion, :created_at, :media_url)
  end
end
