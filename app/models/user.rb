class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :goals, dependent: :destroy

  validates :first_name, :last_name, :email, :password, presence: true
  validates :first_name, :last_name, length: {maximum: 127}
  validates :email, uniqueness: true, length: {maximum: 255}
  validates :password, length: {in: 6..72}
end
