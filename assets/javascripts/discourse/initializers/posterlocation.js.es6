import {h} from 'virtual-dom';
import {withPluginApi} from 'discourse/lib/plugin-api';
import {ajax} from 'discourse/lib/ajax';

// import Ember from 'ember';

function initializePosterLocation(api, siteSettings) {
  const posterlocation_enabled = siteSettings.posterlocation_enabled;

  if (!posterlocation_enabled) {
    return;
  }

  api.decorateWidget('poster-name:after', dec => {
    let result = 'none';

    if (dec.attrs && dec.attrs.userCustomFields.location) {
      result = dec.attrs.userCustomFields.location;
      // Ember.Logger.debug(result)
    }

    if (!result || result === 'none') {
      // Ember.Logger.debug('NOT FOUND!')
      return;
    }

    return dec.h('span', {
      className: "posterlocation",
      text: result
    });
  });
}

export default {
  name : 'posterlocation',
  initialize(container) {
    const siteSettings = container.lookup('site-settings:main');
    withPluginApi('0.1', api => initializePosterLocation(api, siteSettings));
  }
};
