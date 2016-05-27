class Calendar < Struct.new(:view, :date, :callback)
	HEADERS = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
	START_DAY = :monday

	# Reveal 'content_tag' object to the view
	delegate :content_tag, to: :view

	def table
		content_tag :table, class: "calendar table table-bordered" do
			header + week_rows
		end
	end

	def header
		content_tag :tr, class: "day_headers" do
			HEADERS.map { |day| content_tag :th, day }.join.html_safe
		end
	end

	def week_rows
		weeks.map do |week|
			content_tag :tr do
				week.map { |day| day_cell(day) }.join.html_safe
			end
		end.join.html_safe
	end

	def day_cell(day)
		content_tag :td,
								view.capture(day, &callback),
								class: day_classes(day),
								'data-link' => day_link(day)
	end

	def day_classes(day)
		# Add additional class names for current <td>
		classes = []
		classes << "event_day" if Event.day_count(day) > 0
		classes << "today" if day == Date.today
		classes << "not-in-month" if day.month != date.month
		classes.empty? ? nil : classes.join(" ")
	end

	# Set link for navigation to Daily controller
	def day_link(day)
		link = []
		if Event.day_count(day) > 0
			link << "/daily"
			link << "/"
			link << day.to_date.to_s
		end
		link.empty? ? nil : link.join("")
	end

	def weeks
		first = date.beginning_of_month.beginning_of_week(START_DAY)
		last = date.end_of_month.end_of_week(START_DAY)
		(first..last).to_a.in_groups_of(7)
	end
end
