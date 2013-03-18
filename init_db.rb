require 'sqlite3'
DB = SQLite3::Database.open("adrBook.db")

DB.execute('drop table addresses;')
DB.execute('drop table contacts;')
DB.execute('drop table emails;')
DB.execute('drop table number;')


DB.execute('create table addresses (id integer primary key, address varchar, contact_id integer, type varchar);')
DB.execute('create table contacts (id integer primary key, name varchar);')
DB.execute('create table emails (id integer primary key, email varchar, contact_id integer, type varchar);')
DB.execute('create table number (id integer primary key, number varchar, contact_id integer, type varchar);')
