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

//송현민 PART
//기능3. 세부 정보 로드
app.post('/specificload', (req, res) => {
  
  var name = req.body["name"];
  var category = req.body["catergory"];
  var currentorder = req.body["currentorder"];
  var finalorder = req.body["finalorder"];
  var finaltime = req.body["finaltime"];
  var location = req.body["location"];

  connection.query(
    'SELECT * FROM session WHERE name = ?, category = ?, currentorder = ?, finalorder = ?, finaltime = ?, location = ?' ,[name, category, currentorder, finalorder, finaltime, location], (error, results, field) => {
      if(error) throw error
      else{
        console.log('Name is :', results.session.name);   //안되면 session 빼고 표현하기
        console.log('category is :', results.session.category);
        console.log('currentorder is :',results.session.currentorder);
        console.log('finalorder is :',results.session.finalorder);
        console.log('finaltime is :', results.session.finaltime);
        console.log('location is :', results.session.location);
        res.json(result);
      }});
});


//20230827 11:48 수정 - 김정우 PART
//기능4. 세션 삭제(자동!)
var del_timer = setInterval(del_session, 1000); //1초마다 실행

function del_session() {
  connection.query('DELETE FROM session WHERE NOW() = DATEADD(minute, finaltime, create_time)', 
    (error, results, field) => {
      if (error) throw error;
  });
}

//기능5. 주문(세션 참여)페이지에 쓰일 음식 및 가격 정보 제공
//dinerDB - {name(음식점), food(음식), price(가격), photo(음식사진)} 정보가 있는 DB
app.post('/order', (req, res) => {
  var name = req.body['name'];
  
  connection.query(
    'SELECT food, price, photo FROM dinerDB WHERE name=?', [name], 
    (error, results, field) => {
    if (error) throw error;
    return res.json(results);
  });
});




module.exports = router;
