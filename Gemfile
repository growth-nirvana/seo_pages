source "https://rubygems.org"

ruby "~> 3"

gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]
gem "jekyll", "~> 4.3.2"
gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]

group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-seo-tag"
  gem "jekyll-sitemap"
  gem "jekyll-include-cache"
end

platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

group :development do
  gem "webrick"
end
