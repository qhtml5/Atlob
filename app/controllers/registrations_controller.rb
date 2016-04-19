class RegistrationsController < Devise::RegistrationsController

private

  def sign_up_params
  
    params.require(:user).permit(:name,:gender, :avatar ,:email, :password, :password_confirmation)
  
  end

  def account_update_params
  
    params.require(:user).permit(:name,:gender, :email,:avatar, :password, :password_confirmation, :current_password)
  
  end


end