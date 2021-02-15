class ApplicationController < ActionController::Base

    helper_method :signed_in?, :current_user
    
    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def signed_in?
        !!current_user
    end

    def sign_in!(user)
        @current_user = current_user
        session[:session_token] = user.reset_session_token!
    end

    def sign_out!
        current_user.reset_session_token!
        session[:session_token] = nil
    end

    def require_signed_in
        redirect_to new_session_url unless signed_in?
    end

    def current_sub 
        @sub = Sub.find_by(title: )
    end

    def require_moderator 
        current_user.id == @sub.moderator
    end
end
