const express = require("express");
const router = express.Router();

const queryAsync = (db, sql, params = []) => {
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
  // Route để lấy danh sách đơn hàng
  router.get("/orders", async (req, res) => {
    try {
      const result = await new Promise((resolve, reject) => {
        db.all(`SELECT * FROM orders`, (err, rows) => {
          if (err) {
            reject(err);
          } else {
            resolve(rows);
          }
        });
      });

      res.status(200).json({ orders: result });
    } catch (error) {
      console.error("Error fetching orders:", error.message);
      res.status(500).json({ message: "Error fetching orders" });
    }
  });
  // Route để lấy danh sách đơn hàng của một người dùng cụ thể qua POST request
  router.get("/orders/:userId", async (req, res) => {
    const { userId } = req.params; // Lấy userId từ URL params

    try {
      const result = await new Promise((resolve, reject) => {
        db.all(
          `SELECT * FROM orders WHERE user_id = ?`,
          [userId],
          (err, rows) => {
            if (err) {
              reject(err);
            } else {
              resolve(rows);
            }
          }
        );
      });

      res.status(200).json({ orders: result });
    } catch (error) {
      console.error("Lỗi khi lấy đơn hàng:", error.message);
      res.status(500).json({ message: "Lỗi khi lấy đơn hàng" });
    }
  });

  // Route để lấy thông tin chi tiết đơn hàng
  router.get("/order/:orderId", async (req, res) => {
    const { orderId } = req.params;

    try {
      // Lấy thông tin đơn hàng
      const orderResult = await new Promise((resolve, reject) => {
        db.all(
        `SELECT * FROM orders WHERE id = ?`,
        [orderId],
        (err, rows) => {
            if (err) {
              reject(err);
            } else {
              resolve(rows);
            }
          }
      );
      });
    
      console.log("Order result:", orderResult); // Log kết quả đơn hàng

      // Kiểm tra xem đơn hàng có tồn tại không
      if (orderResult.length === 0) {
        return res.status(404).json({ message: "Order not found" });
      }

      const order = orderResult[0];

      // Lấy thông tin chi tiết đơn hàng
      const itemsResult = await new Promise((resolve, reject) => {
        db.all(
          `SELECT * FROM order_items WHERE order_id = ?`,
          [orderId],
          (err, rows) => {
            if (err) {
              reject(err);
            } else {
              resolve(rows);
            }
          }
        );
    });
      console.log("Items result:", itemsResult); // Log kết quả chi tiết đơn hàng

      // Thêm thông tin chi tiết vào đơn hàng
      order.items = itemsResult || []; // Nếu không có chi tiết đơn hàng, gán là mảng rỗng

      // Gửi dữ liệu đơn hàng đã được cập nhật
      res.status(200).json({ order });
    } catch (error) {
      console.error("Error fetching order detail:", error); // Log chi tiết lỗi
      res.status(500).json({ message: "Error fetching order detail" });
    }
  });

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
