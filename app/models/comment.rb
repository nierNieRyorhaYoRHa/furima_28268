class Comment < ApplicationRecord

  with_options presence: true do
    validates :text
  end

  belongs_to :item
  belongs_to :user

end
