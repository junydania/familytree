
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
      puts "Family Record must be loaded before you proceed. Exiting \n\n"
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
    puts "\n\n<<< Welcome to Indiana's Family Tree>>> \n\n"
    puts "This is an interactive guide to Identify Indiana's relatives. \n\n"
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
    print "Type 'quit' to exit \n"
    print "\n \n"
    received_input = Family.member_input
    if received_input != "Wrong Format" 
      if received_input[0][0].capitalize == "Person" and received_input[1][1].capitalize == "Sons" or received_input[1][1].capitalize == "Son"
        new_find = Relation.new(received_input)
        sons = new_find.has_sons
        if sons.length > 1
          sons_names = sons.join(", ")
          puts "#{received_input[1][1].capitalize}=#{sons_names}"
        elsif sons.empty? == true
          puts "#{received_input[0][1].capitalize} doesn't have sons"
        elsif sons.length == 1
          son_name = sons[0]
          puts "#{received_input[1][1].capitalize}=#{son_name}"
        end
      elsif received_input[0][0].capitalize == "Person" and received_input[1][1].capitalize == "Daughters" or received_input[1][1].capitalize == "Daughter"
        new_find = Relation.new(received_input)
        daughters = new_find.has_daughters
        if daughters.length > 1
          daughters_names = daughters.join(", ")
          puts "#{received_input[1][1].capitalize}=#{daughters_names}"
        elsif daughters.empty? == true
          puts "#{received_input[0][1].capitalize} doesn't have daughters"
        elsif daughters.length == 1
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
      elsif received_input[0][0].capitalize == "Person" and received_input[1][1].capitalize == "Mother"
        new_find = Relation.new(received_input)
        mother_name = new_find.has_mother
        puts "#{received_input[1][1].capitalize}=#{mother_name}"
      elsif received_input[0][0].capitalize == "Person" and received_input[1][1].capitalize == "Aunt" || received_input[1][1].capitalize == "Aunts"
        new_find = Relation.new(received_input)
        aunts = new_find.has_aunts
        if aunts.kind_of?(Array) == true
          if aunts.length > 1
            aunts_names = aunts.join(", ")
            puts "#{received_input[1][1].capitalize}=#{aunts_names}"
          elsif aunts.empty? == true
            puts "#{received_input[0][1].capitalize} doesn't have an aunt"
          elsif aunts.length == 1
            aunt_name = aunts[0]
            puts "#{received_input[1][1].capitalize}=#{aunt_name}"
          end
        else
          puts aunts
        end
      elsif received_input[0][0].capitalize == "Person" and received_input[1][1].capitalize == "Uncle" || received_input[1][1].capitalize == "Uncles"
        new_find = Relation.new(received_input)
        uncles = new_find.has_uncles
        if uncles.kind_of?(Array) == true
          if uncles.length > 1
            uncles_names = uncles.join(", ")
            puts "#{received_input[1][1].capitalize}=#{uncles_names}"
          else
            uncle_name = uncles[0]
            puts "#{received_input[1][1].capitalize}=#{uncle_name}"
          end
        else
          puts uncles
        end
      elsif received_input[0][0].capitalize == "Person" and received_input[1][1].capitalize == "Grandfather"
        new_find = Relation.new(received_input)
        grandfather_name = new_find.has_grandfather
        if grandfather_name != "No Grandfather"
            puts "#{received_input[1][1].capitalize}=#{grandfather_name}"
        else
            puts "#{received_input[0][1].capitalize} doesn't have a grandfather"
        end     
      elsif received_input[0][0].capitalize == "Person" and received_input[1][1].capitalize == "Grandmother"
        new_find = Relation.new(received_input)
        grandmother_name = new_find.has_grandmother
        if grandmother_name != "No Grandmother"
            puts "#{received_input[1][1].capitalize}=#{grandmother_name}"
        else
            puts "#{received_input[0][1].capitalize} doesn't have a grandmother"
        end     
      elsif received_input[0][0].capitalize == "Person" and received_input[1][1].capitalize == "Grandsons" or received_input[1][1].capitalize == "Grandson"
        new_find = Relation.new(received_input)
        grandsons = new_find.has_grandsons
        if grandsons.length > 1
          grandsons_names = grandsons.join(", ")
          puts "#{received_input[1][1].capitalize}=#{grandsons_names}"
        elsif grandsons.empty? == true
          puts "#{received_input[0][1].capitalize} doesn't have grandsons"
        elsif grandsons.length == 1
          grandson_name = grandsons[0]
          puts "#{received_input[1][1].capitalize}=#{grandson_name}"
        end 
      elsif received_input[0][0].capitalize == "Person" and received_input[1][1].capitalize == "Granddaughters" or received_input[1][1].capitalize == "Granddaughter"
        new_find = Relation.new(received_input)
        granddaughters = new_find.has_granddaughters
        if granddaughters.length > 1
          granddaughters_names = granddaughters.join(", ")
          puts "#{received_input[1][1].capitalize}=#{granddaughters_names}"
        elsif granddaughters.empty? == true
          puts "#{received_input[0][1].capitalize} doesn't have granddaughters"
        elsif granddaughters.length == 1
          granddaughter_name = granddaughters[0]
          puts "#{received_input[1][1].capitalize}=#{granddaughter_name}"
        end 
      elsif received_input[0][0].capitalize == "Husband" and received_input[1][1].capitalize == "Wife" or received_input[0][0].capitalize == "Person" and received_input[1][1].capitalize == "Wife"
        new_find = Relation.new(received_input)
        wife_name = new_find.has_wife
        if wife_name == "No Wife"
          puts "#{received_input[0][1].capitalize} doesn't have a wife"
        else  
          puts "#{received_input[1][1].capitalize}=#{wife_name}"
        end
      elsif received_input[0][0].capitalize == "Wife" and received_input[1][1].capitalize == "Husband" or received_input[0][0].capitalize == "Person" and received_input[1][1].capitalize == "Husband"
        new_find = Relation.new(received_input)
        husband_name = new_find.has_husband
        if husband_name == "No Husband"
          puts "#{received_input[0][1].capitalize} doesn't have an husband"
        else  
          puts "#{received_input[1][1].capitalize}=#{husband_name}"
        end
      else
        puts "Wrong Entry! Try again using the right format!!"
      end
    else
      puts "\n\n"
      puts "Wrong Input format! Enter Input in this format: Person=Bern Relation=Brothers"
      find
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
      mother_record = data.detect{ |mother| mother["name"] == mother_name  }
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


