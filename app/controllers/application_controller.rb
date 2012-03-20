# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_authenticated
    redirect_to login_url, :alert => "请先登陆"
  end
end
