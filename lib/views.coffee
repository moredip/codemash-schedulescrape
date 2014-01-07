timeslotsTmpl = Handlebars.compile """
{{#timeslots}}
  <div class="timeslot">{{description}}</div>
{{/timeslots}}
"""

define module, 'MainView', ->
  Backbone.View.extend
    el: "body>section"

    render: ->
      @$('#timeslots').html( timeslotsTmpl( @model.attributes ) )
