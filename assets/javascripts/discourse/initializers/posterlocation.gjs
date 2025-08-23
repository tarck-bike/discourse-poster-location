import Component from "@glimmer/component";
import { withPluginApi } from "discourse/lib/plugin-api";

class PosterLocation extends Component {
  location = "";
  static shouldRender(args) {
     this.location = args.user?.custom_fields?.posterlocation ?? "none";
     return this.location && this.location !== "none";
  }

  <template>
    <i
      class="fa fa-map-marker d-icon d-icon-map-marker"
      aria-hidden="true"
    ></i><span>{{this.location}}</span>
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
