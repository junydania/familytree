require 'securerandom'

class Person
  
    attr_accessor :name, :sex
    
    def initialize(name, sex)
      @name = name
      @sex = sex
    end

    def generate_parent_partner_id
      id = SecureRandom.hex(5)
      return id
    end

end





    