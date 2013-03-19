class Contact
  attr_reader :id
  def initialize(name,id=nil)
    @name = name
    @id = id
  end

  def save
     DB.execute("INSERT INTO contacts(name) VALUES ('#{@name}');")
     @id = DB.execute("SELECT last_insert_rowid();")[0][0]
  end

  def getData
     puts "Emails:"
     puts Access.getRecFrId('emails',@id)
     puts "Addresses:"
     puts Addresses.getRecFrId(@id)
     puts "Phone numbers:"
     puts Number.getRecFrId(@id)
  end

  def self.getAll
    result = ""
    DB.execute("SELECT * FROM contacts;").map {|row| result+=row['id'].to_s+' '+row['name'].to_s+" \n"}
    result
  end

  def self.getFromId id
    cont = DB.execute("SELECT * FROM contacts WHERE id=#{id};")
    Contact.new(cont[0]['name'],cont[0]['id'])
  end

  def delete
    Email.delFrID @id
    Addresses.delFrID @id
    Number.delFrID @id
    DB.execute("DELETE FROM contacts WHERE id=#{@id};")
  end

  def change choice
      case choice
        when 'e'
          puts Email.getRecFrId @id
          puts "insert id:"
          idToEdit = gets.chomp
          puts "insert email:"
          mail = gets.chomp
          puts "insert email type:"
          type = gets.chomp
          Email.edit(idToEdit,mail,type)
        when 'a'
          puts Addresses.getRecFrId @id
          puts "insert id:"
          idToEdit = gets.chomp
          puts "insert address:"
          mail = gets.chomp
          puts "insert address type:"
          type = gets.chomp
          Addresses.edit(idToEdit,mail,type)
        when 'n'
          puts Number.getRecFrId @id
          puts "insert id:"
          idToEdit = gets.chomp
          puts "insert number:"
          mail = gets.chomp
          puts "insert number type:"
          type = gets.chomp
          Number.edit(idToEdit,mail,type)
        when 'exit'
        else
          invalid
      end
  end
end