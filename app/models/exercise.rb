class Exercise < ActiveRecord::Base
  belongs_to :event

  scope :exercise_count, -> (event) { where('event_id = ?', event).count }

  validates :desc, presence: true, length: { minimum: 5 }
  validates :duration, presence: true, :numericality => { only_integer: true, :greater_than_or_equal_to => 0 }
end
