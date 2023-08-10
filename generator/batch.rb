require_relative "generator"

# This is the entry point of the generator
# It reads the connectors.json file and generates a landing page for each connector
class Batch
  def initialize
    @connectors = JSON.parse(File.read("./connectors.json"))
  end

  def run
    @connectors.keys.each do |connector|
      Generator.new(
        connector,
        @connectors[connector]["fivetran_id"],
        @connectors[connector]["overview"]["description"],
        @connectors[connector]["body"]["description"]
      ).generate
    end
  end
end

