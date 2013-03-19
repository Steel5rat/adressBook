class Email
  def initialize (email, email_type, contact=nil, id=nil)
    @mail = email
    @type = email_type
    @contact = contact
    @id = id
  end

  def save
    DB.execute("INSERT INTO emails( data,type,contact_id) VALUES ('#{@mail}','#{@type}','#{@contact.id}');")
  end

  def self.getRecords
    result = ""
    DB.execute("SELECT * FROM emails;").map {|row| result+=row['email'].to_s+' '+row['type'].to_s+" \n"}
    result
  end

  def to_s
    "#{@id} #{@mail} #{@type}"
  end

  def self.getRecFrId contactId
    DB.execute("SELECT * FROM emails WHERE contact_id=#{contactId};").map {|row| Email.new(row['data'],row['type'],Contact.getFromId(contactId),row['id'])}
  end

  def self.delFrID contactId
    DB.execute("DELETE FROM emails WHERE contact_id =#{contactId};")
  end

  def self.edit(idtoedit,record,type)
    DB.execute("UPDATE emails SET data='#{record}', type='#{type}' WHERE id='#{idtoedit}'")
  end
end