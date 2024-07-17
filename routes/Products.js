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
    const { name, desc, price, color, image, catId } = req.body;
    const sql = `INSERT INTO products (name, desc, price, color, image, catId) VALUES (?, ?, ?, ?, ?, ?)`;
    const params = [name, desc, price, color, image, catId];

    db.run(sql, params, function (err) {
      if (err) {
        return res.status(500).json({ error: err.message });
      }
      res.json({
        message: "success",
        data: {
          id: this.lastID,
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
  return router;
};
