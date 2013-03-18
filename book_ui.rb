require 'sqlite3'
DB = SQLite3::Database.open("adrBook.db")
require './lib/addrsses'
require './lib/contact'
require './lib/email'
require './lib/number'

def tasks
  choice = nil
  until choice=='e'
    puts("'l' to list tasks, 'a' to add task, 'd' to mark task as done, press 'exit' to exit, ")
    choice = gets.chomp
    case choice
      when 'exit'
        choice='e'
      when 'l'
        listTasks
      when 'a'
        add
      when 'd'
        taskDone
      else
        invalid
    end
  end
end

def add
  name = prompt ("new contact")
  contact = Contact.new name
  contact.save
  email = prompt ("email")
  email_type = prompt ("email type")
  email = Email.new(email,email_type,contact)
  email.save
end

def prompt (input)
  puts "Enter #{input}:"
  gets.chomp
end

tasks