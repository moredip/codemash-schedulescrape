timeslotsTmpl = Handlebars.compile """
  <article class="timeslot">
    <header><h1>{{description}}</h1></header>
    {{#sessions}}
      <article class="session hidden">
        <header>
          <h1><a href="{{link}}">{{name}}</a></h1>
          <h2>in <span class="room">{{room}}</span></h2>
          <h2>presented by <span class="speakers">{{speakers}}</span></h2>
          <h2>from <span class="time">{{startTime}}</span> to <span class="time">{{endTime}}</span></h2>
        </header>
        <p>{{description}}</p>
      </article>
    {{/sessions}}
  </article>
"""

define module, 'MainView', ->
  Backbone.View.extend
    el: "body>section"

    render: ->
      @timeslots =
        _.map @model.attributes.timeslots, (a) -> new the.TimeSlotView( model: a )
      _.forEach @timeslots, (a) -> a.render()
      _.forEach @timeslots, (a) => @$el.append( a.el )

define module, 'TimeSlotView', ->
  Backbone.View.extend
    tagName: 'article'
    className: 'timeslot'
    events:
      "click .timeslot>header:first-child" : "toggle_sessions"

    render: ->
      @$el.html( timeslotsTmpl( @model ) )

    toggle_sessions: ->
      @$el.find('.session').toggleClass('hidden')
