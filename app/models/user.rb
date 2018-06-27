class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


   has_and_belongs_to_many :roles 
   
   def role?( role ) 
     !roles.find_by_name( role.to_s.camelize ).nil?
   end 

  def active_for_authentication?
    self.is_superAdmin?
  end


  def is_superAdmin?
  	self.role? 'superAdmin'
  end

  def check_token

  end


  def create_token
    UserToken.where(user_id: self.id).destroy_all
    new_token = UserToken.create(user_id: self.id, token: SecureRandom.urlsafe_base64)
    new_token.token
  end
end
