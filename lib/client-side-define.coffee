window.module = "this isn't node, so I'm not a thing"
window.define = (theirModule,moduleName,factory)->
  thing = factory()
  window[moduleName] = thing
