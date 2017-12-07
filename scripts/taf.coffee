module.exports = (robot) ->

  robot.respond /taf ?me (.{4})/i, (msg) ->
    tafMe msg, msg.match[1], (found, result) ->
      if !found
        msg.send "I don't know what \"#{msg.match[1]}\" is"
        return
      msg.send "#{result}"

tafMe = (msg, query, callback) ->
  msg.http("http://tgftp.nws.noaa.gov/data/forecasts/taf/stations/#{escape(query)}.TXT")
    .get() (err, res, body) ->
      if !err && res.statusCode == 200
        callback(true, body)
      else
        callback(false)
