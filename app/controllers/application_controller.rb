class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  # before_action :cors_preflight_check
  # after_action :cors_set_access_control_headers
  #
  # def handle_options_request
  #   render :text => '', :content_type => 'text/plain'
  # end

  protected

  # def cors_preflight_check
  #   if request.method == 'OPTIONS'
  #     headers['Access-Control-Allow-Origin'] = '*'
  #     headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
  #     headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token, Content-Type'
  #     headers['Access-Control-Max-Age'] = '1728000'
  #
  #     render text: '', content_type: 'text/plain'
  #   end
  # end
  #
  # def cors_set_access_control_headers
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
  #   headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
  #   headers['Access-Control-Max-Age'] = "1728000"
  # end
end
