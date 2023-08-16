# SEO Pages

[![Netlify Status](https://api.netlify.com/api/v1/badges/87e236c7-b801-4a6c-9125-c4f5abc39585/deploy-status)](https://app.netlify.com/sites/frolicking-longma-3a99db/deploys)

## Deployment
First build jekyll `bundle exec jekyll build` then build the stylesheet `yarn run build`.

## Development
Run `./bin/dev` to start jekyll.

## How to download connector icons

1. Download the CSV for all the sources: https://docs.google.com/spreadsheets/d/1MC28CSdgBk8nKcvwQ_put-3QI7P0mZxB9kKtyP5guWA/edit#gid=526148982
2. Remove the current images within `assets/images/seo_pages/connectors/`
3. Open an IRB session and run:

```ruby
require "csv"

csv = CSV.read("downloaded-sources.csv", headers: true)

csv.map do |row|
  ext = Pathname(row["icon_url"]).extname
  `curl '#{row["icon_url"]}' -o assets/images/seo_pages/connectors/#{row["schema_name"]}#{ext} -s`
end
```
