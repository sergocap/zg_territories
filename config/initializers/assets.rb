# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w(
                                                  font-awesome.css
                                                  elegant-fonts.css
                                                  css/bootstrap.css
                                                  jquery.nouislider.min.css
                                                  owl.carousel.css
                                                  style.css
                                                  maps.css
                                                  jquery.nouislider.all.min.js
                                                  jquery-2.2.1.min.js
                                                  jquery-migrate-1.2.1.min.js
                                                  js/bootstrap.min.js
                                                  bootstrap-select.min.js
                                                  jquery.validate.min.js
                                                  owl.carousel.min.js
                                                  custom.js
                                                  areas_map.js
                                                )

