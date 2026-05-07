const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "weekend_albania"
});

db.connect(err => {
    if(err) {
        console.log(err);
    } else {
        console.log("MySQL Connected");
    }
});

app.post("/register", (req, res) => {

    const { email, password } = req.body;

    db.query(
        "INSERT INTO users(email,password) VALUES (?,?)",
        [email,password],
        (err,result) => {

            if(err) {
                res.send(err);
            } else {
                res.send("User Registered");
            }
        }
    );
});

app.post("/login", (req,res) => {

    const { email, password } = req.body;

    db.query(
        "SELECT * FROM users WHERE email=? AND password=?",
        [email,password],
        (err,result) => {

            if(result.length > 0) {
                res.send("Login Success");
            } else {
                res.send("Wrong Credentials");
            }
        }
    );
});

app.listen(5000, () => {
    console.log("Server Running on Port 5000");
});