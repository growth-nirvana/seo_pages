require "csv"
require "json"

connector = {
  "schema_name" => "aurora_postgres",
  "name" => "Aurora Postgres",
  "type" => "database",
  "description" => "Aurora PostgreSQL is a hosted version of the popular Postgres database on the Amazon Aurora platform"
}

output_file_name = "#{__dir__}/data/#{connector["schema_name"]}.json"

if File.exist?(output_file_name)
  puts "Skipping #{connector["schema_name"]}"
  exit 1
end

prompt = <<~STR
#{connector["schema_name"]} is a #{connector["type"]} type of app.

#{connector["description"]}.

I want to serve a landing page promoting this data connector. Help me write:
1) Overview description of the connector
2) Body description of the connector (more detailed than the overview)
3) A list of the most popular metrics, call this key "metrics" (e.g. for Google Ads: {"Click-Through Rates": "Analyze the effectiveness of ad creatives and their ability to generate clicks"})
4) Why analyze this?, call this ke "reasons" (e.g. for Google Ads: {"Targeted Advertising": "Deliver personalized ads to specific audience segments for higher engagement."})

Can you output a JSON formatted text with this info?
STR

data = {
  "model": "gpt-3.5-turbo",
  "messages": [
    {
      "role": "system",
      "content": "You are a copywriter for landing pages, skilled in digital marketing."
    },
    {
      "role": "user",
      "content": "#{prompt}"
    }
  ]
}

command = "curl https://api.openai.com/v1/chat/completions -H \"Content-Type: application/json\" -H \"Authorization: Bearer $OPENAI_API_KEY\" -d '#{data.to_json}'"

result = `#{command}`

data = JSON.parse(result)
content = JSON.parse(data["choices"].first["message"]["content"])

output = {
  "name": connector["name"],
  "schema_name": connector["schema_name"]
}.merge(content)

File.open(output_file_name, "w") { |f| f.write(output.to_json) }
