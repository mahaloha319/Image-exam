class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :request_login, only: [:new, :show, :edit]
  
  def index
    @blogs = Blog.all
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
      if @blog.save
        redirect_to blogs_path, notice: "ブログを作成しました！"
      else
        render 'new'
      end
  end
  
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
    params.require(:blog).permit(:title, :content)
  end
  
  def set_blog
    @blog = Blog.find_by_id(params[:id])
  end 
end