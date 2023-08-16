Jekyll::Hooks.register :site, :post_write do |site|
  system "yarn run build"
end
