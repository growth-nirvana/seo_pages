# SEO Pages

[![Netlify Status](https://api.netlify.com/api/v1/badges/87e236c7-b801-4a6c-9125-c4f5abc39585/deploy-status)](https://app.netlify.com/sites/frolicking-longma-3a99db/deploys)

## Deployment
First build jekyll `bundle exec jekyll build` then build the stylesheet `yarn run build`.

## Development
Run `./bin/dev` to start jekyll.

## How to download connector icons

1. Download the CSV for all the sources: https://admin.growthnirvana.com/admin/blazer/queries/185-source-all and https://admin.growthnirvana.com/admin/blazer/queries/333-customconnector-all-custom-connector-sources
2. Remove the current images within `assets/images/seo_pages/connectors/`
3. Open an IRB session and run:

```ruby
require "pathname"
require "csv"

def extract_images(csv)
  csv.map do |row|
    print "."
    ext = Pathname(row["icon_url"]).extname
    `curl '#{row["icon_url"]}' -o assets/images/seo_pages/connectors/#{row["schema_name"]}#{ext} -s`
  end
end

csv = CSV.read("generator/openai/20231207-sources.csv", headers: true)
extract_images(csv)

csv = CSV.read("generator/openai/20231207-custom-connector-sources.csv", headers: true)
extract_images(csv)
```
