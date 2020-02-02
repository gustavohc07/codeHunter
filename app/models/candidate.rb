# frozen_string_literal: true

class Candidate < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile
  has_many :applications
  has_many :jobs, through: :applications
  has_many :proposals, through: :applications
end
