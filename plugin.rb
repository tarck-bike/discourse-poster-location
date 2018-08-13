# name: discourse-poster-location
# about: Show User's location in posts
# version: 1.0.0
# author: Zach Nedwich <zach@znedw.com>
# url: https://github.com/zachnedwich/discourse-poster-location

enabled_site_setting :posterlocation_enabled

PLUGIN_NAME = "discourse-posterlocation"

after_initialize do
  
end

# not needed but if we want to style Location, do it here
register_asset "stylesheets/posterlocation.scss"
