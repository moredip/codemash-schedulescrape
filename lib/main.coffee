CATALOG_URL = "/catalog.json"

$ ->
  $.getJSON( CATALOG_URL ).then (catalogJson)->
    catalog = the.catalog.fromJson(catalogJson)
    console.dir(catalog)
