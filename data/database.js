const fs = require("fs");
const path = require("path");
const sqlite3 = require("sqlite3").verbose();

const dataDir = path.join(__dirname);
if (!fs.existsSync(dataDir)) {
  fs.mkdirSync(dataDir);
}

const dbPath = path.join(dataDir, "coffee_shop.db");
console.log("Database path:", dbPath);

const db = new sqlite3.Database(dbPath, (err) => {
  if (err) {
    console.error("Error opening database " + err.message);
  } else {
    console.log("Connected to the SQLite database.");

    // Tạo bảng users
    db.run(
      `CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        password TEXT NOT NULL
      )`,
      (err) => {
        if (err) {
          console.error("Error creating table 'users': " + err.message);
        } else {
          console.log('Table "users" created or already exists.');
        }
      }
    );

    // Tạo bảng products
    db.run(
      `CREATE TABLE IF NOT EXISTS products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        price REAL NOT NULL,
        image TEXT NOT NULL,
        color TEXT NOT NULL
      )`,
      (err) => {
        if (err) {
          console.error("Error creating table 'products': " + err.message);
        } else {
          console.log('Table "products" created or already exists.');
        }
      }
    );
    
    db.run(
      `CREATE TABLE IF NOT EXISTS categories (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        price INTEGER NOT NULL,
        img TEXT,
        des TEXT,
        catId INTEGER,
        catName TEXT
      )`,
      (err) => {
        if (err) {
          console.error("Error creating table 'categories': " + err.message);
        } else {
          console.log('Table "categories" created or already exists.');
        }
      }
    );
  }
});
module.exports = db;
