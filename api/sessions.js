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

router.post('/load', (req, res) => {  
    const {userid} = req.body;
     
    connection.query('SELECT * FROM session', (error, results, field) => {
        if (error) throw error;
        console.log(userid);
        console.log(results);
        res.json(results);
      });
  });

router.post('/add', (req, res) => {
    let create_time = today().toLocaleTimeString();

    var name = req.body["name"];
    var category = req.body["category"];
    var currentorder = req.body["currrentorder"];
    var finalorder = req.body["finalorder"];
    var finaltime = req.body["finaltime"];
    var location = req.body["location"];

    connection.query(
        'INSERT INTO session (name, category, currentorder, finalorder, finaltime, location) VALUES (?, ?, ?, ?, ?, ?)',
        [name, category, currentorder, finalorder, finaltime, location], 
        (error, results, field) => {
        if (error) throw error
        else res.json(true)
      });
})

module.exports = router;