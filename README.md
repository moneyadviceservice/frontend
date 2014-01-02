# Frontend

The Money Advice Service's responsive website.


## Prerequisites

* [Git]
* [Ruby 2.1.0][Ruby]
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

The application depends on [mas-development_dependencies], a dependency layer
common to all applications and engines developed by the Money Advice Service.
This Gem unifies development and test dependencies and provides opinionated
default configuration. When introducing a dependency, first consider whether it
should be promoted to this common layer.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


[bundler]: http://bundler.io
[git]: http://git-scm.com
[mas-development_dependencies]: https://github.com/moneyadviceservice/mas-development_dependencies
[ruby]: http://www.ruby-lang.org/en
[rubygems]: http://rubygems.org
