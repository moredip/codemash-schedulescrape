catalog = require('../lib/catalog')

console.dir catalog

describe 'catalog parsing', ->
  catalogJSON = require('./fixtures/full-catalog.json')

  loadCatalog = -> catalog.fromJson( catalogJSON )

  it 'should list speakers', ->
    expect( loadCatalog().speakers() ).not.to.be.empty
