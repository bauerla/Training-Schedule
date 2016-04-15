class Video < ActiveRecord::Base
  belongs_to :event, :inverse_of => :event
  after_initialize :set_defaults, unless: :persisted?
  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i

  validates :link, presence: true, format: YT_LINK_FORMAT

  def set_defaults
    self.title  ||= ''
    self.published_at ||= DateTime.now
  end
end
