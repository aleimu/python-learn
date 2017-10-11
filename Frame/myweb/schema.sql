drop table if exists entries;
create table entries (
    id integer primary key autoincrement,
    title text not null,
    text text not null,
    user text not null unique
);
drop table if exists users;
create table users (
    name text not null unique,
    password text not null
);


/*"""
#数据库常用操作
import sqlite3

# test.db is a file in the working directory.
conn = sqlite3.connect("test.db")
c = conn.cursor()

# create tables
c.execute('''CREATE TABLE category(id int primary key, sort int, name text)''')
c.execute('''CREATE TABLE book(id int primary key, sort int, name text, price real, category int,FOREIGN KEY (category) REFERENCES category(id))''')

books = [(1, 1, 'Cook Recipe', 3.12, 1),(2, 3, 'Python Intro', 17.5, 2),(3, 2, 'OS Intro', 13.6, 2),]

# execute "INSERT"
c.execute("INSERT INTO category VALUES (1, 1, 'kitchen')")

# using the placeholder
c.execute("INSERT INTO category VALUES (?, ?, ?)", [(2, 2, 'computer')])

# execute multiple commands
c.executemany('INSERT INTO book VALUES (?, ?, ?, ?, ?)', books)

c.execute('SELECT name FROM category ORDER BY sort')
print(c.fetchone())
print(c.fetchone())

# retrieve all records as a list
c.execute('SELECT * FROM book WHERE book.category=1')
print(c.fetchall())

# iterate through the records
for row in c.execute('SELECT name, price FROM book ORDER BY sort'):
    print(row)

c.execute('UPDATE book SET price=? WHERE id=?',(1000, 1))
c.execute('DELETE FROM book WHERE id=2')

c.execute('DROP TABLE book')
conn.commit()
conn.close()
"""*/
