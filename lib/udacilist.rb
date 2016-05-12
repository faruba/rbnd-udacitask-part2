require_relative "./errors"
class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] ? options[:title] : "Untitled List"
    @items = []
  end
  def add(type, description, options={})
		case type.downcase
			when "todo"  then @items.push TodoItem.new(description, options)
			when "event" then @items.push EventItem.new(description, options)
			when "link"  then @items.push LinkItem.new(description, options) 
			else raise UdaciListErrors::InvalidItemType , "Invalid type: #{type}"
		end
  end
  def delete(index)
		if index <= 0 || index > @items.length
			raise UdaciListErrors::IndexExceedsListSize , "Array length:[#{@items.length}],out of range : #{index}"	
		else
			@items.delete_at(index - 1)
		end
  end
	def all
		print_items(@items)
	end

	def filter(type)
		result = @items.select{ |item| get_item_type(item) == type}
		if result.length == 0
			puts "sorry, you don't have #{type} type TODO item"
		else
			print_items(result, ">>>Filter By:#{type}<<<")
		end
	end

	def delete_multiple(*delete_index_list)
		result = []
		@items.each_with_index do |item, index|
			unless delete_index_list.include?(index)
				result << item
			end
		end
		@items = result
	end
	
	private
	def get_item_type(item)
		item.class.to_s.gsub("Item", "").downcase
	end

	def print_items(items, append_title = "")
		new_title = @title + "   " + append_title
		rows = []
		
		rows << ["Id",{:value => "Details", :alignment => :center},"type"]
    items.each_with_index do |item, position|
			rows << :separator
			rows << ["#{position + 1}", "#{item.details}", get_item_type(item)]
    end
		table = Terminal::Table.new(:rows => rows) 

    puts "-" * new_title.length
    puts new_title
		puts table
	end
end
