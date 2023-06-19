class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  def index
    @feeds = Feed.all
  end

  def show
    @favorite = current_user.favorites.find_by(feed_id: @feed.id)
  end

  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  def confirm
    @feed = current_user.feeds.build(feed_params)
    render :new if @feed.invalid?
  end

  def edit
  end

  def create
    @feed =  current_user.feeds.build(feed_params)
    if params[:back]
      render :new
    else
      if @feed.save
        redirect_to feeds_path, notice: "ブログを作成しました！"
      else
      render :new
      end
    end
  end

  def update
      if @feed.update(feed_params)
        redirect_to feeds_path, notice: "ブログを編集しました！"
      else
        render :edit
      end
  end

  def destroy
    @feed.destroy
    redirect_to feeds_path, notice: "ブログ削除しました！"
  end

  private
    
    def set_feed
      @feed = Feed.find(params[:id])
    end

    
    def feed_params
      params.require(:feed).permit(:content, :image, :image_cache)
    end
end
