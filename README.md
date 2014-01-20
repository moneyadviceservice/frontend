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
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

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


[bower.json]: ./bower.json

[bower]: http://bower.io
[bundler]: http://bundler.io
[git]: http://git-scm.com
[kss]: https://github.com/kneath/kss
[mas-development_dependencies]: https://github.com/moneyadviceservice/mas-development_dependencies
[money advice service team]: https://github.com/moneyadviceservice
[ruby]: http://www.ruby-lang.org/en
[rubygems]: http://rubygems.org
