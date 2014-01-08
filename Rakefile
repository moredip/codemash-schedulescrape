CODEMASH_BASE_NAME = 'codemash2014'

desc "pull latest JSON"
task "pull" do
  require 'json'
  raw = `curl -s -H "Content-Type: application/json" --data "{}" https://eventboard.falafel.com/ConferenceService2/ConferenceListEx`
  #raw = `cat all-the-things.json`
  conferences = JSON.parse(raw)

  codemash = conferences.find{ |conf| conf['BaseName'] == CODEMASH_BASE_NAME }
  data_version = codemash['DataVersion']
  lets_build_urls_on_the_client = "http://cdn.eventboard.falafel.com/conferencecatalogs/#{CODEMASH_BASE_NAME}.#{data_version}.data.json"

  `curl #{lets_build_urls_on_the_client} | python -m json.tool > public/catalog.json`

  puts 'updated catalog.json via ConferenceListEx'
end

if ENV.key? "MICROSTATIC_SITE_NAME"
  require 'microstatic/rake'

  desc "deploy to codemash.thepete.net"
  Microstatic::Rake.s3_deploy_task(:deploy) do |task|
    task.source_dir = File.expand_path("../public",__FILE__)
    task.bucket_name = "codemash.thepete.net"
  end
end
