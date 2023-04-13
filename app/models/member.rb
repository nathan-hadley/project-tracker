class Member < ApplicationRecord
  belongs_to :team
  has_many :project_assignments
  has_many :projects, through: :project_assignments

  validates :first_name, presence: true
  validates :last_name, presence: true
end
