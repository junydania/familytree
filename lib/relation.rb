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


    def check_sons
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

    def check_daughters
        if @attribute.capitalize == "Person" && @relation.capitalize == "Relation" && @relationship_type.capitalize == "Daughters" or @relationship_type.capitalize == "Daughter"
            person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
            person_parent_id = person_record["parent_id"]
            daughters = @@family_record.find_all { |daughter| daughter["root_id"] == person_parent_id && daughter["sex"] == "Female" }
            daughters_array = []
            daughters.each do |daughter|
                daughter.each do |key, value|
                    if key == "name"
                        daughters._array.push(value)
                    end
                end
            end
            daughters._names = daughters._array.join(", ")
            puts "#{@relationship_type.capitalize}=#{daughters._names}"
        else
            puts "Unrecognized entry! Try Again!"
        end    

    end

    def check_brothers
        if @attribute.capitalize == "Person" && @relation.capitalize == "Relation" && @relationship_type.capitalize == "Brothers" or @relationship_type.capitalize == "Brother"
            person_record = @@family_record.detect{ |person| person["name"] == @person_name  }
            person_root_id = person_record["root_id"]
            brothers = @@family_record.find_all { |brother| brother["root_id"] == person_root_id && @person_name != person_record["name"] }
            brothers_array = []
            brothers.each do |brother|
                brother.each do |key, value|
                    if key == "name"
                        brothers._array.push(value)
                    end
                end
            end
            brothers_names = brothers_array.join(", ")
            puts "#{@relationship_type.capitalize}=#{brothers_names}"
        else
            puts "Unrecognized entry! Try Again!"
        end    
    end

end
