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

  def self.member_input
    print ">"
    entry = gets.chomp.split(" ")
    entries = entry.map{ |i| i.split '=' }.to_a
    return entries
  end


  def self.save(new_member, name)
    return false unless Family.file_useable?
    File.open(@@filepath, "a") { |f| f << new_member.to_yaml }
    puts "Welcome to the family, #{name}!"
  end

end
