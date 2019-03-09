# Contributing

👍🎉 First off, thanks for taking the time to contribute! 🎉👍

Our [README](README.md) describes the project, its purpose, and is necessary reading for contributors.

This project adheres to a [code of conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

Contributions to this project are made under the [MIT License](LICENSE.md).

## Help wanted

Browse [open issues](https://github.com/lee-dohm/elite-investigations/issues) to see current requests.

[Open an issue](https://github.com/lee-dohm/elite-investigations/issues/new) to tell us about a bug. You may also open a pull request to propose specific changes, but it's always OK to start with an issue.

[Help with translating](#translating) the website into other languages.

## Setting up the development environment

You'll need to:

1. Install [PostgreSQL][postgres-download] and start it
1. Run `script/setup`

[postgres-download]: https://www.postgresql.org/download/

## Common Tasks

This project follows the [GitHub "scripts to rule them all" pattern](http://githubengineering.com/scripts-to-rule-them-all/). The contents of the `scripts` directory are scripts that cover all common tasks:

* `script/setup` &mdash; Performs first-time setup
* `script/update` &mdash; Performs periodic updating
* `script/test` &mdash; Runs automated tests, format and linter checks
* `script/server` &mdash; Launches the local development web server
* `script/console` &mdash; Opens the development console
* `script/db-console` &mdash; Opens the database console for the development database
* `script/docs` &mdash; Generates developer documentation
* `script/translate` &mdash; Extract and merge new message strings in `priv/gettext`

See the documentation at the top of each script for more information about what each one does and is capable of.

Other scripts that are available but not intended to be used directly by developers:

* `script/bootstrap` &mdash; Used to do a one-time install of all prerequisites for a development machine
* `script/cibuild` &mdash; Used to run automated tests in the CI environment

## Resources

- [Contributing to Open Source on GitHub](https://guides.github.com/activities/contributing-to-open-source/)
- [Using Pull Requests](https://help.github.com/articles/about-pull-requests/)
- [GitHub Help](https://help.github.com)
