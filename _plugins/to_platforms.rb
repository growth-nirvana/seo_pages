module Jekyll
  class ToPlatforms < Jekyll::Generator
    def generate(site)
      platforms = site.data['platforms']
      connectors = site.collections['connectors'].docs

      connectors.sort_by { |c| c['name'] }.each do |connector|
        if connector.data['schema_name'].nil?
          puts "Connector #{connector.data['name']} is missing schema_name"
          next
        end

        platforms.keys.each do |platform_id|
          site.pages << ToPlatformPage.new(site, connector, platform_id)
        end
      end
    end
  end

  class ToPlatformPage < Jekyll::Page
    def initialize(site, connector, platform_id)
      @site = site
      @base = site.source
      @dir = File.join('sync', connector.data['schema_name'], 'to', platform_id)
      @name = 'index.html'

      self.read_yaml(File.join(@base, '_layouts'), 'to_platform.html')
      data = JSON.parse(JSON.generate(connector.data))
      self.data.merge!(data.slice('schema_name', 'description', 'image', 'date', 'icon_url', 'usage', 'sections'))
      self.data['name'] = "Sync #{connector.data['name']} to #{site.data['platforms'][platform_id]['name']}"
      self.data['title'] = "Sync #{connector.data['name']} to #{site.data['platforms'][platform_id]['name']}"
      self.data['platform_id'] = platform_id
      self.data['permalink'] = "sync/#{connector.data['schema_name']}/to/#{platform_id}/"
      self.data['sections']['overview']['title'] = "Sync #{connector.data['name']} to #{site.data['platforms'][platform_id]['name']}"

      self.process(@name)
    end
  end
end
