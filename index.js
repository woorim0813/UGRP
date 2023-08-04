var express    = require('express');
var app        = express();
var bodyParser = require('body-parser');

app.use(express.json());
app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());

var loginroute = require('./api/login.js');
var signuproute = require('./api/signup.js');
var sessionsroute = require('./api/sessions.js');

app.use('/login', loginroute);
app.use('/signup', signuproute);
app.use('/sessions', sessionsroute);

app.listen(3000, () => console.log('Server is up on port 3000!'));