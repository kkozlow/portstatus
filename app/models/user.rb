class User < ActiveRecord::Base
  acts_as_authentic
  
  def is_admin?
    self.username == 'admin'  
  end
  
end
