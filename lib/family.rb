require 'yaml'

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
    entries = nil
    print "Input Parameter > "
    entry = gets.chomp
    unless entry.downcase == "quit"
      check_space = entry.match(/\s/) ? "Yes" : "No" 
      if check_space == "Yes"
        reviewed_entry = entry.split(" ")
        entries = reviewed_entry.map{ |i| i.split '=' }.to_a
      else
        entries = "Wrong Format"
      end
      return entries
    end
    puts "\n<<< au revoir >>> \n\n\n"
    exit!
  end

  def self.save(new_member)
    return false unless Family.file_useable?
    File.open(@@filepath, "a") { |f| f << new_member.to_yaml }
    return "Saved"
  end


end