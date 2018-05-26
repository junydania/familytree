require 'family'
require 'pry'

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


    def has_sons
        sons_array = []
        if @person.capitalize == "Person" && @relation.capitalize == "Relation" && @relationship_type.capitalize == "Sons" or @relationship_type.capitalize == "Son"
            person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
            person_parent_id = person_record["parent_id"]
            sons = @@family_record.find_all { |son| son["root_id"] == person_parent_id && son["sex"] == "Male" }
            sons.each do |son|
                son.each do |key, value|
                    if key == "name"
                        sons_array.push(value)
                    end
                end
            end
        else
            puts "Unrecognized entry"
        end   
        return sons_array 
    end

    def has_daughters
        daughters_array = []
        if @person.capitalize == "Person" && @relation.capitalize == "Relation" && @relationship_type.capitalize == "Daughters" or @relationship_type.capitalize == "Daughter"
            person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
            person_parent_id = person_record["parent_id"]
            daughters = @@family_record.find_all { |daughter| daughter["root_id"] == person_parent_id && daughter["sex"] == "Female" }
            daughters.each do |daughter|
                daughter.each do |key, value|
                    if key == "name"
                        daughters_array.push(value)
                    end
                end
            end
        else
            puts "Unrecognized entry! Try Again!"
        end    
        return daughters_array 
    end


    def has_brothers
        brothers_array = []
        if @person.capitalize == "Person" && @relation.capitalize == "Relation" && @relationship_type.capitalize == "Brothers" or @relationship_type.capitalize == "Brother"
            person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
            person_root_id = person_record["root_id"]
            brothers = @@family_record.find_all { |brother| brother["root_id"] == person_root_id && brother["name"] != @person_name && brother["sex"] == "Male"}
            brothers.each do |brother|
                brother.each do |key, value|
                    if key == "name"
                        brothers_array.push(value)
                    end
                end
            end
        else
            puts "Unrecognized entry! Try Again!"
        end
        return brothers_array
    end

    def has_sisters
        sisters_array = []
        if @person.capitalize == "Person" && @relation.capitalize == "Relation" && @relationship_type.capitalize == "Sisters" or @relationship_type.capitalize == "Sister"
            person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
            person_root_id = person_record["root_id"]
            sisters = @@family_record.find_all { |sister| sister["root_id"] == person_root_id && sister["name"] != @person_name && sister["sex"] == "Female"}
            sisters.each do |sister|
                sister.each do |key, value|
                    if key == "name"
                        sisters_array.push(value)
                    end
                end
            end
        else
            puts "Unrecognized entry! Try Again!"
        end
        return sisters_array
    end

    def has_cousins
        cousins_array = []
        if @person.capitalize == "Person" && @relation.capitalize == "Relation" && @relationship_type.capitalize == "Cousins" or @relationship_type.capitalize == "Cousin"
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
                cousins_record = @@family_record.find_all { |cousin| cousin["root_id"] == parent_id }
                cousins_record.each do |cousin|
                    cousin.each do |key, value|
                        if key == "name"
                            cousins_array.push(value)
                        end
                    end
                end
            end
        else
            puts "Unrecognized entry! Try Again!"
        end
        return cousins_array
    end

    def has_father
        father_name = nil
        if @person.capitalize == "Person" && @relation.capitalize == "Relation" && @relationship_type.capitalize == "Father"
            person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
            person_root_id = person_record["root_id"]
            father_record = @@family_record.detect { |father| father["parent_id"] == person_root_id && father["sex"] == "Male"}
            father_name = father_record["name"]
        else
            puts "Unrecognized entry! Try Again!"
        end
        return father_name
    end

    def has_mother
        mother_name = nil
        if @person.capitalize == "Person" && @relation.capitalize == "Relation" && @relationship_type.capitalize == "Mother"
            person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
            person_root_id = person_record["root_id"]
            mother_record = @@family_record.detect { |mother| mother["parent_id"] == person_root_id && mother["sex"] == "Female"}
            mother_name = mother_record["name"]
        else
            puts "Unrecognized entry! Try Again!"
        end
        return mother_name
    end

    def has_aunts
        aunts_array = []
        if @person.capitalize == "Person" && @relation.capitalize == "Relation" && @relationship_type.capitalize == "Aunts" || @relationship_type.capitalize == "Aunt"
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
            parent_siblings = @@family_record.find_all { |sibling| sibling["root_id"] == parent_root_id && sibling["name"] != parent_name && sibling["sex"] == "Female" }
            if parent_siblings.any? == true
                parent_siblings.each do |parent_sibling|
                    parent_sibling.each do |key, value|
                        if key == "name"
                            aunts_array.push(value)
                        end
                    end
                end 
                return aunts_array
            else
                return "#{@person_name} doesn't have an aunt"
            end             
        else
            puts "Unrecognized entry! Try Again!"
        end
    end

    def has_uncles
        uncles_array = []
        if @person.capitalize == "Person" && @relation.capitalize == "Relation" && @relationship_type.capitalize == "Uncles" || @relationship_type.capitalize == "Uncle"
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
            parent_siblings = @@family_record.find_all { |sibling| sibling["root_id"] == parent_root_id && sibling["name"] != parent_name && sibling["sex"] == "Male" }
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
        else
            puts "Unrecognized entry! Try Again!"
        end
    end

    def has_grandfather
        grandfather_name = nil
        if @person.capitalize == "Person" && @relation.capitalize == "Relation" && @relationship_type.capitalize == "Grandfather"
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
        else
            puts "Unrecognized entry! Try Again!"
        end
    end

    def has_grandmother
        grandmother_name = nil
        if @person.capitalize == "Person" && @relation.capitalize == "Relation" && @relationship_type.capitalize == "Grandmother"
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
        else
            puts "Unrecognized entry! Try Again!"
        end
    end

    def has_grandsons
        grandsons  = []
        if @person.capitalize == "Person" && @relation.capitalize == "Relation" && @relationship_type.capitalize == "Grandsons"
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
        else
            puts "Unrecognized entry! Try Again!"
        end
    end

    def has_granddaughters
        granddaughters  = []
        if @person.capitalize == "Person" && @relation.capitalize == "Relation" && @relationship_type.capitalize == "Granddaughters" or @relationship_type.capitalize == "Granddaughter"
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
        else
            puts "Unrecognized entry! Try Again!"
        end
    end
end





