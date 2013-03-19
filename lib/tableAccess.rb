class Access  #class, that must do all work for email, addresses and number
  def initialize (data, type, table, contact=nil, id=nil)
    @data = data
    @type = type
    @table = table
    @contact = contact
    @id = id
  end

  def save
    DB.execute("INSERT INTO #{@table} (data,type,contact_id) VALUES ('#{@data}','#{@type}','#{@contact.id}');")
  end

  def self.getRecords table
    result = ""
    DB.execute("SELECT * FROM #{table};").map {|row| result+=row['email'].to_s+' '+row['type'].to_s+" \n"}
    result
  end

  def to_s
    "#{@id} #{@data} #{@type}"
  end

  def self.getRecFrId(table, contactId)
    DB.execute("SELECT * FROM #{table} WHERE contact_id=#{contactId};").map {|row| Email.new(row['data'],row['type'],Contact.getFromId(contactId),row['id'])}
  end

  def self.delFrID(table, contactId)
    DB.execute("DELETE FROM #{table} WHERE contact_id=#{contactId};")
  end

  def self.edit(table,idtoedit,record,type)
    DB.execute("UPDATE #{table} SET data='#{record}', type='#{type}' WHERE id='#{idtoedit}'")
  end
end