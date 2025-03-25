const mongoose = require('mongoose');
const EmailCodeSchema   = new mongoose.Schema({}, { strict: false });
const EmailCode  = mongoose.model('EmailCode', EmailCodeSchema , 'emailCode');

module.exports = EmailCode;
