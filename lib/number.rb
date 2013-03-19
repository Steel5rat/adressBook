class Number
  def initialize (numb ,numb_type, contact,id=nil)
    @number = numb
    @type = numb_type
    @contact = contact
    @id = id
  end

  def save
    DB.execute("INSERT INTO number( data,type,contact_id) VALUES ('#{@number}','#{@type}','#{@contact.id}');")
  end

  def self.getRecords
    result = ""
    DB.execute("SELECT * FROM number;").map {|row| result+=row['number'].to_s+' '+row['type'].to_s+" \n"}
    result
  end

  def to_s
    "#{@id} #{@number} #{@type}"
  end

  def self.getRecFrId contactId
    DB.execute("SELECT * FROM number WHERE contact_id=#{contactId};").map {|row| Email.new(row['data'],row['type'],Contact.getFromId(contactId),row['id'])}
  end

  def self.delFrID contactId
    DB.execute("DELETE FROM number WHERE contact_id=#{contactId};")
  end

  def self.edit(idtoedit,record,type)
    DB.execute("UPDATE number SET data='#{record}', type='#{type}' WHERE id='#{idtoedit}'")
  end
end