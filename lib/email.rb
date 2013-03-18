class Email
  def initialize (email, email_type, contact)
    @mail = email
    @type = email_type
    @contact = contact
  end

  def save
    DB.execute("INSERT INTO emails( email,type,contact_id) VALUES ('#{@mail}','#{@type}','#{@contact.id}');")
    puts "asda"
  end
end