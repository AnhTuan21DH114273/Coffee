const express = require("express");
const SignUpRouter = require("./routes/SignUp");
const SignInRouter = require("./routes/SignIn");
const OtpRouter = require("./routes/Otp"); 
const db = require("./data/database"); 


const app = express();
const port = 3000;



// Khai báo router SignUp và truyền vào db
const SignUp = SignUpRouter(db);
app.use(express.json());
app.use("/api/auth", SignUp);

const SignIn = SignInRouter(db);
app.use("/api/auth", SignIn);

const Opt = OtpRouter(db);
app.use("/api", Opt);

const server = app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
server.on("close", () => {
  console.log("Server closed");
});
