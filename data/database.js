const fs = require("fs");
const path = require("path");
const sqlite3 = require("sqlite3").verbose();

const dataDir = path.join(__dirname);
if (!fs.existsSync(dataDir)) {
  fs.mkdirSync(dataDir);
}

const dbPath = path.join(dataDir, "coffee_shop.db"); // Chỉ cần sử dụng dataDir ở đây
console.log("Database path:", dbPath); // In đường dẫn cơ sở dữ liệu

const db = new sqlite3.Database(dbPath, (err) => {
  if (err) {
    console.error("Error opening database " + err.message);
  } else {
    console.log("Connected to the SQLite database.");
    db.run(
      `CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        password TEXT NOT NULL
      )`,
      (err) => {
        if (err) {
          console.error("Error creating table 'users': " + err.message); // Chi tiết lỗi
        } else {
          console.log('Table "users" created or already exists.');
        }
      }
    );
  }
});

module.exports = db;
