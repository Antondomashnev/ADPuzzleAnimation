require 'fourflusher/simctl'
require 'rubygems/version'

module Fourflusher
  # Metadata about an installed Xcode simulator
  class Simulator
    attr_reader :id
    attr_reader :name
    attr_reader :os_name
    attr_reader :os_version

    def self.match(line, os_name, os_version)
      sims = []
      @@sim_regex.match(line) { |m| sims << Simulator.new(m, os_name, Gem::Version.new(os_version)) }
      sims
    end

    def compatible?(other_version)
      other_version <= os_version
    end

    def to_s
      "#{@name} (#{@id}) - #{@os_name} #{@os_version}"
    end

    private

    @@sim_regex = /^\s*(?<sim_name>[^\)]*?) \((?<sim_id>[^\)]*?)\) \((?<sim_state>[^\)]*?)\)$/

    def initialize(match_data, os_name, os_version)
      @id = match_data['sim_id']
      @name = match_data['sim_name']
      @os_name = os_name
      @os_version = os_version
    end
  end

  # -- iOS 9.2 --
  #     iPhone 4s (C0404A23-2D2D-4208-8CEC-774194D06759) (Shutdown)
  #     iPhone 5 (7A0F62DD-8330-44F0-9828-AC8B1BC9BF05) (Shutdown)
  #     iPhone 5s (51C1CB50-FBCB-47ED-B8FF-68C816BF0932) (Shutdown)
  #     iPhone 6 (6F4E143A-6914-476E-90BF-51B680B8E2EF) (Shutdown)
  #     iPhone 6 Plus (BEB9BFE9-AF1A-4FEA-9FA5-CAFD5243CA42) (Shutdown)
  #     iPhone 6s (98DB904B-DF98-4F3C-AB21-A4D133604BA4) (Shutdown)
  #     iPhone 6s Plus (65838307-4C03-4DD3-84E4-A6477CFD3490) (Shutdown)
  #     iPad 2 (349C1313-6C9C-48C6-8849-DAB18BE2F15C) (Shutdown)
  #     iPad Retina (30909168-4C90-48CD-B142-86DCF7B1372A) (Shutdown)
  #     iPad Air (A8B5F651-C215-459C-95C6-663194F2277B) (Shutdown)
  #     iPad Air 2 (BFDB363E-D514-490C-A1D6-AC86402089BA) (Shutdown)
  #     iPad Pro (AE5DA548-66F6-4FCE-AA6D-5E6E17CD721E) (Shutdown)
  # -- tvOS 9.1 --
  #     Apple TV 1080p (C5A44868-685C-4D72-BEBD-102246C870F7) (Shutdown)
  # -- watchOS 2.1 --
  #     Apple Watch - 38mm (FE557B65-A044-44C3-96AC-2EAC395A6090) (Shutdown)
  #     Apple Watch - 42mm (C9138FAE-6812-4BB5-A463-76520C116AF4) (Shutdown)

  # Executes `simctl` commands
  class SimControl
    def initialize
      @os_regex = /^-- (?<os_name>.*?) (?<os_version>[0-9][0-9]?\.[0-9]) --$/
    end

    def simulator(filter, minimum_version = '1.0')
      usable_simulators(filter, minimum_version).first
    end

    def usable_simulators(filter = nil, minimum_version = '1.0')
      os_name = ''
      os_version = ''
      sims = []

      list(['devices']).lines.each do |line|
        @os_regex.match(line) do |m|
          os_name = m['os_name']
          os_version = m['os_version']
        end
        sims += Simulator.match(line, os_name, os_version)
      end

      return sims if filter.nil?
      minimum_version = Gem::Version.new(minimum_version)
      sims.select { |sim| sim.name == filter && sim.compatible?(minimum_version) }
    end
  end
end
