class TodoItem
  include Listable
	include UdaciListErrors
  attr_reader :description, :due, :priority
	@@support_priority =["high", "medium", "low"]


  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Date.parse(options[:due]) : options[:due]
		@priority = options[:priority]
		if @priority != nil && @@support_priority.index(options[:priority]) == nil
			raise InvalidPriorityValue , "unknow priority type:#{options[:priority]}"
		end
  end
	def details
    format_description(@description) + "due: " +
    format_date(@due) +
    format_priority(@priority)
	end
end
