class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # removed  :registerable, :rememberable


  devise :database_authenticatable,
         :recoverable, :trackable, :validatable
         #Should set a lockout with ips trying to hack?

end
