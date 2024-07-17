const express = require("express");
const router = express.Router();

module.exports = (db) => {
  router.get("/categories", (req, res) => {
    db.all(`SELECT * FROM categories`, [], (err, rows) => {
      if (err) {
        res.status(500).json({ error: err.message });
      } else {
        res.json({ data: rows });
      }
    });
  });

  // Lấy danh mục theo catId
  router.get("/categories/:catId", (req, res) => {
    const catId = parseInt(req.params.catId, 10);
    db.all(`SELECT * FROM categories WHERE catId = ?`, [catId], (err, rows) => {
      if (err) {
        res.status(500).json({ error: err.message });
      } else {
        res.json({ data: rows });
      }
    });
  });
  // Lấy dữ liệu của 1 sản phẩm trong category
  router.get("/categories/:catId/products/:productId", (req, res) => {
    const catId = parseInt(req.params.catId, 10);
    const productId = parseInt(req.params.productId, 10);
    db.get(
      `SELECT * FROM products WHERE catId = ? AND productId = ?`,
      [catId, productId],
      (err, row) => {
        if (err) {
          res.status(500).json({ error: err.message });
        } else {
          res.json({ data: row });
        }
      }
    );
  });
  return router;
}