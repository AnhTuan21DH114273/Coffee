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
// Route để tạo đơn hàng mới
module.exports = (db) => {
  router.post("/orders", async (req, res) => {
    const {
      user_id,
      address,
      order_date,
      total_price,
      delivery_fee,
      total_amount,
      payment_method,
      status,
      items,
    } = req.body;

    try {
      // Insert đơn hàng vào bảng orders
      const result = await runAsync(
        db,
        `INSERT INTO orders (user_id, address, order_date, total_price, delivery_fee, total_amount, payment_method, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
        [
          user_id,
          address,
          order_date,
          total_price,
          delivery_fee,
          total_amount,
          payment_method,
          status,
        ]
      );

      // Lấy ID của đơn hàng vừa tạo
      const orderId = result.lastID;
      console.log("Order ID:", orderId);
      res.status(201).json({ message: "Order placed successfully!", orderId });
    } catch (error) {
      console.error("Error placing order:", error.message);
      res.status(500).json({ message: "Error placing order" });
    }
  });
  return router;
};
