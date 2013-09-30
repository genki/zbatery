# -*- encoding: binary -*-
autoload :Gem, 'rubygems'

cgit_url = "http://bogomips.org/zbatery.git"
git_url = 'git://bogomips.org/zbatery.git'

desc "read news article from STDIN and post to rubyforge"
task :publish_news do
  require 'rubyforge'
  spec = Gem::Specification.load('zbatery.gemspec')
  tmp = Tempfile.new('rf-news')
  _, subject, body = `git cat-file tag v#{spec.version}`.split(/\n\n/, 3)
  tmp.puts subject
  tmp.puts
  tmp.puts spec.description.strip
  tmp.puts ""
  tmp.puts "* #{spec.homepage}"
  tmp.puts "* #{spec.email}"
  tmp.puts "* #{git_url}"
  tmp.print "\nChanges:\n\n"
  tmp.puts body
  tmp.flush
  system(ENV["VISUAL"], tmp.path) or abort "#{ENV["VISUAL"]} failed: #$?"
  msg = File.readlines(tmp.path)
  subject = msg.shift
  blank = msg.shift
  blank == "\n" or abort "no newline after subject!"
  subject.strip!
  body = msg.join("").strip!

  rf = RubyForge.new.configure
  rf.login
  rf.post_news('rainbows', subject, body)
end

desc "post to FM"
task :fm_update do
  require 'tempfile'
  require 'net/http'
  require 'net/netrc'
  require 'json'
  version = ENV['VERSION'] or abort "VERSION= needed"
  uri = URI.parse('http://freecode.com/projects/zbatery/releases.json')
  rc = Net::Netrc.locate('zbatery-fm') or abort "~/.netrc not found"
  api_token = rc.password
  _, subject, body = `git cat-file tag v#{version}`.split(/\n\n/, 3)
  tmp = Tempfile.new('fm-changelog')
  system(ENV["VISUAL"], tmp.path) or abort "#{ENV["VISUAL"]} failed: #$?"
  changelog = File.read(tmp.path).strip

  req = {
    "auth_code" => api_token,
    "release" => {
      "tag_list" => "Stable",
      "version" => version,
      "changelog" => changelog,
    },
  }.to_json
  Net::HTTP.start(uri.host, uri.port) do |http|
    p http.post(uri.path, req, {'Content-Type'=>'application/json'})
  end
end
