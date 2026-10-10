const mysql = require("mysql2/promise");//loads mysql library
require("dotenv").config();//loads value from env file

const pool = mysql.createPool({//creates a pool so our backend can communicate with mysql database
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
});

module.exports = pool;