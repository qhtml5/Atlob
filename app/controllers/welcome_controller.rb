class WelcomeController < ApplicationController

def index 
 
    if current_user == nil
    
       redirect_to '/users/sign_in'
  
   end    
end 


end