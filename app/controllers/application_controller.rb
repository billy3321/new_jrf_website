class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_catalog, :set_article_q, :set_injustice_keyword, :set_appeal_keyword

  def append_info_to_payload(payload)
    super
    payload[:request_id] = request.uuid
    payload[:user_id] = current_user.id if current_user
    if request.env['HTTP_CF_CONNECTING_IP']
      payload[:ip] = request.env['HTTP_CF_CONNECTING_IP']
    elsif request.env["HTTP_X_FORWARDED_FOR"]
      payload[:ip] = request.env["HTTP_X_FORWARDED_FOR"]
    else
      payload[:ip] = request.env['REMOTE_ADDR']
    end
  end

  private

  def set_catalog
    @catalogs = Catalog.includes(:categories).all
  end

  def set_article_q
    @article_q = Article.includes(:keywords).search(params[:q])
  end

  def set_injustice_keyword
    @injustice_keyword = Keyword.where(name: '我要申訴').first
  end

  def set_appeal_keyword
    @appeal_keyword = Keyword.where(name: '我要申冤').first
  end

  def after_sign_in_path_for(resource)
    if current_user.admin
      request.env['omniauth.origin'] || stored_location_for(resource) || admin_catalogs_path
    else
      sign_out current_user
      root_path
    end
  end

  def sanitize(html)
    Nokogiri::HTML(html).text
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
