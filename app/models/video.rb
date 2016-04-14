class Video < ActiveRecord::Base
  belongs_to :event, :inverse_of => :event

  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.title  ||= 'video'
    self.link ||= ''
    self.published_at ||= DateTime.now
  end
end
