const mongoose = require('mongoose');
const AnswerSchema = new mongoose.Schema({}, {strict: false});
const Answer = mongoose.model('Answer', AnswerSchema, 'answers');

module.exports = Answer;