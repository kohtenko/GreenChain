var express = require('express');
var router = express.Router();

router.get('/', function(req, res) {
  res.send('Green Market Hub');
});

module.exports = router;
