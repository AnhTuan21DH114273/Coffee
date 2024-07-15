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

  return router;
};
