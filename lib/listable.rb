module Listable
  # Listable methods go here
	def format_description(description)
    "#{description}".ljust(30)
	end

	def format_priority(priority)
		case priority
			when "high"   then " ⇧".colorize(:red) 
			when "medium" then " ⇨".colorize(:yellow) 
			when "low"    then " ⇩".colorize(:blue) 
			else ""
		end
	end

  def format_date(start_date, end_date = nil)
    dates = start_date.strftime("%D") if start_date
    dates << " -- " + end_date.strftime("%D") if end_date
    dates = "No due date" if !dates
    return dates
  end

	def format_name(site_name)
    site_name ? site_name : ""
	end

end
