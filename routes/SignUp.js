const express = require("express");
const bcrypt = require("bcrypt");
const router = express.Router();

module.exports = (db) => {
  // Route để đăng ký người dùng
  router.post("/signup", (req, res) => {
    console.log("Received body:", req.body);
    const { name, phone, password } = req.body;

    // Kiểm tra xem req.body có dữ liệu không
    if (!name || !phone || !password) {
      return res.status(400).json({ error: "Missing required fields." });
    }

    // Hash mật khẩu trước khi lưu vào cơ sở dữ liệu
    bcrypt.hash(password, 10, (err, hashedPassword) => {
      if (err) {
        return res.status(500).json({ error: err.message });
      }

      // Lưu thông tin người dùng vào cơ sở dữ liệu
      db.run(
        `INSERT INTO users (name, phone, password) VALUES (?, ?, ?)`,
        [name, phone, hashedPassword],
        function (err) {
          if (err) {
            return res.status(400).json({ error: err.message });
          }
          res.json({ id: this.lastID });
        }
      );
    });
  });

  return router;
};
