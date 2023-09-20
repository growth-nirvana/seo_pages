require "json"
require "erb"
require "date"
require "yaml"
require "csv"

class Generator
  attr_reader :name, :schema_name, :destination_path,
    :overview_description, :body_description, :bullets_for_metrics, :bullets_for_reasons

  # @param name [String] name of the connector to generate. i.e. Google Ads, Facebook Ads
  # @param schema_name [String] schema_name of the connector to generate
  # @param overview_description [String] description of the connector to generate
  # @param body_description [String] short description of the connector to generate
  # @param bullets_for_metrics [Hash<String>] metrics bullets of the connector to generate
  # @param bullets_for_reasons [Hash<String>] incentives bullets of the connector to generate
  def initialize(name, schema_name, overview_description, body_description, bullets_for_metrics, bullets_for_reasons)
    @name = name
    @schema_name = schema_name
    @destination_path = "./_connectors/#{schema_name}.md"
    @overview_description = overview_description
    @body_description = body_description
    @bullets_for_metrics = bullets_for_metrics
    @bullets_for_reasons = bullets_for_reasons
  end

  # Generates a landing page for the connector
  #
  # @param override [Boolean] if true, the file will be overriden if it already exists
  def generate(override = false)
    if File.exist?(destination_path) && !override
      puts "File #{destination_path} already exists"
    else
      File.open(destination_path, 'w') do |f|
        f.write(template.to_yaml + "---\n")
      end
    end
  end

  private

  def template
    {
      "layout"=> "connector",
      "title"=> "#{ name } Connector - Growth Nirvana",
      "name"=> "#{ name }",
      "description"=> "#{ body_description }",
      "image"=> "/assets/images/seo_pages/body.webp",
      "date"=> "#{ Date.today }",
      "categories"=> "connectors",
      "permalink"=> "connectors/#{ schema_name }",
      "icon_url"=> "/assets/images/seo_pages/connectors/#{ schema_name }",
      "usage"=> usage.fetch(schema_name, 0).to_i,
      "schema_name"=> schema_name,
      "sections"=> {
        "overview"=> {
          "title"=> "#{ name } Data Connector",
          "description"=> "#{ overview_description }",
          "image_url"=> "/assets/images/seo_pages/overview.webp"
        },
        "body"=> {
          "title"=> "Visualize Your #{ name } channel data with Growth Nirvana's #{ name } Connector",
          "description"=> "#{ body_description }",
          "image_url"=> "/assets/images/seo_pages/body.webp"
        },
        "faq"=> {
          "title"=> "FAQs",
          "questions"=> [
            bullets_for_metrics,
            bullets_for_reasons,
            {
              "title"=> "What is Growth Nirvana?",
              "answer"=> "Growth Nirvana is a no code analytics platform. Stop waiting for other departments to get you the data you need to make critical business decisions. Take control of the insights that will grow your business."
            },
            {
              "title"=> "Can I export the data into a spreadsheet or my data warehouse?",
              "answer"=> "Yes, all data can be exported into a spreadsheet or your data warehouse (Google BigQuery, AWS, Snowflake, Azure, etc)"
            },
            {
              "title"=> "How customizable are Growth Nirvana reports?",
              "answer"=> "Growth Nirvana reporting is 100% white labeled and customized to your specifications. Growth Nirvana can create the reports so you don’t have to or you can connect your visualization tools (Looker Data Studio/Google Data Studio, Tableau, PowerBI, etc) to Growth Nirvana."
            },
            {
              "title"=> "How much does Growth Nirvana cost?",
              "answer"=> "Plans start at $200/month. Schedule a demo to learn what plan is best for you."
            },
            {
              "title"=> "How long does it take to setup?",
              "answer"=> "Growth Nirvana data connectors are no code so setup only requires a few clicks."
            }
          ].compact
        }
      }
    }
  end

  def usage
    @usage ||= CSV.read("./generator/usage.csv").to_h
  end
end
