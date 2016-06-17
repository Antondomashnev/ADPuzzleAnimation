#!/usr/bin/env ruby

require 'json'
require 'open-uri'
require 'set'

GEMS = %w(rails capybara bundler github-linguist).freeze

VERSION_PATTERN = /\A
  [0-9]+\.[0-9]+\.[0-9]+           (?# Number component)
  ([-][0-9a-z-]+(\.[0-9a-z-]+)*)?  (?# Pre-release component)
  ([+][0-9a-z-]+(\.[0-9a-z-]+)*)?  (?# Build component)
    \Z/xi

def coerce_to_semver(version)
  return version if version.sub(/^(\S+\s+)/, '') =~ VERSION_PATTERN
  return "#{Regexp.last_match[1]}#{Regexp.last_match[2]}" if version =~ /^(\S+\s+)? (\d+\.\d+\.\d+) (?: \.\d+)*$/ix

  parts = version.split(/[\.-]/, 4)
  4.times do |i|
    if parts[i] =~ /-?([a-zA-Z])/
      parts << '0' until parts.size >= 3
      parts[i].sub!(/-?([a-zA-Z]+)/, '')
      parts[i] = '0' if parts[i].empty?
      parts[3] = Regexp.last_match[1] + parts[i..-1].join('')
    end
  end
  semver = parts[0..2].join('.')
  semver.sub!(/([a-zA-Z])/, '-\1')
  semver += '-' + parts[-1] if parts.size > 3
  semver
end

def coerce_dependencies_to_semver(deps)
  dependencies = {}
  deps.sort_by(&:first).each do |name, req|
    dependencies[name] = req.split(',').map { |r| coerce_to_semver(r) }.join(',')
  end
  dependencies
end

gems = Set.new(GEMS)
downloaded_gems = Set.new
specs = []

loop do
  size = gems.size
  (gems ^ downloaded_gems).each_slice(200) do |g|
    specs += JSON.load open("http://bundler.rubygems.org/api/v1/dependencies.json?gems=#{g.join(',')}")
  end
  downloaded_gems.merge(gems)

  gems.merge(specs.flat_map { |s| s['dependencies'].map(&:first) })

  break if gems.size == size
end

specs.reject! { |s| s['platform'] != 'ruby' }
specs.uniq! { |s| [s['name'], s['number']] }
specs.sort_by! { |s| s['name'].downcase }
specs = specs.group_by { |s| s['name'] }.values.map do |spec|
  [spec.first['name'], spec.flat_map do |s|
    {
      'name' => s['name'],
      'version' => coerce_to_semver(s['number']),
      'dependencies' => coerce_dependencies_to_semver(s['dependencies'])
    }
  end.uniq { |s| s['version'] }.sort_by { |s| Gem::Version.new(s['version']) }
  ]
end

specs = Hash[specs]

json = JSON.generate(specs)

File.open("index/rubygems-#{Date.today}.json", 'w') { |f| f.write json }
