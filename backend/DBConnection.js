/* eslint-disable no-console */
const mysql = require('mysql2');

const pool = mysql
  .createPool({
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: 'mans',
    database: 'newstore',
  })
  .promise();

module.exports = { pool };
