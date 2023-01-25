# Frontend

The Money Advice Service's legacy tools application.


## Prerequisites

* [Git]
* [Ruby][Ruby] - see version specified in [.ruby-version](.ruby-version)
* [Node.js][Node] - install a recent LTS release.
* [Bundler] - `gem install bundler`

## Installation

Clone the repository:

```sh
$ git clone --recursive https://github.com/moneyadviceservice/frontend.git
```

Install MariaDB/MySQL

```sh
$ brew install mariadb
```

Make sure MySQL is running.

```sh
$ brew services restart mariadb
```

Install Bower

```
npm install -g bower
```

Add Rails LTS credentials (get the username and password from Ben L)

```sh
bundle config gems.railslts.com USERNAME:PASSWORD
```

Make sure all dependencies are available to the application:

```sh
$ bundle install
$ bowndler install
```

Make sure to copy the .env-example file:

```sh
cp .env-example .env
```

Setup the database:

```sh
bundle exec rake db:create db:schema:load
```

## Usage

To start the application:

```sh
$ foreman s
```

The site makes a lot of requests to the CMS application. If
**you are not developing anything that integrates with CMS**, you can
enable the application cache in development mode by running:

```
DEV_CACHE=true rails s -p 5000
```

Or alternatively you can add `DEV_CACHE=true` to your .env file.

### Change CMS URL Path

In development, frontend will use the local CMS for convenience. See [CMS repository README](https://github.com/moneyadviceservice/cms/blob/master/README.md) for instructions on setting up a local CMS instance.

You can change the MAS_CMS_URL on .env file. Use https://staging-mas-cms.moneyhelper.org.uk for testing, or http://localhost:PORT to point to a local running CMS.

Don't forget to restart the server after the modification.

### Development setup gotchas

#### Problems loading Dough or Yeast

Assuming you have run `bowndler install`, you may have issues with previous `bower` installations.

```sh
rm -rf vendor/assets/bower_components
rm bower.json
bowndler install
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Keep your feature branch focused and short lived
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

### Feature Development

We like to develop features from the outside in. We write our user stories in a
[declarative style][features/home_page.feature]. When contributing a feature:

1. Create a new feature file in [features].
2. Write scenarios to exercise the scope of the feature in it's entirety.
3. Create [page objects][site prism] in [features/support/ui] and expose them
   to the world in [features/support/world/pages.rb].
4. Start with a failing scenario then make it pass.
5. Write unit tests for the objects you identify for your feature.
6. Start with a failing unit test then make it pass.
7. Keep your unit tests isolated.
8. Test the [Routing][routing specs], [Models][model specs],
   [Controllers][controller specs], [Decorators][decorator specs],
   [Helpers][helper specs] and [JavaScript][karma] of your feature.
9. Test your features against the [mock API] and record interactions with [VCR].

### API

The application is backed by a RESTful JSON API. This is described for humans
as a [blueprint file][apiary.apib] using the
[API Blueprint Language Specification]. Changes you make to the
[blueprint file][apiary.apib] will be automatically reflected in the online
[API documentation] and [mock API].

### Writing front-end code

There are a number of documents to help everyone write maintainble, performant and readible HTML, CSS and Javascript.

We recommend having a flick through these when working on new features:

* [Front-end Code Standards](https://github.com/moneyadviceservice/frontend-code-standards) – an in-depth guide to the standards we follow
* [Javascript styleguide](https://github.com/moneyadviceservice/javascript) – further detail on writing Javascript to the standards we follow
* [Common front-end gotchas](https://github.com/moneyadviceservice/frontend-code-standards/blob/master/gotchas.md) – quick reference for some common gotchas that may be picked up in PR reviews
* [Working with Dough](https://github.com/moneyadviceservice/made_with_dough/blob/master/README.md) – some information on how Dough works
* [Adding Dough to a fresh Rails app](https://github.com/moneyadviceservice/frontend/wiki/Adding-Dough-to-a-fresh-Rails-app)

### Front-end Package Management

The application uses [Bower] to manage front-end packages. Dependencies should
be defined in the [bower.json] configuration file. Once installed they will be
automatically available to the asset pipeline.

### Consuming the front-end without having to manually import dependencies

There are minor differences to the header and footer in the empty template, to enable
the HTML to run in a static fashion. For example, we [remove the authentication links](https://github.com/moneyadviceservice/frontend/blob/master/app/views/shared/_authentication.html.erb#L7)
in the header as they require knowledge about the user's sessions – which
can't easily be shared across multiple sites, domains, etc.

This is done via a [`hide_elements_irrelevant_for_third_parties?`](https://github.com/moneyadviceservice/frontend/blob/master/app/controllers/empty_controller.rb#L7-L9) flag in the views.

Projects such as RAD keep this [stored in their repo](https://github.com/moneyadviceservice/rad/blob/master/app/views/layouts/_mas_head.html.erb), and have a simple CSS file
that overrides or adds the bits they want.

### Patterns

#### Decorators

We use [Draper] for [decorators]. Decorators help us to keep logic out of our
[views], avoid procedural [helpers] and ensure our [models] are free of any
presentational concerns.


[apiary.apib]: ./apiary.apib
[bower.json]: ./bower.json
[features]: ./features
[features/home_page.feature]: ./features/home_page.feature
[features/support/ui]: ./features/support/ui
[features/support/world/pages.rb]: ./features/support/world/pages.rb

[decorators]: ./app/decorators
[helpers]: ./app/helpers
[models]: ./app/models
[views]: ./app/views

[controller specs]: https://www.relishapp.com/rspec/rspec-rails/docs/controller-specs
[decorator specs]: https://github.com/drapergem/draper#testing
[helper specs]: https://www.relishapp.com/rspec/rspec-rails/docs/helper-specs
[model specs]: https://www.relishapp.com/rspec/rspec-rails/docs/model-specs
[routing specs]: https://www.relishapp.com/rspec/rspec-rails/docs/routing-specs

[api blueprint language specification]: https://github.com/apiaryio/api-blueprint/blob/master/API%20Blueprint%20Specification.md
[api documentation]: http://docs.moneyadviceservice.apiary.io/
[bower]: http://bower.io
[bundler]: http://bundler.io
[draper]: https://github.com/drapergem/draper
[feature branches]: http://martinfowler.com/bliki/FeatureBranch.html
[feature toggles]: http://martinfowler.com/bliki/FeatureToggle.html
[git]: http://git-scm.com
[karma]: https://karma-runner.github.io
[kss]: https://github.com/kneath/kss
[mock api]: https://moneyadviceservice.apiary.io
[money advice service team]: https://github.com/moneyadviceservice
[node]: http://nodejs.org/
[ruby]: http://www.ruby-lang.org/en
[rubygems]: http://rubygems.org
[site prism]: https://github.com/natritmeyer/site_prism
[vcr]: https://github.com/vcr/vcr

## Running Karma javascript tests

Run the following in the command line.

```
RAILS_ENV=development bundle exec rake karma:install karma:run_once
```

## Deploy to staging and production

You'll need a heroku account with permissions to the `staging-partner-tools` and `partner-tools` apps.

1. Configure your local git repository with the staging heroku remote: `https://git.heroku.com/staging-partner-tools.git`
2. `git push staging your-branch:main`
3. Once you're happy and this has been tested and approved `heroku pipelines:promote --app partner-tools` will promote the build to production
