class HomepageController < ApplicationController
  before_action :authenticate_merchant
  
  def index    
    puts current_user.inspect
  end
end
