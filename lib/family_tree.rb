
require 'family'
require 'yaml'

class FamilyTree

  class Config
    @@actions = ['Add Family Member', 'Check Family Tree', 'quit']
    def self.actions; @@actions; end
  end

  def initialize(path=nil)
    Family.filepath = path
    if Family.file_useable?
      puts "Found Family Record"
    else
      puts "Family Record Must be loaded before you proceed. Exiting \n\n"
      exit!
    end
    Family.load_family_record
  end


  def launch!
    introduction
    result = nil
    until result == :quit
      action, args = get_action
      result = do_action(action, args)
    end

    conclusion

  end

   def introduction
    puts "\n\n<<< Welcome to the Indiana's Family Tree>>> \n\n"
    puts "This is an interactive guide to help you Identify your relatives. \n\n"
    puts "Type continue to Proceed. \n\n"
  end

  def get_action
    action = nil
    until FamilyTree::Config.actions.include?(action)
      puts "Actions: " + FamilyTree::Config.actions.join(", ") if action
      print ">"
      user_response = gets.chomp
      args = user_response.downcase.strip.split(' ')
      action = args.shift
    end
      return [action, args]
  end


  # def do_action(action,args=[])
  #   case action
  #   when 'list'
  #     list(args)
  #   when 'find'
  #     keyword = args.shift
  #     find(keyword)
  #   when 'add'
  #     add
  #   when 'quit'
  #     return :quit
  #   else
  #     puts "\nI don't understand that command. \n"
  #   end
  # end

  # def list(args=[])
  #   sort_order = args.shift
  #   sort_order ||= "name"
  #   sort_order = "name" unless ['name','cuisine', 'price'].include?(sort_order)
  #   output_action_header("Listing Restaurants")
  #   restaurant = Restaurant.saved_restaurants
  #   restaurant.sort! do |r1, r2|
  #     case sort_order
  #     when 'name'
  #       r1.name.downcase <=> r2.name.downcase
  #     when 'cuisine'
  #       r1.cuisine.downcase <=> r2.cuisine.downcase
  #     when 'price'
  #       r1.price.to_i <=> r2.price.to_i
  #     end
  #   end
  #   output_restaurant_table(restaurant)
  #   puts "Sort using: 'list cuisine'\n\n"
  # end

  # def find(keyword="")
  #   output_action_header("Find a restaurant")
  #   if keyword
  #       restaurants = Restaurant.saved_restaurants
  #       found = restaurants.select do |rest|
  #         rest.name.downcase.include?(keyword.downcase) ||
  #         rest.cuisine.downcase.include?(keyword.downcase) ||
  #         rest.price.to_i <= keyword.to_i
  #       end
  #       output_restaurant_table(found)

  #   else

  #     puts "Find using a key phrase to search the restaurant list."
  #     puts "Examples: find tamale', 'find mexican' \n\n"
  #   end

  # end


  def add
    puts "\nAdd New Family Member\n\n".upcase
      restaurant = Restaurant.build_from_questions
    if restaurant.save
      puts "\nRestaurant Added\n\n"
    else
      puts "\nSave Error: Restaurant not added \n\n"
    end
  end




 
  # def conclusion
  #   puts "\n<<< Goodbye and Bon Appetit! >>> \n\n\n"
  # end

  # private

  # def output_action_header(text)
  #   puts "\n#{text.upcase.center(60)}\n\n"
  # end

  # def output_restaurant_table(restaurants=[])
  #   print " " + "Name".ljust(30)
  #   print " " + "Cuisine".ljust(20)
  #   print " " + "Price".rjust(6) + "\n"
  #   puts "-" * 60
  #   restaurants.each do |rest|
  #     line = " " << rest.name.titleize.ljust(30)
  #     line << " " + rest.cuisine.titleize.ljust(20)
  #     line << " " + rest.formatted_price.rjust(6)
  #     puts line
  #   end
  #   puts "No listings found" if restaurants.empty?
  #   puts "-" * 60
  # end

end
