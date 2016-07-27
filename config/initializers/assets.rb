# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = Brotherly.version.format '%M.%m.%p%s'

# Add additional assets to the asset load path
Rails.application.config.assets.paths << 'administrate'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w(
  administrate/application.css
  administrate/application.js
  admin/banner.css
  modernizr.js
  video-js.swf
  vjs.eot
  vjs.svg
  vjs.ttf
  vjs.woff
)
