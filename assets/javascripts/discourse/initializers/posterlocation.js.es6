import { h } from 'virtual-dom';
import { withPluginApi } from 'discourse/lib/plugin-api';
import { ajax } from 'discourse/lib/ajax';

function initializePosterLocation(api, siteSettings) {
  const posterlocation_enabled = siteSettings.posterlocation_enabled;

  if (!posterlocation_enabled) {
    return;
  }

  api.decorateWidget('poster-name:after', dec => {
    let result = 'none';

    if (dec.attrs && dec.attrs.userCustomFields && 
      dec.attrs.userCustomFields.posterlocation) {
      result = dec.attrs.userCustomFields.posterlocation;
    }

    if (!result || result === 'none') {
      return;
    }

    return dev.h('span', [
      helper.h('i', helper.h('fa fa-map-marker d-icon d-icon-map-marker')),
      helper.h('span', { text: result }),
    ], 
    { className: 'location' });
  });
}

export default {
  name: 'posterlocation',
  initialize(container) {
    const siteSettings = container.lookup('site-settings:main');
    withPluginApi('0.1', api => initializePosterLocation(api, siteSettings));
  }
};
