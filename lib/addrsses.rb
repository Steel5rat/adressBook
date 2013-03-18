class Addresses
  def initialize (addr, addr_type, contact)
    @address = addr
    @address_type = addr_type
    @contact = contact
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
    "#{@address} #{@address_type}"
  end

  def self.getRecFrId contactId
    DB.execute("SELECT * FROM addresses WHERE contact_id=#{contactId};").map {|row| Email.new(row['address'],row['type'])}
  end
end