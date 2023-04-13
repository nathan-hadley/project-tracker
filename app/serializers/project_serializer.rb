class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :members
end
