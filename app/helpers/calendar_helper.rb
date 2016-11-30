require 'calendar'

# Calendar helper module for creating Calendar view
module CalendarHelper
	def calendar(date = Date.today, &block)
		Calendar.new(self, date, block).table
	end
end
