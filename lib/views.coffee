timeslotsTmpl = Handlebars.compile """
{{#timeslots}}
  <article class="timeslot">
    <header><h1>{{description}}</h1></header>
    {{#sessions}}
      <article class="session">
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
{{/timeslots}}
"""

define module, 'MainView', ->
  Backbone.View.extend
    el: "body>section"

    render: ->
      @$el.html( timeslotsTmpl( @model.attributes ) )
