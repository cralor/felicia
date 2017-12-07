module.exports = (robot) ->

  robot.respond /metar ?me ([K].{3})/i, (msg) ->
    metarMe msg, msg.match[1], (found, result) ->
      if !found
        msg.send "I don't know what \"#{msg.match[1]}\" is"
        return
      msg.send "#{result}"

metarMe = (msg, query, callback) ->
  msg.http("http://tgftp.nws.noaa.gov/data/observations/metar/stations/#{escape(query)}.TXT")
    .get() (err, res, body) ->
      if !err && res.statusCode == 200
        callback(true, body)
      else
        callback(false)
