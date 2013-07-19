class User < ActiveRecord::Base
  acts_as_authentic

  #attr_accessible zawsze to dawaj

  has_and_belongs_to_many :devices
  
  def is_admin?
    self.username == 'admin'  
  end
  
end
