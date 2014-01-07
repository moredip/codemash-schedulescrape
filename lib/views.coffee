timeslotsTmpl = Handlebars.compile """
{{#timeslots}}
  <article class="timeslot">
    <header><h1>{{description}}</h1></header>
    {{#sessions}}
      <article class="session">
        <h1>{{name}}</h1>
        <p>{{description}}</p>
      </article>
      <hr/>
    {{/sessions}}
  </article>
{{/timeslots}}
"""

define module, 'MainView', ->
  Backbone.View.extend
    el: "body>section"

    render: ->
      @$('#timeslots').html( timeslotsTmpl( @model.attributes ) )
