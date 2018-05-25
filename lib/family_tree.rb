
require 'yaml'
require 'person'
require 'family'
require 'relation'
require 'pry'

class FamilyTree

  class Config
    @@actions = ['add member', 'find', 'quit']
    def self.actions 
      @@actions 
    end
  end

  def initialize(path=nil)
    Family.filepath = path
    if Family.file_useable?
      puts "Found Family Record"
      Family.load_family_record
    else
      puts "Family Record Must be loaded before you proceed. Exiting \n\n"
      exit!
    end
  end

  def launch!
    introduction
    result = nil
    until result == :quit
      action = get_action
      result = do_action(action)
    end
    conclusion
  end

  def introduction
    puts "\n\n<<< Welcome to the Indiana's Family Tree>>> \n\n"
    puts "This is an interactive guide to help you Identify your relatives. \n\n"
    puts "Tap Enter to Proceed. \n\n"
 end

  def get_action
    action = nil
    until FamilyTree::Config.actions.include?(action)
      puts "Actions: " + FamilyTree::Config.actions.join(", ") if action
      print ">"
      user_response = gets.chomp
      entry = user_response.downcase
      action = entry
    end
    return action
  end

  def do_action(action)
    case action
    when 'find'
      find
    when 'add member'
      add
    when 'quit'
      return :quit
    else
      puts "\nI don't understand that command. \n"
    end
  end

  def find
    puts "\nFind Family Member\n\n".upcase
    print "Find Family Member in this format - "
    print "Person=Sophia Relation=Husband \n"
    received_input = Family.member_input
    if received_input[0][0].capitalize == "Person" and received_input[1][1].capitalize == "Sons" or received_input[1][1].capitalize == "Son"
      new_find = Relation.new(received_input)
      sons = new_find.has_sons
      if sons.length > 1
        sons_names = sons.join(", ")
        puts "#{received_input[1][1].capitalize}=#{sons_names}"
      else
        son_name = sons[0]
        puts "#{received_input[1][1].capitalize}=#{son_name}"
      end
    elsif received_input[0][0].capitalize == "Person" and received_input[1][1].capitalize == "Daughters" or received_input[1][1].capitalize == "Daughter"
      new_find = Relation.new(received_input)
      daughters = new_find.has_daughters
      if daughters.length > 1
        daughters_names = daughters.join(", ")
        puts "#{received_input[1][1].capitalize}=#{daughters_names}"
      else
        daughter_name = daughters[0]
        puts "#{received_input[1][1].capitalize}=#{daughter_name}"
      end
    elsif received_input[0][0].capitalize == "Person" and received_input[1][1].capitalize == "Brothers" or received_input[1][1].capitalize == "Brother"
      new_find = Relation.new(received_input)
      brothers = new_find.has_brothers
      if brothers.length > 1
        brothers_names = brothers.join(", ")
        puts "#{received_input[1][1].capitalize}=#{brothers_names}"
      else
        brother_name = brothers[0]
        puts "#{received_input[1][1].capitalize}=#{brother_name}"
      end
    elsif received_input[0][0].capitalize == "Person" and received_input[1][1].capitalize == "Sisters" or received_input[1][1].capitalize == "Sister"
      new_find = Relation.new(received_input)
      sisters = new_find.has_sisters
      if sisters.length > 1
        sisters_names = sisters.join(", ")
        puts "#{received_input[1][1].capitalize}=#{sisters_names}"
      else
        sister_name = sisters[0]
        puts "#{received_input[1][1].capitalize}=#{sister_name}"
      end
    elsif received_input[0][0].capitalize == "Person" and received_input[1][1].capitalize == "Cousins" or received_input[1][1].capitalize == "Cousin"
      new_find = Relation.new(received_input)
      cousins = new_find.has_cousins
      if cousins.length > 1
        cousins_names = cousins.join(", ")
        puts "#{received_input[1][1].capitalize}=#{cousins_names}"
      else
        cousin_name = cousins[0]
        puts "#{received_input[1][1].capitalize}=#{cousin_name}"
      end
    elsif received_input[0][0].capitalize == "Person" and received_input[1][1].capitalize == "Father"
      new_find = Relation.new(received_input)
      father_name = new_find.has_father
      puts "#{received_input[1][1].capitalize}=#{father_name}"
    end
  end



  def add
    puts "\nAdd New Family Member\n\n".upcase
    print "Enter a new family member in the format"
    print "Mother=Sophia Son=Thomas \n"
    received_input = Family.member_input
    if received_input[0][0].capitalize == "Husband" and received_input[1][0].capitalize == "Wife"
      sex = "Female"
      husband_name = received_input[0][1].capitalize
      data = Family.load_family_record
      husband_record = data.detect{ |husband| husband["name"] == husband_name  }
      if husband_record != nil 
        wife_name = received_input[1][1].capitalize
        new_person = Person.new(wife_name, sex)
        parent_partner_id = husband_record["partner_id"]
        new_member = { "name" => new_person.name,
                        "sex" => new_person.sex,
                        "root_id" => '',
                        "parent_id" => parent_partner_id,
                        "partner_id" => parent_partner_id            
        }
        Family.save(new_member, wife_name)          
      else
        puts "#{husband_name} is not a member of this family!"
        exit!
      end
    elsif received_input[0][0].capitalize == "Wife" and received_input[1][0].capitalize == "Husband"
      sex = "Male"
      wife_name = received_input[0][1].capitalize
      data = Family.load_family_record
      wife_record = data.detect{ |wife| wife["name"] == wife_name  }
      if wife_record != nil 
        husband_name = received_input[1][1].capitalize
        new_person = Person.new(husband_name, sex)
        parent_partner_id = wife_record["partner_id"]
        new_member = { "name" => new_person.name,
                        "sex" => new_person.sex,
                        "root_id" => '',
                        "parent_id" => parent_partner_id,
                        "partner_id" => parent_partner_id            
        }
        Family.save(new_member, husband_name)
      else
        puts "#{wife_name} is not a member of this family!"
        exit!
      end
    elsif received_input[0][0].capitalize == "Mother" and received_input[1][0].capitalize == "Son"
      sex = "Male"
      mother_name = received_input[0][1].capitalize
      data = Family.load_family_record
      mother_record = data.detect{ |wife| mother["name"] == mother_name  }
      if mother_record != nil 
        son_name = received_input[1][1].capitalize
        new_person = Person.new(son_name, sex)
        root_id = mother_record["partner_id"]
        parent_partner_id = new_person.generate_parent_partner_id 
        new_member = { "name" => new_person.name,
                        "sex" => new_person.sex,
                        "root_id" => root_id,
                        "parent_id" => parent_partner_id,
                        "partner_id" => parent_partner_id            
        }
        Family.save(new_member, son_name)
      else
        puts "#{son_name} is not a member of this family!"
        exit!
      end        
    end
  end

  def conclusion
    puts "\n<<< Goodbye >>> \n\n\n"
  end

end


