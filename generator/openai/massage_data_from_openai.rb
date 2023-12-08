require "json"

files = Dir["#{__dir__}/data/*.json"]

files.each do |file|
  output_file_name = "#{__dir__}/data2/#{File.basename(file)}"

  if File.exist?(output_file_name)
    puts "Skipping #{file}"
    next
  end

  data = JSON.parse(File.read(file))
  values = data.values

  metrics = values[4]
  reasons = values[5]

  metrics = metrics.map do |metric, description|
    {
      "title": metric,
      "description": description
    }
  end

  reasons = reasons.map do |reason, description|
    {
      "title": reason,
      "description": description
    }
  end

  output = {
    "name": values[0],
    "schema_name": values[1],
    "overview": values[2].gsub(values[1], values[0]),
    "body": values[3].gsub(values[1], values[0]),
    "metrics": {
      "title": "What are the most popular metrics in #{values[0]} to analyze?",
      "bullets": metrics
    },
    "reasons": {
      "title": "Why analyze #{values[0]}?",
      "bullets": reasons
    }
  }

  File.write(output_file_name, JSON.pretty_generate(output))
end
