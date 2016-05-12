require_relative "./errors"
class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
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
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end
