# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => '你没有权限访问'
  end
  
  def not_authenticated
    redirect_to login_url, :alert => "请先登陆"
  end
end
