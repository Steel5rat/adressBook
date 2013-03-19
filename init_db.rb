require 'sqlite3'
DB = SQLite3::Database.open("adrBook.db")

DB.execute('drop table if exists addresses;')
DB.execute('drop table if exists contacts;')
DB.execute('drop table if exists emails;')
DB.execute('drop table if exists number;')
DB.execute('drop table if exists numbers;')

DB.execute('create table contacts (id integer primary key, name varchar);')
DB.execute('create table addresses (id integer primary key, data varchar, contact_id integer, type varchar);')
DB.execute('create table emails (id integer primary key, data varchar, contact_id integer, type varchar);')
DB.execute('create table number (id integer primary key, data varchar, contact_id integer, type varchar);')
