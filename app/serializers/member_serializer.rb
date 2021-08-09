class MemberSerializer < BaseSerializer
  attributes :first_name, :last_name, :url, :short_url

  has_many :friends, serializer: :member
end
