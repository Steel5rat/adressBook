require 'sqlite3'
DB = SQLite3::Database.open("adrBook.db")
DB.results_as_hash = true;
require './lib/addrsses'
require './lib/contact'
require './lib/email'
require './lib/number'

def tasks
  choice = nil
  until choice=='e'
    puts("'a' to add contact, 'i' to add info, 's' to show all records, 'c' to show info about contact, '4' to change, 'd' to delete 'exit' to exit.")
    choice = gets.chomp
    case choice
      when 'exit'
        choice='e'
      when 'i'
        moreInfoAdd
      when 'a'
        add
      when 's'
        showInfo
      when 'c'
        showAllContactInfo
      when '4'
         change
      when 'd'
        delete
      else
        invalid
    end
  end
end

def delete
  puts "Choose contact:"
  puts Contact.getAll
  co = Contact.getFromId(gets.chomp)
  co.delete
end

def change
  puts "Choose contact:"
  puts Contact.getAll
  co = Contact.getFromId(gets.chomp)
  choice='a'
  while choice!='exit'
    puts "'e' to change email, 'a' address, 'n' phone number, 'exit' to exit"
    choice = gets.chomp
    co.change choice
  end
end


def showInfo
  choice='a'
  while choice!='exit'
    puts "'e' to show email, 'a' address, 'n' phone number, 'c' contacts, 'exit' to exit"
    choice = gets.chomp
    case choice
      when 'e'
        puts Email.getRecords
      when 'a'
        puts Addresses.getRecords
      when 'n'
        puts Number.getRecords
      when 'c'
        puts Contact.getAll
      when 'exit'
      else
        invalid
    end
  end
end

def add
  name = prompt ("new contact")
  contact = Contact.new name
  contact.save
  addInfo(contact)
end

def showAllContactInfo
  puts "Choose contact:"
  puts Contact.getAll
  co = Contact.getFromId(gets.chomp)
  co.getData
end


def moreInfoAdd
  puts "Choose contact:"
  puts Contact.getAll
  co = Contact.getFromId(gets.chomp)
  addInfo co
  puts "done."
end

def addInfo(contact)
  choice = 'a'
  until choice=='exit'
    puts "'e' to add email, 'a' to add address, 'n' to add phone number, 'exit' to finish"
    choice = gets.chomp
    case choice
      when 'e'
        email = prompt ("email")
        email_type = prompt ("email type")
        email = Email.new(email,email_type,contact)
        email.save
      when 'a'
        address = prompt ("address")
        address_type = prompt ("address type")
        address = Addresses.new(address,address_type,contact)
        address.save
      when 'n'
        number = prompt ("number")
        number_type = prompt ("number type")
        number = Number.new(number,number_type,contact)
        number.save
      when 'exit'
      else
        invalid
    end
  end
end

def prompt (input)
  puts "Enter #{input}:"
  gets.chomp
end

def invalid
  puts "aaaaaa!!!"
end

tasks