class TodoItem
  include Listable
  attr_reader :description, :due, :priority
	@@support_priority =["high", "medium", "low"]


  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
		@priority = options[:priority]
		unless is_valid?(@priority)
			raise UdaciListErrors::InvalidPriorityValue , "unknow priority type:#{options[:priority]}"
		end
  end
	def details
    format_description(@description) + "due: " +
    format_date(@due) +
    format_priority(@priority)
	end

	def change_priority(priority)
		if is_valid?(priority)
			@priority = priority
		else
			raise UdaciListErrors::InvalidPriorityValue , "unknow priority type:#{options[:priority]}"
		end
	end

	def is_valid?(priority)
		priority == nil || @@support_priority.include?(priority)
	end
end
