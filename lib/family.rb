class Family
  
  @@filepath = nil
  @@people = nil

  def self.filepath=(path=nil)
    @@filepath = File.join(APP_ROOT,path)
  end

  def self.file_exists?
    if @@filepath && File.exists?(@@filepath)
      return true
    else
      return false
    end
  end

  def self.load_family_record
    @@people = YAML.load_stream(open(@@filepath))
  end


  def self.file_useable?
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    return true
  end

  def self.build_from_input
    print "Enter a new family member in the format"
    print "Mother=Sophia Son=Thomas"
    entry = gets.chomp.split(" ")
    args = entry.map{ |i| i.split '=' }.to_a
    # return self.new(args)
    return args
  end


#   def self.saved_restaurants
#     restaurants = []
#     if file_useable?
#       file = File.new(@@filepath, 'r')
#       file.each_line do |line|
#         restaurants << Restaurant.new.import_line(line.chomp)
#       end
#       file.close
#     end
#     return restaurants
#   end


#   def import_line(line)
#     line_array = line.split("\t")
#     @name, @cuisine, @price = line_array
#     return self
#   end

  def self.save(new_member, name)
    return false unless Family.file_useable?
    File.open("family.yml","a") { |f| f << new_member.to_yaml }
    end
    puts "Welcome to the family, #{name}!"
  end
end
