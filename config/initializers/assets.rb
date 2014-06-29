# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.paths << Rails.root.join("lib", "angular")
Rails.application.config.assets.paths << Rails.root.join("vendor", "components")
Rails.application.config.assets.paths << Rails.root.join("vendor", "fonts")
Rails.application.config.assets.precompile += %w( angular/angular-strap.tpl.min.js )
