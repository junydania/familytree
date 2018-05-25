
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
      family_member = Family.build_from_input
      if family_member[0][0].capitalize == "Husband" and family_member[1][0].capitalize == "Wife"
        sex = "Female"
        husband_name = family_member[0][1].capitalize
        data = Family.load_family_record
        husband_record = data.detect{ |husband| husband["name"] == husband_name  }
        if husband_record != nil 
          wife_name = family_member[1][1].capitalize
          new_person = Person.new(wife_name, sex)
          parent_partner_id = husband_record["partner_id"]
          new_member = { "name" => new_person.name,
                         "sex" => new_person.sex,
                         "root_id" => '',
                         "parent_id" => parent_partner_id,
                         "partner_id" => parent_partner_id            
          }
          Family.save(new_member, wife_name)          
        elsif husband_record == nil 
          puts "#{husband_name} is not a member of this family!"
          exit!
        end
      elsif family_member[0][0].capitalize == "Wife" and family_member[1][0].capitalize == "Husband"
        sex = "Male"
        wife_name = family_member[0][1].capitalize
        data = Family.load_family_record
        wife_record = data.detect{ |wife| wife["name"] == wife_name  }


      end









    if restaurant.save
      puts "\nRestaurant Added\n\n"
    else
      puts "\nSave Error: Restaurant not added \n\n"
    end
  end


  def conclusion
    puts "\n<<< Goodbye >>> \n\n\n"
  end

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
