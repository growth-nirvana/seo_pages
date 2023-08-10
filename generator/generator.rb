require "json"

class Generator
  attr_reader :name, :fivetran_id, :permalink, :destination_path, :overview_description, :body_description

  # @param name [String] name of the connector to generate. i.e. Google Ads, Facebook Ads
  # @param fivetran_id [String] fivetran id of the connector to generate
  # @param overview_description [String] description of the connector to generate
  # @param body_description [String] short description of the connector to generate
  def initialize(name, fivetran_id, overview_description, body_description)
    @name = name
    @fivetran_id = fivetran_id
    # path where the connector will be generated. i.e. google_ads.md, facebook_ads.md
    @destination_path = "../_connectors/#{fivetran_id}.md"
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
        ERB.new(File.read("./templates.md.erb")).result_with_hash(
          name: name,
          # permalink of the connector to generate. i.e. gads, facebook_ads
          permalink: fivetran_id,
          destination_path: destination_path,
          overview_description: overview_description,
          body_description: body_description
        )
      end
    end
  end
end
