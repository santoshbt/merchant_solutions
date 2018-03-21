class AuthenticateController < ApplicationController
    require 'hashie'

    def login
        redirect_to homepage_path unless current_user.blank?
    end

    def create      
        reset_session
        session[:current_user] = nil
        if !params[:auth][:email].blank? && !params[:auth][:password].blank? \
                && !params[:auth][:subdomain].blank?

            _login = LoanHero.merchant_login params[:auth]
            if _login[:status] == "200"
                session[:current_user] = _login[:body]
                flash[:success] = "Logged in successfully"
                redirect_to homepage_path
            else
                flash[:error] = _login[:message]
                render 'login'
            end
        else
            flash[:error] = "Please provide all the required details"
            render 'login'
        end    
    end

    def logout        
        reset_session
        session[:current_user] = nil   
        flash[:success] = "Logged out successfully"
        redirect_to root_path             
    end

end
