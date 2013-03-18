class Email
  def initialize (email, email_type, contact=nil)
    @mail = email
    @type = email_type
    @contact = contact
  end

  def save
    puts @contact.id
    DB.execute("INSERT INTO emails( email,type,contact_id) VALUES ('#{@mail}','#{@type}','#{@contact.id}');")
  end

  def self.getRecords
    result = ""
    DB.execute("SELECT * FROM emails;").map {|row| result+=row['email'].to_s+' '+row['type'].to_s+" \n"}
    result
  end

  def to_s
    "#{@mail} #{@type}"
  end

  def self.getRecFrId contactId
    DB.execute("SELECT * FROM emails WHERE contact_id=#{contactId};").map {|row| Email.new(row['email'],row['type'])}
  end
end