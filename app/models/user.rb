class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable


if Rails.env.production?
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
else
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable 
end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :is_admin #not good CHANGEME
  # attr_accessible :title, :body
end
