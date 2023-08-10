class Generator
  attr_reader :name, :permalink, :destination_path

  # @param name [String] name of the connector to generate. i.e. Google Ads, Facebook Ads
  # @param permalink [String] permalink of the connector to generate. i.e. gads, facebook_ads
  # @param destination_path [String] path where the connector will be generated. i.e. google_ads.md, facebook_ads.md
  def initialize(name, permalink, destination_path)
    @name = name
    @permalink = permalink
    @destination_path = destination_path
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
          permalink: permalink,
          destination_path: destination_path
        )
      end
    end
  end
end
