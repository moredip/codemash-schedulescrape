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

    events:
      "click .expand-all" : "expandAll"

    initialize: ->
      @model.on( 'change:timeslots', @render, @ )

    render: ->
      $timeslots = @$el.find('.timeslots')
      $timeslots.empty()
      @model.get('timeslots').each (t) ->
        timeslotView = new the.TimeSlotView( model: t )
        $timeslots.append( timeslotView.render().el )

     expandAll: ->
       @model.expandAllTimeslots()

define module, 'TimeSlotView', ->
  Backbone.View.extend
    tagName: 'article'
    className: 'timeslot'
    events:
      "click .timeslot>header:first-child" : "onClickHeader"

    initialize: ->
      @model.on( 'change', @refresh, @ )

    render: ->
      @$el.html( timeslotsTmpl( @model.attributes ) )
      @refresh()
      @

    refresh: ->
      @$el.find('.session').toggleClass( 'hidden', @model.get('collapsed') )

    onClickHeader: ->
      @model.toggleCollapsed()
