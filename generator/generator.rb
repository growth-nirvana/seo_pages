require "json"
require "erb"
require "date"

class Generator
  attr_reader :name, :fivetran_id, :permalink, :destination_path, :overview_description, :body_description

  # @param name [String] name of the connector to generate. i.e. Google Ads, Facebook Ads
  # @param fivetran_id [String] fivetran id of the connector to generate
  # @param overview_description [String] description of the connector to generate
  # @param body_description [String] short description of the connector to generate
  def initialize(name, fivetran_id, overview_description, body_description)
    @name = name
    @fivetran_id = fivetran_id
    @destination_path = "./_connectors/#{fivetran_id}.md"
    @overview_description = overview_description
    @body_description = body_description
  end

  # Generates a landing page for the connector
  #
  # @param override [Boolean] if true, the file will be overriden if it already exists
  def generate(override = false)
    if File.exist?(destination_path) && !override
      puts "File #{destination_path} already exists"
    else
      File.open(destination_path, 'w') do |f|
        f.write(
          ERB.new(File.read("./generator/template.md.erb")).result_with_hash(
            name: name,
            date: Date.today,
            permalink: fivetran_id,
            overview_description: overview_description,
            body_description: body_description
          )
        )
      end
    end
  end
end
