# frozen_string_literal: true

# name: discourse-poster-location
# about: Show User's location in posts
# version: 1.0.23
# authors: Zach Nedwich <zach@znedw.com>
# url: https://github.com/tarck-bike/discourse-poster-location

enabled_site_setting :posterlocation_enabled

module ::PosterLocationModule
  PLUGIN_NAME = 'discourse-posterlocation'
end

DiscoursePluginRegistry.serialized_current_user_fields << 'posterlocation'
after_initialize do
  public_user_custom_fields_setting = SiteSetting.public_user_custom_fields
  if public_user_custom_fields_setting.empty?
    SiteSetting.set('public_user_custom_fields', 'posterlocation')
  elsif public_user_custom_fields_setting !~ /posterlocation/
    SiteSetting.set(
      'public_user_custom_fields',
      [SiteSetting.public_user_custom_fields, 'posterlocation'].join('|')
    )
  end

  User.register_custom_field_type('posterlocation', :text)

  if defined?(register_editable_user_custom_field)
    register_editable_user_custom_field :posterlocation
  end

  if SiteSetting.posterlocation_enabled
    add_to_serializer(:post, :user_signatures) { object.user.custom_fields['posterlocation'] }

    add_to_serializer(:user, :custom_fields) do
      if object.custom_fields.nil?
        {}
      else
        object.custom_fields
      end
    end
  end
end
