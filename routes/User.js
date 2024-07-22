const express = require("express");
const router = express.Router();

// Helper function to execute SQL queries
const runAsync = (db, sql, params = []) => {
  return new Promise((resolve, reject) => {
    db.all(sql, params, (err, row) => {
      if (err) {
        reject(err);
      } else {
        resolve(row);
      }
    });
  });
};

const runDeleteAsync = (db, sql, params = []) => {
  return new Promise((resolve, reject) => {
    db.run(sql, params, function (err) {
      if (err) {
        reject(err);
      } else {
        resolve(this.changes);
      }
    });
  });
};

const attemptDbOperation = async (db, operation, ...args) => {
  let attempts = 0;
  const maxAttempts = 5; // Number of maximum attempts
  while (attempts < maxAttempts) {
    try {
      return await operation(db, ...args);
    } catch (err) {
      if (err.code === "SQLITE_BUSY") {
        attempts++;
        console.warn(
          `Database is busy. Attempt ${attempts}/${maxAttempts}. Retrying...`
        );
        await new Promise((resolve) => setTimeout(resolve, 2000)); // Retry after 2 seconds
      } else {
        throw err;
      }
    }
  }
  throw new Error(
    "Max attempts reached. Could not complete database operation."
  );
};

module.exports = (db) => {
  // Route to get user information
  router.get("/user/:id", async (req, res) => {
    const { id } = req.params;

    try {
      // Fetch user information
      const userResult = await runAsync(
        db,
        `SELECT * FROM users WHERE id = ?`,
        [id]
      );

      // Check if user exists
      if (!userResult) {
        return res.status(404).json({ message: "User not found" });
      }

      // Send user information
      res.status(200).json({ user: userResult });
    } catch (error) {
      console.error("Error fetching user data:", error.message);
      res.status(500).json({ message: "Error fetching user data" });
    }
  });

  // Route to delete user account
  router.delete("/user/:id", async (req, res) => {
    const { id } = req.params;

    try {
      // Use transaction to ensure atomic operation
      await new Promise((resolve, reject) => {
        db.serialize(async () => {
          try {
            await attemptDbOperation(
              db,
              runDeleteAsync,
              `DELETE FROM users WHERE id = ?`,
              [id]
            );
            resolve();
          } catch (error) {
            reject(error);
          }
        });
      });

      res.status(200).json({ message: "User account deleted successfully" });
    } catch (error) {
      console.error("Error deleting user account:", error.message);
      res.status(500).json({ message: "Error deleting user account" });
    }
  });

  router.put("/user/:id", async (req, res) => {
    const { id } = req.params;
    const { name, phone, email, address } = req.body;

    // SQL query to update a user
    const sql = `UPDATE users SET name = ?, phone = ?, email = ?, address = ? WHERE id = ?`;

    try {
      await attemptDbOperation(db, runDeleteAsync, sql, [
        name,
        phone,
        email,
        address,
        id,
      ]);
      res.json({
        message: "User updated successfully",
        data: {
          id,
          name,
          phone,
          email,
          address,
        },
      });
    } catch (error) {
      console.error("Error updating user:", error.message);
      res.status(500).json({ message: "Error updating user" });
    }
  });


  router.get("/user", async (req, res) => {
    try {
      // Fetch all users
      const users = await runAsync(db, `SELECT id, name, phone FROM users`);

      // Send users information
      res.status(200).json(users);
    } catch (error) {
      console.error("Error fetching users:", error.message);
      res.status(500).json({ message: "Error fetching users" });
    }
  });
  return router;
};
