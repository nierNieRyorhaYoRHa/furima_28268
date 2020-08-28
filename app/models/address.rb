class Address < ApplicationRecord

  belongs_to :purchace, optional: true
end
