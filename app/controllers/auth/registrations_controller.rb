class Auth::RegistrationsController < ApplicationController

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html { }# new.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        auto_login(@user)
        format.html { redirect_to(@user, :notice => 'Registration successful. Check your email for activation instructions.') }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

end
