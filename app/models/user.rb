class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :confirmable,
         :lockable,
         :recoverable,
         :rememberable,
         :validatable,
         :timeoutable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2, :vkontakte]

  # Add password requirements:

  validate :password_complexity

  def password_complexity
    if password.present? and not password.match(/(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])/)
      errors.add :password, " должен включать в себя как минимум одну строчную букву, одну заглавную букву и одну цифру"
    end
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the
      # user model has an image
    # If you are using confirmable and the provider(s) you use validate emails,
    # uncomment the line below to skip the confirmation emails.
    user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
