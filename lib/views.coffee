timeslotsTmpl = Handlebars.compile """
{{#timeslots}}
  <article class="timeslot">
    <header><h1>{{description}}</h1></header>
    {{#sessions}}
      <article class="session">
        <a href="{{link}}"><h1>{{name}}</h1></a>
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
