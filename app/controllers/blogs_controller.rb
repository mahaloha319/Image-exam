class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :request_login, only: [:new, :show, :edit]
  
  def index
    @blogs = Blog.order(:created_at).reverse_order #orderメソッド実行し、created_atの昇順でソートされる.reverse_orderは降順

  end
  
  def new
    if params[:back]
      @blog = current_user.blogs.new(blog_params)
    else
      @blog = current_user.blogs.new
    end
  end
  
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id  #現在ログインしているuserのidをblogのuser_idカラムに挿入
    
    #画像保存（create）の際、キャッシュから画像を復元してから保存する
    @blog.image.retrieve_from_cache! params[:cache][:image] if params[:cache][:image].present? # if画像選択したら
      if @blog.save
        BlogMailer.blog_mail(@blog).deliver
        redirect_to blogs_path, notice: "ブログを作成しました！"
      else
        render 'new'
      end
  end
  
  #BlogMailer.blog_mail(@blog).deliver   #投稿内容が保存された時にBlogMailerのblog_mailメソッドを呼び出す
  #blog_mail(@blog)で、blog_mailメソッドを呼び出す時、引数として@blog(投稿情報)を渡す
  
  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id) 
  end  
  
  def edit
  end
  
  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end 
  
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"
  end 
  
  def favorite
    @favorite = current_user.favorites.find_by(blog_id: params[:blog_id])
  end  
    
  def confirm
    @blog = current_user.blogs.new(blog_params)
    render :new if @blog.invalid?
  end  
    
  private
  def blog_params
    if params[:blog]
      params.require(:blog).permit(:title, :content, :image)
    else false
    end  
  end
  
  def set_blog
    @blog = Blog.find_by_id(params[:id])
  end 
end