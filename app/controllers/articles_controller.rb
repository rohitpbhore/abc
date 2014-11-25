class ArticlesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @articles = @user.articles.create(article_params)
    redirect_to user_path(@user)
  end

  private
    def article_params
      params.require(:article).permit(:text)
    end
end
