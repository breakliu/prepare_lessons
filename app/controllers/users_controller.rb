# coding: utf-8
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      auto_login(@user)
      redirect_to root_url, :notice => current_user.username+"注册成功"
    else
      render :new
    end
  end
end
