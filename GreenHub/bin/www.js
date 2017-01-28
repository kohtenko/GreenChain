var app = require('../app');

app.set('port', 1333);

//TBD: https
var server = app.listen(app.get('port'), () => {
  console.log('GreenMarket Hub is started at: ' + server.address().port);
});
