import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { withPluginApi } from "discourse/lib/plugin-api";

class PosterLocation extends Component {
  @tracked location = "";

  constructor() {
    super(...arguments);
    this.location = this.args.user?.custom_fields?.posterlocation;
  }

  <template>
    {{#if this.location}}
      <div style="order: 1;">
        <svg
          class="fa d-icon d-icon-map-marker svg-icon prefix-icon svg-string"
          aria-hidden="true"
          xmlns="http://www.w3.org/2000/svg"
        ><use href="#location-dot"></use></svg>
        <span
          class="user-title"
          style="font-size: 0.8rem; font-style: italic"
        >{{this.location}}</span>
      </div>
    {{/if}}
  </template>
}

function initializePosterLocation(api) {
  api.renderAfterWrapperOutlet("post-meta-data-poster-name", PosterLocation);
}

export default {
  name: "posterlocation",
  initialize(container) {
    const siteSettings = container.lookup("service:site-settings");
    if (siteSettings.posterlocation_enabled) {
      withPluginApi((api) => initializePosterLocation(api, siteSettings));
    }
  },
};
