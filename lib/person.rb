require 'securerandom'

class Person
  
    attr_accessor :name, :sex
    
    def initialize(person_name, sex)
      @name = person_name
      @sex = sex
    end

    def generate_parent_partner_id
      id = SecureRandom.hex(5)
      return id
    end

end





    