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

end
