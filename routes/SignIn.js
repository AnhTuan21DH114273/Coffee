const express = require("express");
const router = express.Router();
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

module.exports = (db) => {
  router.post("/signin", (req, res) => {
    const { name, password } = req.body;

    db.get("SELECT * FROM users WHERE name = ?", [name], (err, user) => {
      if (err) {
        console.error("Database error:", err);
        return res.status(500).json({ error: "Database error" });
      }
      if (!user) {
        return res.status(401).json({ error: "Invalid credentials" });
      }

      bcrypt.compare(password, user.password, (err, result) => {
        if (err) {
          console.error("Authentication error:", err);
          return res.status(500).json({ error: "Authentication error" });
        }
        if (!result) {
          return res.status(401).json({ error: "Invalid credentials" });
        }

        const token = jwt.sign({ id: user.id }, "secret_key", {
          expiresIn: "2h",
        });

        const response = {
          message: "Login successful",
          token: token,
          user: {
            id: user.id,
            name: user.name,
            phone: user.phone,
          },
        };

        console.log("Response:", response); // Log response
        res.json(response);
      });
    });
  });

  return router;
};
