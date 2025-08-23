import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { withPluginApi } from "discourse/lib/plugin-api";

class PosterLocation extends Component {
  @tracked location = "";
  static shouldRender(args) {
    let result = "none";
    console.log(args, args.user, args.user?.custom_fields);
    if (
      args.user &&
      args.user.custom_fields &&
      args.user.custom_fields.posterlocation
    ) {
      result = args.user.custom_fields.posterlocation;
    }

    if (!result || result === "none") {
      return false;
    }
    
    this.location = result;
    return true;
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
