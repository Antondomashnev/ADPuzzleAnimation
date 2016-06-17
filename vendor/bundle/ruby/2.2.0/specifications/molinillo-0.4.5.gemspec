# -*- encoding: utf-8 -*-
# stub: molinillo 0.4.5 ruby lib

Gem::Specification.new do |s|
  s.name = "molinillo"
  s.version = "0.4.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Samuel E. Giddins"]
  s.date = "2016-04-30"
  s.email = ["segiddins@segiddins.me"]
  s.homepage = "https://github.com/CocoaPods/Molinillo"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "Provides support for dependency resolution"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.5"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.5"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.5"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
