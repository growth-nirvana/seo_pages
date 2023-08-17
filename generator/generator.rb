require "json"
require "erb"
require "date"
require "yaml"

class Generator
  attr_reader :name, :fivetran_id, :permalink, :destination_path,
    :overview_description, :body_description, :bullets_for_metrics, :bullets_for_reasons

  # @param name [String] name of the connector to generate. i.e. Google Ads, Facebook Ads
  # @param fivetran_id [String] fivetran id of the connector to generate
  # @param overview_description [String] description of the connector to generate
  # @param body_description [String] short description of the connector to generate
  # @param bullets_for_metrics [Hash<String>] metrics bullets of the connector to generate
  # @param bullets_for_reasons [Hash<String>] incentives bullets of the connector to generate
  def initialize(name, fivetran_id, overview_description, body_description, bullets_for_metrics, bullets_for_reasons)
    @name = name
    @fivetran_id = fivetran_id
    @destination_path = "./_connectors/#{fivetran_id}.md"
    @overview_description = overview_description
    @body_description = body_description
    @bullets_for_metrics = if bullets_for_metrics.nil?
                             ""
                           else
                             bullets_for_metrics.to_yaml(line_width: -1) # Prevents YAML from adding line breaks on long lines
                              .gsub("bullets:", "  bullets:").gsub(/^/,"      ") # Adds correct indentation for bullets array
                              .gsub("description:", "    description:") # Adds correct indentation for description
                              .gsub("---\n", "") # Removes initial ---\n
                              .gsub("- title:", "    - title:") # Adds correct indentation for each bullet title
                              .gsub("      title:", "- title:") # Adds correct indentation for first title
                           end
    @bullets_for_reasons = if bullets_for_reasons.nil?
                              ""
                          else
                            bullets_for_reasons.to_yaml(line_width: -1) # Prevents YAML from adding line breaks on long lines
                            .gsub("bullets:", "  bullets:").gsub(/^/,"      ") # Adds correct indentation for bullets array
                            .gsub("description:", "    description:") # Adds correct indentation for description
                            .gsub("---\n", "") # Removes initial ---\n
                            .gsub("- title:", "    - title:") # Adds correct indentation for each bullet title
                            .gsub("      title:", "- title:") # Adds correct indentation for first title
                          end
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
          ERB.new(File.read("./generator/template.md.erb"), trim_mode: '-').result_with_hash(
            name: name,
            date: Date.today,
            permalink: fivetran_id,
            overview_description: overview_description,
            body_description: body_description,
            bullets_for_metrics: bullets_for_metrics,
            bullets_for_reasons: bullets_for_reasons
          )
        )
      end
    end
  end
end
