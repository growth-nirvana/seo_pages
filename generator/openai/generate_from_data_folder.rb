require_relative "generator"

connectors = Dir["#{__dir__}/data2/*.json"]

connectors.each do |connector|
  data = JSON.parse(File.read(connector))
  puts "Generating #{data["schema_name"]}"

  Generator.new(*data.values).generate(true)
end
