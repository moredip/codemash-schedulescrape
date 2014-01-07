catalog = require('../lib/catalog')

describe 'catalog parsing', ->
  catalogJSON = require('./fixtures/full-catalog.json')

  loadCatalog = -> catalog.fromJson( catalogJSON )

  describe 'speakers', ->
    speakers = loadCatalog().speakers()

    it 'has speakers', ->
      expect( speakers ).not.to.be.empty

    it 'should list a specific speaker', ->
      pete = _.findWhere( speakers, {FirstName:'Pete',LastName:'Hodgson'} )
      expect(pete).to.exist

  describe 'timeslots', ->
    timeslots = loadCatalog().timeslots()

    it 'contains timeslots in the catalog', ->
      expect( timeslots ).not.to.be.empty

    halfDayTuesdayTimeSlot = loadCatalog().timeslotById('21915')

    it 'looks up a timeslot by id', ->
      expect( halfDayTuesdayTimeSlot ).to.exist
      expect( halfDayTuesdayTimeSlot.Description ).to.equal( '1/7/2014 8:30am to 12:30pm' )

    it 'handles looking up an invalid timeslot id', ->
      expect( loadCatalog().timeslotById('bad id') ).not.to.exist

    it 'has a start and end time for display', ->
      halfDayTuesdayTimeSlot = loadCatalog().timeslotById('21915')
      expect( halfDayTuesdayTimeSlot.startTimeForDisplay() ).to.equal( "8:30" )
      expect( halfDayTuesdayTimeSlot.endTimeForDisplay() ).to.equal( "12:30" )

  it 'lists all sessions in a timeslot', ->
    tuesdayAllDayTimeslot = loadCatalog().timeslotById('21914')
    sessions = tuesdayAllDayTimeslot.sessions()
    expect( sessions ).not.to.be.empty

    sessionNames = _.pluck( sessions, 'Name' )
    
    expect( sessionNames ).to.contain('ASP.NET MVC Workshop -- FULL DAY')
    expect( sessionNames ).to.contain('Building WinPhone Apps -- FULL DAY')
    expect( sessionNames ).to.contain('Hands-on Rails in the Cloud -- FULL DAY')

  describe 'rooms', ->
    it 'looks up room by id', ->
      ironWood = loadCatalog().roomById('4212')
      expect( ironWood ).to.exist
      expect( ironWood.Name ).to.equal('Ironwood')

  describe 'speakers', ->
    it 'looks up speaker by id', ->
      pete = loadCatalog().speakerById('27345')
      expect( pete ).to.exist
      expect( pete.name() ).to.equal('Pete Hodgson')


  describe 'sessions', ->
    buildLightSaberSession = loadCatalog().sessionById('26053')

    it 'looks up session by id', ->
      expect( buildLightSaberSession ).to.exist
      expect( buildLightSaberSession.Name ).to.equal("Building your own lightsaber: Arduino + Pi + Node.js == build light")

    it 'has a room', ->
      expect( buildLightSaberSession.room() ).to.exist
      expect( buildLightSaberSession.room().Name ).to.equal('Salon A')

    it 'has speakers', ->
      expect( buildLightSaberSession.speakers() ).to.exist
      expect( buildLightSaberSession.speakers().length ).to.equal(1)
      expect( buildLightSaberSession.speakers()[0].name() ).to.equal('Pete Hodgson')

    it 'has a timeslot', ->
      expect( buildLightSaberSession.timeslot() ).to.exist
      expect( buildLightSaberSession.timeslot().Description ).to.equal('1/10/14 1:45pm to 2:45pm')

