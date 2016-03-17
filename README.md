# Frontend

[![Code Climate](https://codeclimate.com/github/moneyadviceservice/frontend.png)](https://codeclimate.com/github/moneyadviceservice/frontend)

The Money Advice Service's responsive website.


## Prerequisites

* [Git]
* [Ruby 2.1.2][Ruby]
* [Rubygems 2.2.2][Rubygems]
* [Node.js][Node]
* [Bundler]
* [Bower]
* [MySQL](http://www.mysql.com/)


## Installation

Clone the repository:

```sh
$ git clone --recursive https://github.com/moneyadviceservice/frontend.git
```

Make sure you've added the following line to your `/etc/hosts` file

`10.50.6.148	gems.test.mas`

Make sure all dependencies are available to the application:

```sh
$ bundle install
$ bowndler install
```

Make sure MySQL is running.

Setup the database:

```sh
bundle exec rake db:create && bundle exec rake db:schema:load
```

Copy the features.yml.sample to the config dir:

```sh
cp config/features.yml.sample config/features.yml
```

## Usage

To start the application:

```sh
$ foreman s
```

### Change CMS URL Path

In development, frontend will use the QA CMS for convenience. You can change the MAS_CMS_URL on [.env](https://github.com/moneyadviceservice/frontend/blob/master/.env#L2) file. Use http://comfy.moneyadviceservice.org.uk to point to LIVE content. Or http://localhost:PORT to point to a local running CMS.

Don't forget to restart the server after the modification.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Keep your feature branch focused and short lived
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

### Feature Toggles

We favor [Feature Toggles] over [Feature Branches]. To define features create a
configuration file, *config/features.yml* with toggles for various features that
are pending:

```yml
features:
  an_active_feature: true
  an_inactive_feature: false
```

At runtime you can use these toggles in order to decide whether or not to show a feature:

```rb
Feature.active?(:an_active_feature) # => true/false

Feature.inactive?(:an_active_feature) # => true/false

Feature.with(:an_active_feature) do
  # code
end

Feature.without(:an_active_feature) do
  # code
end
```

Our feature toggles are designed to be used to hide partly built features, often
referred to as **release toggles**. A toggle and any conditional behaviour must
be removed once a feature is complete.

Note that the local configuration file *config/features.yml* is ignored in git so
make sure to run any acceptance tests with the feature toggled on and off locally.

If you need to enable a feature in any tests you can use tags.
For example, in feature tests you can use:

```gherkin
@enable-feature-name
Scenario: View great new feature
  When I visit the website
  Then I should see this great new feature
```

Where the cucumber tag `@enable-feature-name` will enable the feature `feature_name` for the cucumber scenario.

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

### Styleguide

The application includes an internal styleguide for contributors. It contains a
living CSS styleguide, JavaScript styleguide and some recommendations on how to
write Ruby code. As a contributor you should update the styleguide as you update
the application. The CSS styleguide is powered by [KSS], a documenting syntax
for CSS.

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

We have a couple of projects that live outside of this website, but benefit from
having the generated HTML and CSS. I.e. they don't need to manually import
[Dough](https://github.com/moneyadviceservice/dough), [Yeast](https://github.com/moneyadviceservice/yeast), and [MAS Dough Theme](https://github.com/moneyadviceservice/mas_dough_theme), etc.

Useful if you're an agency and want to get up and running quickly, we render both
[English](https://www.moneyadviceservice.org.uk/en/empty) and [Welsh](https://www.moneyadviceservice.org.uk/cy/empty) versions of our 'empty' template. This can then be pulled in via
`curl` or good old view-source and copying & pasting.

There are minor differences to the header and footer in the empty template, to enable
the HTML to run in a static fashion. For example, we [remove the authentication links](https://github.com/moneyadviceservice/frontend/blob/master/app/views/shared/_authentication.html.erb#L7)
in the header as they require knowledge about the user's sessions – which
can't easily be shared across multiple sites, domains, etc.

This is done via a [`hide_elements_irrelevant_for_third_parties?`](https://github.com/moneyadviceservice/frontend/blob/master/app/controllers/empty_controller.rb#L7-L9) flag in the views.

Projects such as RAD keep this [stored in their repo](https://github.com/moneyadviceservice/rad/blob/master/app/views/layouts/_mas_head.html.erb), and have a simple CSS file
that overrides or adds the bits they want.

### Patterns

#### Clean Architecture

We have adopted [Uncle Bob's][uncle bob] idea of [Clean Architecture]. By isolating business logic
from application logic through a core library we have attempted to provide a solution that has
clean, decoupled code, that is easy to maintain and extend.

##### Entities

##### Interactors

- High-level coordinators called by controllers
- Return entities or callbacks

(Also known as services or use cases).

##### Registries

##### Repositories

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
[entities]: ./lib/core/entities
[helpers]: ./app/helpers
[interactors]: ./lib/core/interactors
[models]: ./app/models
[registries]: ./lib/core/registries
[repositories]: ./lib/core/repositories
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
[clean architecture]: http://blog.8thlight.com/uncle-bob/2012/08/13/the-clean-architecture.html
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
[uncle bob]: https://twitter.com/unclebobmartin
[vcr]: https://github.com/vcr/vcr

## Running Karma javascript tests

Run the following in the command line.

```
RAILS_ENV=development bundle exec rake karma:install karma:run_once
```

## Deploy to staging and production

Today the current process occurs in GO. You need to change the build number
here:
https://github.com/moneyadviceservice/scripts/blob/master/puppet/extdata/common.yaml#L249

Make sure before you changed and open a PR to run the follow script and **paste on the PR description**:

```
./bin/mas-version-diff 1869 1870
```

Obs.: 1869 and 1870 is just an example of versions to be shown. Use the GO build
number in ascending order.
