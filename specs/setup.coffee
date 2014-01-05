chai = require('chai')
global.expect = chai.expect
sinonChai = require("sinon-chai")
chai.use(sinonChai)

global.sinon = require('sinon')
