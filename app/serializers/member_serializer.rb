class MemberSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :city, :state, :country
  belongs_to :team
  has_many :projects
end
