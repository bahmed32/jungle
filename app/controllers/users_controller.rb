class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if !@user.valid?
      @user.errors.each do |error|
        attribute = error.attribute
        space = " "
        message = error.message
        redirect_to '/signup', notice: attribute.to_s + space + message
        return
      end
    else
      @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
