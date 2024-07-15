class CategoryService {
  constructor(db) {
    this.db = db;
  }

  getAllCategories() {
    return new Promise((resolve, reject) => {
      this.db.all(`SELECT * FROM categories`, [], (err, rows) => {
        if (err) {
          reject(new Error(`Error fetching categories: ${err.message}`));
        } else {
          resolve(rows);
        }
      });
    });
  }

  getCategoryById(catId) {
    return new Promise((resolve, reject) => {
      this.db.all(
        `SELECT * FROM categories WHERE catId = ?`,
        [catId],
        (err, rows) => {
          if (err) {
            reject(
              new Error(
                `Error fetching category with id ${catId}: ${err.message}`
              )
            );
          } else {
            resolve(rows);
          }
        }
      );
    });
  }
}
module.exports = CategoryService;
