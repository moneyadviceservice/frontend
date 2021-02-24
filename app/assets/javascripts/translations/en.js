define([], function() {
  'use strict';

  return {
    'hide': 'hide',
		'cookieController': {
			'optionalCookies': {
				'analytics': {
				'label': 'Analytics Cookies',
				'description': 'These cookies allow us to collect anonymised data about how our website is being used, helping us to make improvements to the services we provide to you.'
				}
			},
			'text': {
				'title': 'Cookies on Money Advice Service',
				'intro':
					'<span>Cookies are files saved on your phone, tablet or computer when you visit a website.</span>' +
					'<span>We use cookies to store information about how you use the Money Advice Service website, such as the pages you visit.</span>' +
					'<span>For more information visit our <a href="/en/corporate/cookie_notice_en">Cookie Policy</a> and <a href="/en/corporate/privacy">Privacy Policy</a>.</span>',
				'acceptSettings': 'Accept all cookies',
				'closeLabel': 'Save preferences'
			}
		}
  };
});
