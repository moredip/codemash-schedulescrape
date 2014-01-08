
desc "pull latest JSON"
task "pull" do
  output = `curl -s -H "Content-Type: application/json" --data "{}" https://eventboard.falafel.com/ConferenceService2/ConferenceListEx`
  puts output
end

if ENV.key? "MICROSTATIC_SITE_NAME"
  require 'microstatic/rake'

  desc "deploy to codemash.thepete.net"
  Microstatic::Rake.s3_deploy_task(:deploy) do |task|
    task.source_dir = File.expand_path("../public",__FILE__)
    task.bucket_name = "codemash.thepete.net"
  end
end
