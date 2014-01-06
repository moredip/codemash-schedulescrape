window.define = (theirModule,moduleName,factory)->
  thing = factory()
  window[moduleName] = thing
