# Frontend

[![Code Climate](https://codeclimate.com/github/moneyadviceservice/frontend.png)](https://codeclimate.com/github/moneyadviceservice/frontend)

The Money Advice Service's responsive website.


## Prerequisites

* [Git]
* [Ruby 2.0.0][Ruby]
* [Rubygems 2.1.0][Rubygems]
* [Bundler]


## Installation

Clone the repository:

```sh
$ git clone --recursive https://github.com/moneyadviceservice/frontend.git
```

Make sure all dependencies are available to the application:

```sh
$ bundle install
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
   [Controllers][controller specs], [Helpers][helper specs] and
   [JavaScript][konacha] of your feature.

### API

The application is backed by a RESTful JSON API. This is described for humans
as a [blueprint file][apiary.apib] using the
[API Blueprint Language Specification]. Changes you make to the
[blueprint file][apiary.apib] will be automatically reflected in the online
[api documentation] and [mock api].

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


[apiary.apib]: ./apiary.apib
[bower.json]: ./bower.json
[features]: ./features
[features/home_page.feature]: ./features/home_page.feature
[features/support/ui]: ./features/support/ui
[features/support/world/pages.rb]: ./features/support/world/pages.rb

[controller specs]: https://www.relishapp.com/rspec/rspec-rails/docs/controller-specs
[helper specs]: https://www.relishapp.com/rspec/rspec-rails/docs/helper-specs
[model specs]: https://www.relishapp.com/rspec/rspec-rails/docs/model-specs
[routing specs]: https://www.relishapp.com/rspec/rspec-rails/docs/routing-specs

[api blueprint]: https://github.com/apiaryio/api-blueprint/blob/master/API%20Blueprint%20Specification.md
[api blueprint language specification]: http://docs.moneyadviceservice.apiary.io/
[bower]: http://bower.io
[bundler]: http://bundler.io
[git]: http://git-scm.com
[konacha]: https://github.com/jfirebaugh/konacha
[kss]: https://github.com/kneath/kss
[mas-development_dependencies]: https://github.com/moneyadviceservice/mas-development_dependencies
[mock api]: https://moneyadviceservice.apiary.io
[money advice service team]: https://github.com/moneyadviceservice
[ruby]: http://www.ruby-lang.org/en
[rubygems]: http://rubygems.org
[site prism]: https://github.com/natritmeyer/site_prism
