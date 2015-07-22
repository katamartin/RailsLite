require_relative '../phase8/controller_base'

module Phase9
  class ControllerBase < Phase8::ControllerBase
    def self.protect_from_forgery
      define_method(:forgery_protect) { true }
    end

    protect_from_forgery

    def initialize(req, res, route_params = {})
      super
      session[:authenticity_token] ||= generate_authenticity_token
    end

    def valid_authenticity_token?
      params[:authenticity_token] == session[:authenticity_token]
    end

    def form_authenticity_token
      session[:authenticity_token]
    end

    def generate_authenticity_token
      SecureRandom.urlsafe_base64(16)
    end
  end
end
