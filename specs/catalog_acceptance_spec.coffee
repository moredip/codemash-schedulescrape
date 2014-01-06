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

    it 'should contain some timeslots', ->
      expect( timeslots ).not.to.be.empty

    it 'should contain a specific expected timeslot', ->
      firstThingFriday = _.findWhere( timeslots, {Description:"1/10/2014 8:15am to 9:15am"} )
      expect( firstThingFriday ).to.exist

    it 'looks up a timeslot by id', ->
      halfDayTuesdaySession = loadCatalog().timeslotById('21915')
      expect( halfDayTuesdaySession ).to.exist
      expect( halfDayTuesdaySession.Description ).to.equal( '1/7/2014 8:30am to 12:30pm' )

    it 'handles an invalid timeslot id', ->
      expect( loadCatalog().timeslotById('bad id') ).not.to.exist

  it 'lists all sessions in a timeslot', ->
    tuesdayAllDayTimeslot = loadCatalog().timeslotById('21914')
    sessions = tuesdayAllDayTimeslot.sessions()
    expect( sessions ).not.to.be.empty

    sessionNames = _.pluck( sessions, 'Name' )
    
    expect( sessionNames ).to.contain('ASP.NET MVC Workshop -- FULL DAY')
    expect( sessionNames ).to.contain('Building WinPhone Apps -- FULL DAY')
    expect( sessionNames ).to.contain('Hands-on Rails in the Cloud -- FULL DAY')

