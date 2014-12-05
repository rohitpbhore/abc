class ArticlesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @articles = @user.articles.create(article_params)
    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    @articles = @user.articles.find(params[:id])
    @articles.destroy
    respond_to do |format|
      format.html {redirect_to user_path(@user)}
      format.js
    end
  end

  private
    def article_params
      params.require(:article).permit(:text)
    end
end
