class Admin::SessionsController < ApplicationController
    
    protected
    
    layout 'admin/layouts/sessions'
    

    public
    
    # render new.rhtml
    def new
    end

    def create
        self.current_account = Account.authenticate(params[:login], params[:password])
        
        if logged_in?
            if params[:remember_me] == "1"
                self.current_account.remember_me
                cookies[:auth_token] = { :value => self.current_account.remember_token , :expires => self.current_account.remember_token_expires_at }
            end

            flash[:notice] = "Logged in successfully."
            redirect_back_or_default(admin_root_url)
        else
            flash[:notice] = "Access denied."
            render :action => 'new'
        end

    end

    def destroy
        self.current_account.forget_me if logged_in?
        cookies.delete :auth_token
        reset_session
        
        flash[:notice] = "You have been logged out."
        redirect_back_or_default(admin_root_url)
    end
end
