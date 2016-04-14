class Event < ActiveRecord::Base
	has_many :exercises, dependent: :destroy
	has_one :video, dependent: :destroy
	accepts_nested_attributes_for :exercises, :video, allow_destroy: true

	# return how many events per day
	scope :day_count, -> (day) { where('date(starttime) = ?', day).count }
	scope :daily_events, -> (day) { where('date(starttime) = ?', day) }

	# add the accessors for the fields
	attr_accessor :starttime_date, :starttime_time, :endtime_date, :endtime_time

	# validation
	validates :title, presence: true,
		length: { minimum: 5 }
	validates_format_of :starttime_time, :endtime_time, :with => /\d{1,2}:\d{2}/

	# callbacks to datetime values
	after_initialize :get_datetimes # convert db format to accessors
	before_validation :set_datetimes # convert accessors back to db format

	protected
	def get_datetimes
		self.starttime ||= Time.now  # if the starttime time not set, set it to now
		self.endtime ||= self.starttime + 60*60 # if the endtime not set increment hour from starttime

		self.starttime_date ||= self.starttime.to_date.to_s(:db) # extract the date is yyyy-mm-dd format
		self.starttime_time ||= "#{'%02d' % self.starttime.hour}:#{'%02d' % self.starttime.min}" # extract the time

		self.endtime_date ||= self.endtime.to_date.to_s(:db) # extract the date is yyyy-mm-dd format
		self.endtime_time ||= "#{'%02d' % self.endtime.hour}:#{'%02d' % self.endtime.min}" # extract the time
	end

	def set_datetimes
		self.starttime = "#{self.starttime_date} #{self.starttime_time}:00" # convert the two fields back to db
		self.endtime = "#{self.endtime_date} #{self.endtime_time}:00" # convert the two fields back to db
	end

end
