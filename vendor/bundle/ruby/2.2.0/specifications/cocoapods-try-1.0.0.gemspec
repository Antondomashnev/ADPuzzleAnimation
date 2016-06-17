# -*- encoding: utf-8 -*-
# stub: cocoapods-try 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "cocoapods-try"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Fabio Pelosin"]
  s.date = "2016-05-10"
  s.homepage = "https://github.com/cocoapods/cocoapods-try"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "CocoaPods plugin which allows to quickly try the demo project of a Pod."

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
  end
end
