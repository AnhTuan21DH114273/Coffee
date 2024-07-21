const express = require("express");
const SignUpRouter = require("./routes/SignUp");
const SignInRouter = require("./routes/SignIn");
const OtpRouter = require("./routes/Otp");
const db = require("./data/database");
const ProductRoutes = require("./routes/Products")(db);
const categoriesRoutes = require("./routes/Categories")(db);
const OrderRoutes = require("./routes/Orders")(db);
const OrderItemRoutes = require("./routes/OrderItem")(db);
const UserRoutes = require("./routes/User")(db);
require("dotenv").config();


const app = express();
const port = 3000;

// Sử dụng middleware để phân tích JSON
app.use(express.json());

// Khai báo router SignUp và truyền vào db
const SignUp = SignUpRouter(db);
app.use("/api/auth", SignUp);

// Khai báo router SignIn và truyền vào db
const SignIn = SignInRouter(db);
app.use("/api/auth", SignIn);

// Khai báo router Otp và truyền vào db
const Otp = OtpRouter(db);
app.use("/api", Otp);

app.use("/api", ProductRoutes)
app.use("/api", categoriesRoutes);

app.use("/api", OrderRoutes);
app.use("/api", OrderItemRoutes);
app.use("/api", UserRoutes);

const server = app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
server.on("close", () => {
  console.log("Server closed");
});
