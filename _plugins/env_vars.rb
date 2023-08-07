module Jekyll
  class EnvVars < Generator
    def generate(site)
      site.config["env"] = ENV.to_hash
    end
  end
end
