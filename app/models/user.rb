# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  username               :string           default(""), not null
#  name                   :string
#  last_name              :string
#  bio                    :text
#  uid                    :string
#  provider               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  mount_uploader :image, PictureUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable,
         :omniauth_providers => [:facebook]

  validate :picture_size # el método ' picture_size ' en los requisitos de validación para el modelo de Usuario .
  # Username no puede ser nulo ni estar vacío porque no pasaría la validación.
  # Campo username va a ser único a través de toda la tabla.
  validates :username, presence: true, uniqueness: true, length: {in: 3..12}
  validate :validate_username_regex

  has_many :posts # Generamos la relación uno a muchos.

  def self.from_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first_or_create do |user|
      if auth[:info]
        user.email = auth[:info][:email] #lo comentamos y descomentamos. para forzar un error.
        user.name = auth[:info][:name] # asumiendo que el modelo user tiene un nombre
        user.last_name = auth[:info][:last_name] # asumiendo que el modelo user tiene un apellido
        user.image = auth[:info][:image] #asumiendo que el modelo user tiene una imagen.
      else
      user.password = Devise.friendly_token[0,20]
      end
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info'])
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  private
  def validate_username_regex
    unless username =~ /\A[a-zA-Z]*[a-zA-Z][a-zA-Z0-9_]*\z/
      errors.add(:username, "El username debe iniciar con una letra")
      errors.add(:username, "El username sólo puede contener _, letras y números.")
    end
  end

  # Validates the size of an uploaded picture.
  # picture_size ' que devuelve un error si la imagen cargada es mayor a 1 megabyte.
  def picture_size
    errors.add(:image, 'should be less than 1MB') if image.size > 1.megabytes
  end

end
