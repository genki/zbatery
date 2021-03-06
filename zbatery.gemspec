# -*- encoding: binary -*-
ENV["VERSION"] or abort "VERSION= must be specified"
manifest = File.readlines('.manifest').map! { |x| x.chomp! }
require 'wrongdoc'
extend Wrongdoc::Gemspec
name, summary, title = readme_metadata

Gem::Specification.new do |s|
  s.name = %q{zbatery}
  s.version = ENV["VERSION"].dup

  s.authors = ["Zbatery hackers"]
  s.description = readme_description
  s.email = %q{rainbows-public@bogomips.org}
  s.executables = %w(zbatery)
  s.extra_rdoc_files = extra_rdoc_files(manifest)
  s.files = manifest
  s.homepage = Wrongdoc.config[:rdoc_url]
  s.summary = summary
  s.rdoc_options = rdoc_options
  s.rubyforge_project = %q{rainbows}

  # rainbows has a boatload of optional dependencies
  # required:
  #   unicorn + rack
  # optional:
  #   revactor + rev + iobuffer
  #   rev + iobuffer
  #   eventmachine
  #   espace-neverblock + eventmachine
  #   async_sinatra + sinatra + eventmachine
  #
  s.add_dependency(%q<rainbows>, ["~> 4.6"])
  s.add_development_dependency(%q<wrongdoc>, "~> 1.8")
  s.add_development_dependency(%q<isolate>, "~> 3.1")

  s.licenses = %w(GPLv2+ Ruby)
end
