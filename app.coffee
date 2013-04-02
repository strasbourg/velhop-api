express = require 'express'
request = require 'request'
parseString = require('xml2js').parseString
logRequest = require('./log_request').logRequest

URL = 'http://velhop.strasbourg.eu/tvcstations.xml'

app = express()

app.get '/', (req, res) -> res.redirect('/stations')

app.get '/stations', logRequest, (req, res) ->
  request
    url: URL
    (e, r, body) ->
      parseString body, (e, results) ->
        res.json results.vcs.sl[0].si.map (item) ->
          item = item.$
          ['id', 'av', 'fr', 'to', 'cb'].forEach (key) ->
            item[key] = parseInt item[key] if item[key]
          ['la', 'lg'].forEach (key) ->
            item[key] = parseFloat item[key] if item[key]
          return item

app.listen process.env.PORT || 3000
