const mongoose = require('mongoose');
const ProblemSchema = new mongoose.Schema({}, {strict: false});
const Problem = mongoose.model('Problem', ProblemSchema, 'problems');

module.exports = Problem;