{exec} = require 'child_process'
moment = require 'moment-timezone'
winston = require 'winston'
winston.add winston.transports.File, { filename: 'runTests.log' }
winston.remove winston.transports.Console

PATH_MOCHA = 'casperjs test tests/main.test.js --ssl-protocol=tlsv1 --verbose --log-level=info'


exec PATH_MOCHA, (error, stdout, stderr) ->
  winston.error error if error?
  console.log error
  console.log stderr
  console.log stdout
  # logOfTests = []
  # stdout = JSON.parse stdout

  # for key, val of stdout.tests
  #   logOfTests.push {
  #     comment: if val.err isnt undefined then val.err else 'duration: ' + val.duration
  #     status: if val.err isnt undefined then 'failed' else 'passed'
  #     sentence: val.title
  #   }

  # doc =
  #   identificator: bySite()
  #   requirement: 'metrics-api-tests'
  #   status: if !error? then 'passed' else 'failed'
  #   dateTimeResult: moment().tz('Europe/Prague').format 'YYYY-MM-D, HH:mm'
  #   duration: stdout.stats.duration
  #   report: logOfTests

  # request(PATH_API).post('/api/v1/results').send(doc).end (e, res) ->
  #   winston.error e, res if e