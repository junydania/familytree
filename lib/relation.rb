require 'family'

class Relation

    attr_accessor :person, :person_name, :relation, :relationship_type

    @@family_record = nil 

    def initialize(received_input=[])
        @person = received_input[0][0]
        @person_name = received_input[0][1]
        @relation = received_input[1][0]
        @relationship_type = received_input[1][1]
        @@family_record = Family.load_family_record
    end


    def add_wife
      add_status= nil
      husband_name = @person_name.capitalize
      husband_record = @@family_record.detect{ |husband| husband["name"] == husband_name  }
      if husband_record != nil 
        wife_name =  @relationship_type.capitalize
        new_person = Person.new(@relationship_type, "Female")
        husband_partner_id = husband_record["partner_id"]
        new_member = { "name" => new_person.name,
                        "sex" => new_person.sex,
                        "root_id" => '',
                        "parent_id" => husband_partner_id,
                        "partner_id" => husband_partner_id            
        }
        add_status = Family.save(new_member)     
      else
        add_status= nil
      end
        return add_status
    end

    def add_husband
        add_status= nil
        wife_name = @person_name.capitalize
        wife_record = @@family_record.detect{ |wife| wife["name"] == wife_name  }
        if wife_record != nil 
            husband_name =  @relationship_type.capitalize
            new_person = Person.new(@relationship_type, "Male")
            wife_partner_id = wife_record["partner_id"]
            new_member = { "name" => new_person.name,
                            "sex" => new_person.sex,
                            "root_id" => '',
                            "parent_id" => wife_partner_id,
                            "partner_id" => wife_partner_id            
            }
            add_status = Family.save(new_member)     
        else
            add_status= nil
        end
            return add_status
    end

    def add_son
        add_status= nil
        mother_name = @person_name.capitalize
        mother_record = @@family_record.detect{ |mother| mother["name"] == mother_name  }
        if mother_record != nil 
            son_name =  @relationship_type.capitalize
            new_person = Person.new(@relationship_type, "Male")
            mother_parent_id = mother_record["parent_id"]
            new_parent_partner_id = new_person.generate_parent_partner_id 
            new_member = { "name" => new_person.name,
                            "sex" => new_person.sex,
                            "root_id" => mother_parent_id,
                            "parent_id" => new_parent_partner_id,
                            "partner_id" => new_parent_partner_id            
            }
            add_status = Family.save(new_member)     
        else
            add_status= nil
        end
            return add_status
    end

    def add_daughter
        add_status= nil
        mother_name = @person_name.capitalize
        mother_record = @@family_record.detect{ |mother| mother["name"] == mother_name  }
        if mother_record != nil 
            daughter_name =  @relationship_type.capitalize
            new_person = Person.new(@relationship_type, "Female")
            mother_parent_id = mother_record["parent_id"]
            new_parent_partner_id = new_person.generate_parent_partner_id 
            new_member = { "name" => new_person.name,
                            "sex" => new_person.sex,
                            "root_id" => mother_parent_id,
                            "parent_id" => new_parent_partner_id,
                            "partner_id" => new_parent_partner_id            
            }
            add_status = Family.save(new_member)     
        else
            add_status= nil
        end
            return add_status
    end

    def has_sons
        sons_array = []
        person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
        person_parent_id = person_record["parent_id"]
        sons = @@family_record.find_all { |son| son["root_id"] == person_parent_id && son["sex"] == "Male" }
        if sons.any? == true
            sons.each do |son|
                son.each do |key, value|
                    if key == "name"
                        sons_array.push(value)
                    end
                end
            end
        else
            sons_array = []
        end
        return sons_array 
    end

    def has_daughters
        daughters_array = []
        person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
        person_parent_id = person_record["parent_id"]
        daughters = @@family_record.find_all { |daughter| daughter["root_id"] == person_parent_id && daughter["sex"] == "Female" }
        if daughters.any? == true
            daughters.each do |daughter|
                daughter.each do |key, value|
                    if key == "name"
                        daughters_array.push(value)
                    end
                end
            end            
        else
            daughters_array= []
        end
        return daughters_array 
    end

    
    def has_brothers
        brothers_array = []
        person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
        person_root_id = person_record["root_id"]
        brothers = @@family_record.find_all { |brother| brother["root_id"] == person_root_id && brother["name"] != @person_name && brother["sex"] == "Male"}
        if brothers.any? == true
            brothers.each do |brother|
                brother.each do |key, value|
                    if key == "name"
                        brothers_array.push(value)
                    end
                end
            end
        else
            brothers_array = []
        end
        return brothers_array    
    end

    def has_sisters
        sisters_array = []
        person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
        person_root_id = person_record["root_id"]
        sisters = @@family_record.find_all { |sister| sister["root_id"] == person_root_id && sister["name"] != @person_name && sister["sex"] == "Female"}
        if sisters.any? == true 
            sisters.each do |sister|
                sister.each do |key, value|
                    if key == "name"
                        sisters_array.push(value)
                    end
                end
            end
        else
            sisters_array = []
        end

        return sisters_array     
    end

    def has_cousins
        cousins_array = []
        first_person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
        first_person_root_id = first_person_record["root_id"]
        parent_tree = @@family_record.find_all { |parent| parent["parent_id"] == first_person_root_id }
        parent_upper_level_root_id = []
        parent_tree.each do |parent|
            parent.each do |key, value|
                if key == "root_id"
                    parent_upper_level_root_id.push(value)
                end
            end
        end
        parent_root_id = nil
        parent_root = parent_upper_level_root_id.each do |root_id|
                        unless root_id.nil?
                            parent_root_id = root_id
                        end
                      end
        parent_name = @@family_record.detect { |parent| parent["root_id"] == parent_root_id && parent["parent_id"] == first_person_root_id }
        parent_siblings = @@family_record.find_all { |sibling| sibling["root_id"] == parent_root_id && sibling["name"] != parent_name }
        siblings_id_array = []
        parent_siblings_parent_id = parent_siblings.each do |sibling|
                                        sibling.each do| key, value|
                                            if key == "parent_id"
                                                siblings_id_array.push(value)
                                            end
                                        end
                                    end
        siblings_id_array.each do |parent_id|
            cousins_record = @@family_record.find_all { |cousin| cousin["root_id"] == parent_id && cousin["name"] !=  @person_name }
            if cousins_record.any? == true
                cousins_record.each do |cousin|
                    cousin.each do |key, value|
                        if key == "name"
                            cousins_array.push(value)
                        end
                    end
                end
            else
                cousins_array = []
            end
        end
        return cousins_array      
    end

    def has_father
        father_name = nil
        person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
        person_root_id = person_record["root_id"]
        if person_root_id.nil? == false
            father_record = @@family_record.detect { |father| father["parent_id"] == person_root_id && father["sex"] == "Male"}
            father_name = father_record["name"]
        else
            father_name
        end

        return father_name        
    end

    def has_mother
        mother_name = nil
        person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
        person_root_id = person_record["root_id"]
        if person_root_id.nil? == false
            mother_record = @@family_record.detect { |mother| mother["parent_id"] == person_root_id && mother["sex"] == "Female"}
            mother_name = mother_record["name"]
        else
            mother_name
        end

        return mother_name
    end

    def has_aunts
        aunts_array = []
        first_person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
        first_person_root_id = first_person_record["root_id"]
        parent_tree = @@family_record.find_all { |parent| parent["parent_id"] == first_person_root_id }
        parent_upper_level_root_id = []
        parent_tree.each do |parent|
            parent.each do |key, value|
                if key == "root_id"
                    parent_upper_level_root_id.push(value)
                end
            end
        end
        parent_root_id = nil
        parent_root = parent_upper_level_root_id.each do |root_id|
                        unless root_id.nil?
                            parent_root_id = root_id
                        end
                      end
        parent_name = @@family_record.detect { |parent| parent["root_id"] == parent_root_id && parent["parent_id"] == first_person_root_id }
        parent_siblings = @@family_record.find_all { |sibling| sibling["root_id"] == parent_root_id && sibling["name"] != parent_name && sibling["sex"].capitalize == "Female" }
        if parent_siblings.any? == true
            parent_siblings.each do |parent_sibling|
                parent_sibling.each do |key, value|
                    if key == "name"
                        aunts_array.push(value)
                    end
                end
            end 
        else
            aunts_array = []
        end   

        return aunts_array          
    end

    def has_uncles
        uncles_array = []
        first_person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
        first_person_root_id = first_person_record["root_id"]
        parent_tree = @@family_record.find_all { |parent| parent["parent_id"] == first_person_root_id }
        parent_upper_level_root_id = []
        parent_tree.each do |parent|
            parent.each do |key, value|
                if key == "root_id"
                    parent_upper_level_root_id.push(value)
                end
            end
        end
        parent_root_id = nil
        parent_root = parent_upper_level_root_id.each do |root_id|
                        unless root_id.nil?
                            parent_root_id = root_id
                        end
                        end
        parent_name = @@family_record.detect { |parent| parent["root_id"] == parent_root_id && parent["parent_id"] == first_person_root_id }
        parent_siblings = @@family_record.find_all { |sibling| sibling["root_id"] == parent_root_id && sibling["name"] != parent_name && sibling["sex"].capitalize == "Male" }
        if parent_siblings.any? == true
            parent_siblings.each do |parent_sibling|
                parent_sibling.each do |key, value|
                    if key == "name"
                        uncles_array.push(value)
                    end
                end
            end 
            return uncles_array
        else
            return "#{@person_name} doesn't have an uncle"
        end             
    end

    def has_grandfather
        grandfather_name = nil
        first_person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
        first_person_root_id = first_person_record["root_id"]
        parent_tree = @@family_record.find_all { |parent| parent["parent_id"] == first_person_root_id }
        parent_upper_level_root_id = []
        parent_tree.each do |parent|
            parent.each do |key, value|
                if key == "root_id"
                    parent_upper_level_root_id.push(value)
                end
            end
        end
        parent_root_id = nil
        if parent_upper_level_root_id[0] == nil && parent_upper_level_root_id[1] == nil 
            return "No Grandfather"
        else
            parent_upper_level_root_id.each do |root_id|
                unless root_id.nil?
                    parent_root_id = root_id
                end
            end
            grandfather = @@family_record.detect{ |grandfather| grandfather["parent_id"] == parent_root_id && grandfather["sex"] == "Male" }
            grandfather_name = grandfather["name"]
            return grandfather_name                   
        end     
    end

    def has_grandmother
        grandmother_name = nil
        first_person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
        first_person_root_id = first_person_record["root_id"]
        parent_tree = @@family_record.find_all { |parent| parent["parent_id"] == first_person_root_id }
        parent_upper_level_root_id = []
        parent_tree.each do |parent|
            parent.each do |key, value|
                if key == "root_id"
                    parent_upper_level_root_id.push(value)
                end
            end
        end
        parent_root_id = nil
        if parent_upper_level_root_id[0] == nil && parent_upper_level_root_id[1] == nil 
            return "No Grandmother"
        else
            parent_upper_level_root_id.each do |root_id|
                unless root_id.nil?
                    parent_root_id = root_id
                end
            end
            grandmother = @@family_record.detect{ |grandmother| grandmother["parent_id"] == parent_root_id && grandmother["sex"] == "Female" }
            grandmother_name = grandmother["name"]
            return grandmother_name                   
        end     
    end

    def has_grandsons
        grandsons  = []
        grandparent_record = @@family_record.detect{ |person| person["name"] == @person_name  }
        grandparent_parent_id = grandparent_record["parent_id"]
        first_children_tree = @@family_record.find_all { |children| children["root_id"] == grandparent_parent_id }
        lower_level_parent_ids = []
        first_children_tree.each do |first_children|
            first_children.each do |key, value|
                if key == "parent_id"
                    lower_level_parent_ids.push(value)
                end
            end
        end
        grandchildren = []
        lower_level_parent_ids.each do |parent_id|
            offspring = @@family_record.find_all { |children| children["root_id"] == parent_id && children["sex"] == "Male" }
            grandchildren.push(offspring)
        end
        grandchildren.each do |grandchild|
            grandchild.each do |person|
                person.each do |key, value|
                    if key == "name"
                        grandsons.push(value)
                    end
                end
            end 
        end
        return grandsons 
    end

    def has_granddaughters
        granddaughters  = []
        grandparent_record = @@family_record.detect{ |person| person["name"] == @person_name  }
        grandparent_parent_id = grandparent_record["parent_id"]
        first_children_tree = @@family_record.find_all { |children| children["root_id"] == grandparent_parent_id }
        lower_level_parent_ids = []
        first_children_tree.each do |first_children|
            first_children.each do |key, value|
                if key == "parent_id"
                    lower_level_parent_ids.push(value)
                end
            end
        end
        grandchildren = []
        lower_level_parent_ids.each do |parent_id|
            offspring = @@family_record.find_all { |children| children["root_id"] == parent_id && children["sex"] == "Female" }
            grandchildren.push(offspring)
        end
        grandchildren.each do |grandchild|
            grandchild.each do |person|
                person.each do |key, value|
                    if key == "name"
                        granddaughters.push(value)
                    end
                end
            end 
        end
        return granddaughters
    end

    def has_wife
        wife_name = nil
        person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
        person_partner_id = person_record["partner_id"]
        wife_record = @@family_record.detect { |wife| wife["partner_id"] == person_partner_id && wife["sex"] == "Female"}
        if wife_record.nil?
            wife_name = "No Wife"
        else
            wife_name = wife_record["name"]
        end
        return wife_name        
    end

    def has_husband
        husband_name = nil
        person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
        person_partner_id = person_record["partner_id"]
        husband_record = @@family_record.detect { |wife| wife["partner_id"] == person_partner_id && wife["sex"] == "Male"}
        if husband_record.nil?
            husband_name = "No Husband"
        else
            husband_name = husband_record["name"]
        end
        return husband_name        
    end
    
end