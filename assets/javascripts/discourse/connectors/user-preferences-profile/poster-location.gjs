import Component from "@glimmer/component";
import { service } from "@ember/service";

export default class PosterLocationConnector extends Component {
  @service siteSettings;

  <template>
    {{#if this.siteSettings.posterlocation_enabled}}
      <div class="control-group">
        <label class="control-label">Yr Location (shows up on posts)</label>
        <div class="controls">
          <Input @value={{@model.custom_fields.posterlocation}} />
        </div>
      </div>
    {{/if}}
  </template>
}
