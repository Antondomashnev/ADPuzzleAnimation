# -*- encoding: utf-8 -*-
# stub: cocoapods-search 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "cocoapods-search"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Eloy Dur\u{e1}n", "Fabio Pelosin", "Emma Koszinowski"]
  s.date = "2016-05-10"
  s.description = "Search for pods."
  s.email = ["eloy.de.enige@gmail.com", "fabiopelosin@gmail.com", "emkosz@gmail.com"]
  s.homepage = "https://github.com/CocoaPods/cocoapods-search"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "Searches for pods, ignoring case, whose name matches `QUERY`. If the `--full` option is specified, this will also search in the summary and description of the pods."

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
