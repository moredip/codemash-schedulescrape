global.define = (theirModule,factory)->
  thing = factory()
  theirModule.exports = thing

chai = require('chai')
global.expect = chai.expect
sinonChai = require("sinon-chai")
chai.use(sinonChai)

global.sinon = require('sinon')
global._ = require('underscore')
