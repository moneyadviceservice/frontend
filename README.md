# Frontend

[![Code Climate](https://codeclimate.com/github/moneyadviceservice/frontend.png)](https://codeclimate.com/github/moneyadviceservice/frontend)

The Money Advice Service's responsive website.


## Prerequisites

* [Git]
* [Ruby 2.0.0][Ruby]
* [Rubygems 2.1.0][Rubygems]
* [Node.js][Node]
* [Bundler]
* [Bower]


## Installation

Clone the repository:

```sh
$ git clone --recursive https://github.com/moneyadviceservice/frontend.git
```

Make sure all dependencies are available to the application:

```sh
$ bundle install
$ bower install
```

## Usage

To start the application:

```sh
$ foreman s
```

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

If necessary, use a precondition in any tests to check for the status of the feature.
For example, in feature tests you can use:

```gherkin
Background:
  Given The feature is active

Scenario: View great new feature
  When I visit the website
  Then I should see this great new feature
```

with the corresponding step being:

```rb
Given /^The feature is active$/ do
  pending unless Feature.active?(:new_feature)
end
```

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

### Development Dependencies

The application depends on [mas-development_dependencies], a dependency layer
common to all applications and engines developed by the
[Money Advice Service team]. This Gem unifies development and test dependencies
and provides opinionated default configuration. When introducing a dependency,
first consider whether it should be promoted to this common layer.

### Front-end Package Management

The application uses [Bower] to manage front-end packages. Dependencies should
be defined in the [bower.json] configuration file. Once installed they will be
automatically available to the asset pipeline.

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
[mas-development_dependencies]: https://github.com/moneyadviceservice/mas-development_dependencies
[mock api]: https://moneyadviceservice.apiary.io
[money advice service team]: https://github.com/moneyadviceservice
[node]: http://nodejs.org/
[ruby]: http://www.ruby-lang.org/en
[rubygems]: http://rubygems.org
[site prism]: https://github.com/natritmeyer/site_prism
[vcr]: https://github.com/vcr/vcr
