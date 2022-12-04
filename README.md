# Notepad
It's a ruby console application like mini notepad. 
This apllication is written on ruby version 2.7.1, but it's probably would be working on earlier versions of ruby.
It's necessary to install sqlite, for ubuntu instruction can be found at [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-sqlite-on-ubuntu-20-04).
To run this apllication you should have installed ruby and downloaded [zip archive](https://github.com/madmol/notepad/archive/refs/heads/master.zip).
You should go to unpacked folder notepad-master and create SQLite database
```
sqlite3 notepad
```
A new prefix, sqlite>, now appears:
```
sqlite>
```
Use the following command to create the table:
```
DROP TABLE IF EXISTS "posts";
CREATE TABLE "posts" (
  "type"       TEXT,
  "created_at" DATETIME,
  "text"       TEXT,
  "url"        TEXT,
  "due_date"   DATETIME
);
```
After database has been created you can run application to create records:
```
ruby new_post.rb
```
During programm execution you can choose what kind or record do you want to cretae: 0 - Memo, 1- Link, 2 - Task. Then just follow the prompts on the screen. Created records are stored in the database

You can output created record:

```
ruby read.rb
```
