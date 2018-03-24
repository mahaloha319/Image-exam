class FavoritesController < ApplicationController
  def create
    @favorite = current_user.favorites.create(blog_id: params[:blog_id])
    redirect_to blogs_url, notice: "#{@favorite.blog.user.name}さんのブログをお気に入り登録しました"
  end
 
  def show
    
    @user = User.find(params[:id])
    @favorite_blogs= @user.favorite_blogs
    
    
    #blogs_controllerの記述→ @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def destroy
    favorite = current_user.favorites.find_by(blog_id: params[:blog_id]).destroy
    redirect_to blogs_url, notice: "#{favorite.blog.user.name}さんのブログをお気に入り解除しました"
  end
end