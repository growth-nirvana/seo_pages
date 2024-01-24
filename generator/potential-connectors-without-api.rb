current_connectors = Dir["#{__dir__}/../_connectors/*"].map { |connector| File.basename(connector, ".md") }

# Download the HTML file from https://fivetran.com/docs/rest-api/connectors/config
connectors_html = File.read("#{__dir__}/../tmp/connectors-api.html")

connectors_with_api = connectors_html.scan(
  /<span class="hljs-attr">"service"<\/span><span class="hljs-punctuation">:<\/span> <span class="hljs-string">"(\w+)"<\/span>/).flatten

puts current_connectors - connectors_with_api
