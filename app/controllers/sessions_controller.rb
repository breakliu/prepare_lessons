# coding: utf-8
class SessionsController < ApplicationController
  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, :notice => current_user.username+"登陆成功"
    else
      flash.now.alert = "用户名或密码错误"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "注销成功"
  end
end
