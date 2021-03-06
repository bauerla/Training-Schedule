class Comment < ActiveRecord::Base
  belongs_to :event

  validates :commenter, presence: true, length: { minimum: 2 }
  validates :body, presence: true
end
