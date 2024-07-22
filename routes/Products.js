const express = require("express");
const router = express.Router();

module.exports = (db) => {
  // Endpoint để lấy danh sách sản phẩm
  router.get("/products", (req, res) => {
    db.all("SELECT * FROM products", [], (err, rows) => {
      if (err) {
        return res.status(500).json({ error: err.message });
      }
      res.json({
        message: "success",
        data: rows,
      });
    });
  });

  // Endpoint để lấy danh sách sản phẩm theo catId
  router.get("/products/category/:catId", (req, res) => {
    const { catId } = req.params;
    db.all("SELECT * FROM products WHERE catId = ?", [catId], (err, rows) => {
      if (err) {
        return res.status(500).json({ error: err.message });
      }
      res.json({
        message: "success",
        data: rows,
      });
    });
  });

  // Endpoint để thêm sản phẩm mới
  router.post("/products", (req, res) => {
    const { name, des, desc, price, img, catId, color } = req.body;

    // Câu lệnh SQL để thêm sản phẩm mới vào cơ sở dữ liệu
    const sql = `INSERT INTO products (name, des, desc, price, img, catId, color) VALUES (?, ?, ?, ?, ?, ?, ?)`;

    // Tham số cho câu lệnh SQL
    const params = [name, des, desc, price, img, catId, color];

    // Thực thi câu lệnh SQL
    db.run(sql, params, function (err) {
      if (err) {
        // Trả về lỗi nếu có vấn đề
        return res.status(500).json({ error: err.message });
      }

      // Trả về dữ liệu của sản phẩm đã thêm với mã trạng thái 201
      res.status(201).json({
        message: "success",
        data: {
          id: this.lastID,
          name,
          des,
          desc,
          price,
          img,
          catId,
          color,
        },
      });
    });
  });

  // Endpoint để xóa sản phẩm theo ID
  router.delete("/products/:id", (req, res) => {
    const { id } = req.params;
    db.run("DELETE FROM products WHERE id = ?", id, function (err) {
      if (err) {
        return res.status(500).json({ error: err.message });
      }
      res.json({
        message: "deleted",
        changes: this.changes,
      });
    });
  });
  // Endpoint để lấy dữ liệu chi tiết của một sản phẩm
  router.get("/products/:id", (req, res) => {
    const { id } = req.params;
    db.get("SELECT * FROM products WHERE id = ?", [id], (err, row) => {
      if (err) {
        return res.status(500).json({ error: err.message });
      }
      if (!row) {
        return res.status(404).json({ message: "Product not found" });
      }
      res.json({
        message: "success",
        data: row,
      });
    });
  });
  router.put("/products/:id", (req, res) => {
    const { id } = req.params;
    const { name, desc, price, color, image, catId } = req.body;

    // Kiểm tra xem ít nhất một trường cần thiết có được cung cấp không
    if (!name && !desc && !price && !color && !image && !catId) {
      return res
        .status(400)
        .json({ error: "At least one field is required to update" });
    }

    // Tạo câu lệnh SQL để cập nhật sản phẩm
    let sql = `UPDATE products SET`;
    const params = [];

    if (name) {
      sql += ` name = ?,`;
      params.push(name);
    }
    if (desc) {
      sql += ` desc = ?,`;
      params.push(desc);
    }
    if (price) {
      sql += ` price = ?,`;
      params.push(price);
    }
    if (color) {
      sql += ` color = ?,`;
      params.push(color);
    }
    if (image) {
      sql += ` image = ?,`;
      params.push(image);
    }
    if (catId) {
      sql += ` catId = ?,`;
      params.push(catId);
    }

    // Xóa dấu phẩy thừa và thêm điều kiện WHERE
    sql = sql.slice(0, -1) + ` WHERE id = ?`;
    params.push(id);

    db.run(sql, params, function (err) {
      if (err) {
        return res.status(500).json({ error: err.message });
      }
      if (this.changes === 0) {
        return res.status(404).json({ message: "Product not found" });
      }
      res.json({
        message: "Product updated successfully",
        data: {
          id,
          name,
          desc,
          price,
          color,
          image,
          catId,
        },
      });
    });
  });
  return router;
};
