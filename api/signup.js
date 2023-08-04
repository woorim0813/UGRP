const express   = require('express');
const app       = express();
var router      = express.Router();

const mysql     = require('mysql2');

const connection = mysql.createConnection({
    host:       '127.0.0.1',
    user:       'root',
    password:   '1234',
    database:   'my_db',
    port:       '3305'
});

router.use((req, res, next) => {
    console.log('middleware for users!');
    next();
});

router.post('/', (req, res) => { 
    var name = req.body['username'];
    var id = req.body['userid'];
    var pw = req.body['password'];
    
    connection.query(
      'INSERT INTO userdb (username, userid, password) VALUES (?, ?, ?)',
      [name, id, pw], 
      (error, results, field) => {
      if (error) throw error
      else res.json(true)
    });
  }
);

module.exports = router