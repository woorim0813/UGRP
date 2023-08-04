const express = require('express');
const app = express();
var router = express.Router();

const mysql      = require('mysql2');

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
    const {userid, password} = req.body;
     
    connection.query('SELECT * FROM userdb WHERE userid=? AND password=?', [userid, password], (error, results, field) => {
      if (error) throw error;
        
        if (results.length > 0) {
          console.log('User info is: ', results);
          res.json(true);
        }
        else {
          res.json(false);  //일치하지 않는 경우
        }
      });
  });

module.exports = router;