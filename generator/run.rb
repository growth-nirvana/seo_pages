require_relative "generator"

# This is the entry point of the generator
# It reads the connectors.json file and generates a landing page for each connector
class Run
  def initialize
    @connectors = JSON.parse(File.read("./connectors.json"))
  end

  def run
    @connectors.keys.each do |connector|
      Generator.new(
        connector,
        connector["fivetran_id"],
        connector["overview"]["description"],
        connector["body"]["description"]
      ).generate
    end
  end
end

