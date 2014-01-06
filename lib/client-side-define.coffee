window.module = "this isn't node, so I'm not a thing"
window.the = {}

window.define = (theirModule,moduleName,factory)->
  thing = factory()
  window.the[moduleName] = thing
