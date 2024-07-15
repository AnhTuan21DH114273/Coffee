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
      db.all(
        `SELECT * FROM categories WHERE catId = ?`,
        [catId],
        (err, rows) => {
          if (err) {
            res.status(500).json({ error: err.message });
          } else {
            res.json({ data: rows });
          }
        }
      );
    });
    return router;
}