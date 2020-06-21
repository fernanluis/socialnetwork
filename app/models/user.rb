class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable,
         :omniauth_providers => [:facebook]

  # Username no puede ser nulo ni estar vacío porque no pasaría la validación.
  # Campo username va a ser único a través de toda la tabla.
  validates :username, presence: true, uniqueness: true, length: {in: 3..12}

  def self.from_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first_or_create do |user|
      if auth[:info]
        user.email = auth[:info][:email] #lo comentamos y descomentamos. para forzar un error.
        user.name = auth[:info][:name]
      end
      user.password = Devise.friendly_token[0,20]
    end
  end
end
