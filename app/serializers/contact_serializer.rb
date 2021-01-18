class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :birthdate

  def attributes(*args)
    h = super(*args)
    h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    h
  end
end
