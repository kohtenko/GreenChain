const express = require('express');
const path = require('path');
const favicon = require('serve-favicon');
const logger = require('morgan');
const bodyParser = require('body-parser');

const index = require('./routes/index');
const deviceInstallation = require('./routes/device-installation');
const iosApi = require('./routes/ios-api');

const greenHubSoftware = require('./green-hub-software');

const app = express();

app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true
}));
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', index);
app.use('/device-installation', deviceInstallation);
app.use('/ios-api', iosApi);

module.exports = app;
