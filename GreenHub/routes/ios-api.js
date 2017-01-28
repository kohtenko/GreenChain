var express = require('express');
var router = express.Router();
var path = require('path');
const blockchain = require('../ethereum');

const device_types = { 'SolarPanel_01': 'type1', 'WindTurbine_01': 'type2' };
const device_names = { 'SolarPanel_01': 'Home Roof Solar Panel (Philips)', 'WindTurbine_01': 'BackYard Wind Turbine (Siemens)' };

router.get('/user/devices', function(req, res) {
  blockchain.getUserDevices(blockchain.user, (err, result) => {
    if (result) {
      const d = [];
      result.forEach((elt, i, array) => {
        const id = blockchain.web3.toAscii(elt).replace(/\0/g, '');
        d.push({
          id: id,
          type: device_types[id],
          name: device_names[id]
        });
      });
      res.send({ devices: d });
    } else {
      res.send({ devices: [] });
    }
  });
});

router.get('/device/energy/:deviceId', function(req, res) {
  console.log('Get request for ' + req.params.deviceId);
  blockchain.getDeviceAccumulatedEnergy(req.params.deviceId, (err, result) => {
    if (result) {
      const en = [];
      let sum = 0;
      result.forEach((elt, i, array) => {
        en.push(parseInt(elt));
        sum += parseInt(elt);
      });
      console.log(en);
      res.send({ energy: en });
    }
  });
});

router.get('/user/green-balance', function(req, res) {
  blockchain.getGreenBalance(blockchain.user, (err, result) => {
    res.send({ balance: parseInt(result) });
  });
});

const greenMarketGoods = {
  "Featured": [
    {
      "title": "Milk",
      "subtitle": "1L",
      "image": "f1",
      "price": 10,
      "description": "Milk is a pale liquid produced by the mammary glands of mammals. It is the primary source of nutrition for infant mammals (including humans who breastfeed)."
    },
    {
      "title": "Meat Beef",
      "subtitle": "1kg",
      "image": "f2",
      "price": 42,
      "description": "Beef is the culinary name for meat from cattle. Humans have been eating beef since prehistoric times. Beef is a complete source of protein, and provides many of the essential fatty acids, vitamins, and minerals that humans need."
    }
  ],
  "Organic Fruits": [
    {
      "title": "Apples",
      "subtitle": "1kg",
      "image": "1",
      "price": 9,
      "description": "The apple tree is a deciduous tree in the rose family best known for its sweet, pomaceous fruit, the apple. It is cultivated worldwide as a fruit tree, and is the most widely grown species in the genus Malus. "
    },
    {
      "title": "Bananas",
      "subtitle": "1kg",
      "image": "2",
      "price": 14,
      "description": "The banana is an edible fruit – botanically a berry – produced by several kinds of large herbaceous flowering plants in the genus Musa. In some countries, bananas used for cooking may be called plantains, in contrast to dessert bananas."
    },
    {
      "title": "Peaches",
      "subtitle": "1kg",
      "image": "3",
      "price": 22,
      "description": "The peach is a deciduous tree native to the region of Northwest China between the Tarim Basin and the north slopes of the Kunlun Shan mountains, where it was first domesticated and cultivated."
    }
  ],
  "Organic Vegetables": [
    {
      "title": "Tomatoes",
      "subtitle": "1kg",
      "image": "4",
      "price": 15,
      "description": "The tomato is the edible fruit of Solanum lycopersicum, commonly known as a tomato plant, which belongs to the nightshade family, Solanaceae. The species originated in Central and South America."
    },
    {
      "title": "Cucumbers",
      "subtitle": "1kg",
      "image": "5",
      "price": 7,
      "description": "Cucumber is a widely cultivated plant in the gourd family, Cucurbitaceae. It is a creeping vine that bears cucumiform fruits that are used as vegetables. There are three main varieties of cucumber: slicing, pickling, and seedless."
    },
    {
      "title": "Potatoes",
      "subtitle": "1kg",
      "image": "6",
      "price": 6,
      "description": "The potato is a starchy, tuberous crop from the perennial nightshade Solanum tuberosum. The word potato may refer either to the plant itself or to the edible tuber."
    }
  ],
  "Currency": [
    {
      "title": "Ether",
      "subtitle": "-",
      "image": "7",
      "price": 55,
      "description": "The crypto-fuel for the Ethereum network."
    },
    {
      "title": "Bitcoin",
      "subtitle": "-",
      "image": "8",
      "price": 256,
      "description": "Bitcoin is a digital asset designed by its inventor, Satoshi Nakamoto, to work as a currency."
    },
    {
      "title": "CHF",
      "subtitle": "-",
      "image": "9",
      "price": 35,
      "description": "CHF is the ISO currency code for the Swiss franc."
    }
  ]
};

router.get('/green-market/goods', function(req, res) {
  res.send(greenMarketGoods);
});

router.get('/green-market/buy/:good/:price', function(req, res) {
  blockchain.buy(blockchain.user, req.params.price, req.params.good, (err, result) => {
  });
  res.send({ result: 'Accepted' });
});

module.exports = router;
