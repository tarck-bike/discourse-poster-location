import { hbs } from "ember-cli-htmlbars";

export default {
  template: hbs`
    {{#if this.siteSettings.posterlocation_enabled}}
      <div class="control-group">
        <label class="control-label">Yr Location (shows up on posts)</label>
        <div class="controls">
          <Input @value={{this.model.custom_fields.posterlocation}} />
        </div>
      </div>
    {{/if}}
  `,
};
