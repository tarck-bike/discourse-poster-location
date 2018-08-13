# name: discourse-poster-location
# about: Show User's location in posts
# version: 1.0.10
# author: Zach Nedwich <zach@znedw.com>
# url: https://github.com/zachnedwich/discourse-poster-location

enabled_site_setting :posterlocation_enabled

PLUGIN_NAME = "discourse-posterlocation"

DiscoursePluginRegistry.serialized_current_user_fields << "posterlocation"
after_initialize do
  public_user_custom_fields_setting = SiteSetting.public_user_custom_fields
  if public_user_custom_fields_setting.empty?
    SiteSetting.set("public_user_custom_fields", "posterlocation")
  elsif public_user_custom_fields_setting !~ /posterlocation/
    SiteSetting.set(
      "public_user_custom_fields",
      [SiteSetting.public_user_custom_fields, "posterlocation"].join("|")
    )
  end

  User.register_custom_field_type('posterlocation', :text)

  if SiteSetting.posterlocation_enabled then
    add_to_serializer(:post, :user_signature, false) {
      object.user.custom_fields['posterlocation']
    }

    add_to_serializer(:user, :custom_fields, false) {
      if object.custom_fields == nil then
        {}
      else
        object.custom_fields
      end
    }
  end
end

# not needed but if we want to style Location, do it here
register_asset "javascripts/discourse/templates/connectors/user-custom-preferences/user-posterlocation-preferences.hbs"
register_asset "stylesheets/posterlocation.scss"
