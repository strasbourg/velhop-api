request = require 'request'
moment = require 'moment'

exports.logRequest = (req, res, next) ->
  record =
    password: process.env.LOGGER_PASSWORD
    ip: req.header('x-forwarded-for')
    service: 'velhop'
    path: req.url
    params: ''
    time: moment().format()
  console.log record
  request
    url: 'http://stats.strasbourg-data.fr/track'
    method: 'POST'
    form: record
  next()
