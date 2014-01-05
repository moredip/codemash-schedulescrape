fromJson = (json)-> 
  speakers = json.Speakers

  {
    speakers: -> speakers
  }

define module,  ->
  { fromJson }
