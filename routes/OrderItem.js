const express = require("express");
const router = express.Router();

const runAsync = (db, sql, params = []) => {
  return new Promise((resolve, reject) => {
    db.run(sql, params, function (err) {
      if (err) {
        reject(err);
      } else {
        resolve(this);
      }
    });
  });
};
module.exports = (db) => {
  router.post("/order_items", async (req, res) => {
    const { order_id, items } = req.body;

    console.log("Received order items data:", req.body);

    try {
      const itemsPromises = items.map((item) =>
        runAsync(
          db,
          `INSERT INTO order_items (order_id, product_id, product_name, product_description, quantity, price) VALUES (?, ?, ?, ?, ?, ?)`,
          [
            order_id,
            item.product_id,
            item.product_name,
            item.product_description,
            item.quantity,
            item.price,
          ]
        )
      );

      await Promise.all(itemsPromises);

      res.status(201).json({ message: "Order items placed successfully!" });
    } catch (error) {
      console.error("Error placing order items:", error.message);
      res.status(500).json({ message: "Error placing order items" });
    }
  });

  return router;
};
