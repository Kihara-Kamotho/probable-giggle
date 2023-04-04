class User < ApplicationRecord
  rolify
  after_create :assign_default_role

  has_many :notifications, as: :recipient, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def assign_default_role
    return unless roles.blank?

    add_role :member
  end
end
