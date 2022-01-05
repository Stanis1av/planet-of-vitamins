class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

# Add password requirements:

validate :password_complexity

def password_complexity
  if password.present? and not password.match(/(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])/)
    errors.add :password, " должен включать в себя как минимум одну строчную букву, одну заглавную букву и одну цифру"
  end
end

end
