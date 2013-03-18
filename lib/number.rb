class Number
  def initialize (numb ,numb_type, contact)
    @number = numb
    @type = numb_type
    @contact = contact
  end

  def save
    DB.execute("INSERT INTO number( number,type,contact_id) VALUES ('#{@number}','#{@type}','#{@contact.id}');")
  end

  def self.getRecords
    result = ""
    DB.execute("SELECT * FROM number;").map {|row| result+=row['number'].to_s+' '+row['type'].to_s+" \n"}
    result
  end

  def to_s
    "#{@number} #{@type}"
  end

  def self.getRecFrId contactId
    DB.execute("SELECT * FROM number WHERE contact_id=#{contactId};").map {|row| Email.new(row['number'],row['type'])}
  end
end