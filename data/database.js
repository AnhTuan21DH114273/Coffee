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
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        des TEXT,
        desc TEXT,
        price REAL NOT NULL,
        img TEXT,
        catId INTEGER,
        catName TEXT,
        color TEXT,
        FOREIGN KEY(catId) REFERENCES categories(id)
      )`,
      (err) => {
        if (err) {
          console.error("Error creating table 'products': " + err.message);
        } else {
          console.log('Table "products" created or already exists.');
        }
      }
    );
    // fs.readFile(
    //   "/Users/phamhoangquocdat/Documents/Code/Đồ Án/Nodejs-App-Server/data/product.json",
    //   "utf8",
    //   (err, data) => {
    //     if (err) {
    //       console.error("Error reading JSON file: " + err.message);
    //       return;
    //     }

    //     const jsonData = JSON.parse(data);
    //     const products = jsonData.Data;

    //     // Insert products
    //     const insertProductStmt = db.prepare(
    //       "INSERT INTO products (id, name, des, desc, price, img, catId, catName, color) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"
    //     );
    //     products.forEach((product) => {
    //       insertProductStmt.run(
    //         product.id,
    //         product.name,
    //         product.des,
    //         product.desc,
    //         product.price,
    //         product.img,
    //         product.catId,
    //         product.catName,
    //         product.color,
    //         (err) => {
    //           if (err) {
    //             console.error("Error inserting product: " + err.message);
    //           } else {
    //             console.log(`Inserted product: ${product.name}`);
    //           }
    //         }
    //       );
    //     });
    //     insertProductStmt.finalize();

    //     console.log("Data insertion completed.");
    //   }
    // );

    db.run(
      `CREATE TABLE IF NOT EXISTS categories (
        id INTEGER PRIMARY KEY,
        catName TEXT NOT NULL
        
      )`,
      (err) => {
        if (err) {
          console.error("Error creating table 'categories': " + err.message);
        } else {
          console.log('Table "categories" created or already exists.');
          // // Insert sample data into the categories table
          // const stmt = db.prepare(
          //   "INSERT INTO categories (catname) VALUES (?)"
          // );

          // const sampleData = [
          //   "Cappuchino",
          //   "Machiato",
          //   "Latte",
          //   "Matcha",
          //   "Tea",
          // ];

          // sampleData.forEach((catname) => {
          //   stmt.run(catname, (err) => {
          //     if (err) {
          //       console.error(
          //         "Error inserting data into 'categories': " + err.message
          //       );
          //     } else {
          //       console.log(`Inserted ${catname} into 'categories'.`);
          //     }
          //   });
          // });

          // stmt.finalize();
        }
      }
    );
    // Tạo bảng 'orders'
    db.run(
      `CREATE TABLE IF NOT EXISTS orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    address TEXT NOT NULL,
    order_date TEXT NOT NULL,
    total_price REAL NOT NULL,
    delivery_fee REAL NOT NULL,
    total_amount REAL NOT NULL,
    payment_method TEXT NOT NULL,
    status TEXT NOT NULL,
    notes TEXT,
    FOREIGN KEY (user_id) REFERENCES users (id)
  )`,
      (err) => {
        if (err) {
          console.error("Error creating table 'orders': " + err.message);
        } else {
          console.log('Table "orders" created or already exists.');
        }
      }
    );

    // Tạo bảng 'order_items'
    db.run(
      `CREATE TABLE IF NOT EXISTS order_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    product_name TEXT NOT NULL,
    product_description TEXT,
    quantity INTEGER NOT NULL,
    price REAL NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders (id)
  )`,
      (err) => {
        if (err) {
          console.error("Error creating table 'order_items': " + err.message);
        } else {
          console.log('Table "order_items" created or already exists.');
        }
      }
    );
  }
});
module.exports = db;
