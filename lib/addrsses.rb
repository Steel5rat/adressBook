class Addresses
  def initialize (addr, addr_type, contact=nil,id=nil)
    @address = addr
    @address_type = addr_type
    @contact = contact
    @id = id
  end

  def save
    DB.execute("INSERT INTO addresses( address,type,contact_id) VALUES ('#{@address}','#{@address_type}','#{@contact.id}');")
  end

  def self.getRecords
    result = ""
    DB.execute("SELECT * FROM addresses;").map {|row| result+=row['address'].to_s+' '+row['type'].to_s+" \n"}
    result
  end

  def to_s
    "#{@id} #{@address} #{@address_type}"
  end

  def self.getRecFrId contactId
    DB.execute("SELECT * FROM addresses WHERE contact_id=#{contactId};").map {|row| Email.new(row['address'],row['type'],Contact.getFromId(contactId),row['id'])}
  end

  def self.delFrID contactId
    DB.execute("DELETE FROM addresses WHERE contact_id=#{contactId};")
  end

  def self.edit(idtoedit,record,type)
    DB.execute("UPDATE addresses SET address='#{record}', type='#{type}' WHERE id='#{idtoedit}'")
  end
end