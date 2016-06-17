# -*- encoding: utf-8 -*-
# stub: cocoapods-trunk 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "cocoapods-trunk"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Eloy Dur\u{e1}n"]
  s.date = "2016-05-10"
  s.email = ["eloy.de.enige@gmail.com"]
  s.homepage = "https://github.com/CocoaPods/cocoapods-trunk"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubygems_version = "2.4.8"
  s.summary = "Interact with trunk.cocoapods.org"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nap>, ["< 2.0", ">= 0.8"])
      s.add_runtime_dependency(%q<netrc>, ["= 0.7.8"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
    else
      s.add_dependency(%q<nap>, ["< 2.0", ">= 0.8"])
      s.add_dependency(%q<netrc>, ["= 0.7.8"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<nap>, ["< 2.0", ">= 0.8"])
    s.add_dependency(%q<netrc>, ["= 0.7.8"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
  end
end
