class UsersController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update]
    before_action :correct_user,   only: [:edit, :update]
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]

    def index
        @users = User.paginate(page: params[:page])
    end
  def new
  	 @user = User.new
  end
  def show
  	@user = User.find(params[:id])
    @entries = @user.entry.paginate(page: params[:page])
  end
 def create
    @user = User.new(user_params)
    if @user.save
     flash[:success] = "Sign up successful!"
     log_in @user
     redirect_to user_path(@user)
    else
      render 'new'
    end
  end

def edit
    @user = User.find(params[:id])
  end

 def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
     flash[:success] = "Profile updated"
      redirect_to @user

    else
      render 'edit'
    end
  end
 

  def correct_user
     @user = User.find(params[:id])
     redirect_to(root_url) unless current_user?(@user)

  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
