Q = require('q')
createController = require('../lib/controller')

describe 'the main controller', ->

  describe 'boot', ->
    genericPromise = Q('blah')
    genericFakeCatalog = { timeslots: -> 'fake timeslots' }

    createIsolatedController = (explicitDependencies = {})->
      defaultDeps = {
        jsonFetcher: sinon.stub().returns(genericPromise)
        timeslotsViewModelMapper: -> "blah"
        catalogCreator: -> genericFakeCatalog
      }

      createController( _.extend( {}, defaultDeps, explicitDependencies ) )


    it 'makes an ajax call to load the catalog', ->
      spyJsonFetcher = sinon.stub().returns(genericPromise)

      controller = createController({jsonFetcher:spyJsonFetcher})
      controller.boot()

      expect( spyJsonFetcher ).called
      expect( spyJsonFetcher.lastCall.args.length ).equal(1)

    it 'turns the raw JSON into a catalog', (done)->
      fakeJsonFetch = Q('fake catalog json')
      stubJsonFetcher = -> fakeJsonFetch

      spyCatalogCreator = sinon.stub().returns( genericFakeCatalog )

      controller = createIsolatedController({jsonFetcher:stubJsonFetcher,catalogCreator:spyCatalogCreator})
      controller.boot().then ->
        expect( spyCatalogCreator ).calledWith('fake catalog json')
        done()

    it "populates the main model with a view model from the catalog's timeslots", (done)->
      fakeCatalog = {
        timeslots: -> 'fake timeslots'
      }
      stubCatalogCreator = sinon.stub().returns( fakeCatalog )
      spyViewModelMapper = sinon.stub().returns( 'fake view model' )

      controller = createIsolatedController( catalogCreator: stubCatalogCreator, timeslotsViewModelMapper: spyViewModelMapper )

      controller.boot().then ->
        expect( spyViewModelMapper ).calledWith('fake timeslots')
        done()
