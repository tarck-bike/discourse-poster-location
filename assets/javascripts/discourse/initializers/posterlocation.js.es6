import Component from "@glimmer/component";
import { withPluginApi } from "discourse/lib/plugin-api";

function initializePosterLocation(api) { 
  api.renderAfterWrapperOutlet(
    "post-meta-data-poster-name", 
    class extends Component {
      location = '';
      static shouldRender(args) {
        let result = 'none';

        if (args.post?.user && args.post?.user.userCustomFields && 
          args.post?.user.userCustomFields.posterlocation) {
          result = args.post?.user.userCustomFields.posterlocation;
        }

        if (!result || result === 'none') {
          return false;
        }
        location = result;
        return true;
      }
      
      <template>
        <i class="fa fa-map-marker d-icon d-icon-map-marker" aria-hidden="true"></i><span>{{location}}</span>
      </template>
    }
  );
}

export default {
  name: 'posterlocation',
  initialize(container) {
    const siteSettings = container.lookup("service:site-settings");
    if(siteSettings.posterlocation_enabled) {
      withPluginApi(api => initializePosterLocation(api, siteSettings));
    }
  }
};
