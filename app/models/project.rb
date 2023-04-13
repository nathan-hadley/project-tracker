class Project < ApplicationRecord
  has_many :project_assignments, dependent: :destroy
  has_many :members, through: :project_assignments

  validates :name, presence: true
end
