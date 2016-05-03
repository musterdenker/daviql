class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable

	has_and_belongs_to_many :queries

if Rails.env.production?
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
else
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :registerable, :omniauthable, omniauth_providers: [:google_oauth2]
end

  # Setup accessible (or protected) attributes for your model
#  attr_accessible :email, :password, :password_confirmation, :remember_me, :is_admin #not good CHANGEME
  # attr_accessible :title, :body


  def full_name
    "#{first_name} #{last_name}"
  end

end
