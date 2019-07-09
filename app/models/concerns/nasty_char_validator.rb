
class Concerns::NastyCharValidator < ActiveModel::Validator
  VALID_CHARS_RE = /\A(\w|\d|\s|_|-|:|,|!|"|'|\(|\)|\+|\$|\?|\.)*\z/m

  INVALID_CHARS = 'contains invalid characters'

  def validate(record)
    record.attributes.each do |(name, value)|
      record.errors.add name, INVALID_CHARS if value.to_s !~ VALID_CHARS_RE
    end
  end
end

