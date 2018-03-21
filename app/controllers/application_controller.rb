class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user, except: [:create, :logout]

    def current_controller
        params['controller'] ||= nil
    end

    def current_action
        params['action'] ||= nil
    end

    def current_user
      if session[:current_user]
        user_json = JSON.parse session[:current_user].to_json
        Hashie::Mash.new user_json 
      end  
    end

    def full_name
      current_user.first_name + " " + current_user.last_name unless current_user.blank?
    end

    def authenticate_merchant
      redirect_to root_path if current_user.blank?
    end

    helper_method [:current_user, :current_controller, :current_action, :full_name]
end
