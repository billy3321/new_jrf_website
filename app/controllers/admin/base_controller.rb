class Admin::BaseController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  before_action :require_admin, :set_system_articles

  private

  def require_admin
    unless current_user.admin?
      sign_out current_user
      redirect_to '/'
    end
  end

  def set_system_articles
    @about_article = Article.where(kind: 'system', system_type: 'about').first
    @donate_article = Article.where(kind: 'system', system_type: 'donate').first
  end

end