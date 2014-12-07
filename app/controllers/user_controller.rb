class UserController < ApplicationController

  http_basic_authenticate_with name: "name", password: "password", only: :index

  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.csv #{ send_data @users.to_csv }
      format.xls #{ send_data @users.to_csv(col_sep: ",") }
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    # @user = User.find(params[:id])
    @user = User.where(id: params[:id]).includes(:articles)
    # binding.pry
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to user_index_path
  end

  private
    def user_params
      params.require(:user).permit(:name)
    end
end
