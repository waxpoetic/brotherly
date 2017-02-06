# brother.ly

[![Build Status](https://travis-ci.org/waxpoetic/brotherly.svg?branch=master)](https://travis-ci.org/waxpoetic/brotherly)
[![Code Climate](https://codeclimate.com/github/waxpoetic/brotherly/badges/gpa.svg)](https://codeclimate.com/github/waxpoetic/brotherly)
[![Test Coverage](https://codeclimate.com/github/waxpoetic/brotherly/badges/coverage.svg)](https://codeclimate.com/github/waxpoetic/brotherly/coverage)
[![Issue Count](https://codeclimate.com/github/waxpoetic/brotherly/badges/issue_count.svg)](https://codeclimate.com/github/waxpoetic/brotherly)

The official site and content repository for the **brother.ly** event
series in Philadelphia.

## Features

- Episode catalog and streams of past episodes
- Full video and audio downloads
- Sliced audio and video episodes of artist performances
- Artist directory to find performances and information about the
  people that have played.
- Administration interface for uploading past episodes and scheduling
  new events.
- Calendar of upcoming events in the community powered by
  [Google Calendar](https://calendar.google.com/calendar/embed?src=brotherlyparty%40gmail.com&ctz=America/New_York)

## Setup

You'll need the following software on your computer before proceeding:

- Ruby 2.3.1 (we recommend using `chruby` and `ruby-install` to manage Rubies on your machine)
- PostgreSQL 9.6
- Git

Clone this repo:

    git clone https://github.com/waxpoetic/brotherly.git
    cd brotherly

Run the following command to install dependencies

    bin/setup

Then, run the following command to start the server:

    bin/rails server

This will launch with essentially a "blank slate", with no data in the
database other than the initial user account that you can log in with.
The app will be available at <http://localhost:3000>.

The production data is stored in [Heroku](http://heroku.com), which is
also where we host all of our apps, so in order to pull down this data
you'll need a Heroku account and be authorized on the production server
to do this.

Run the following command to import our production data:

    HEROKU_API_KEY='your-heroku-api-key' bin/rails db:import

Access to this data is restricted to core team members only. We're
working on providing some sample data so development isn't so
constricted.

## Development

To run tests:

    bin/rails test
    bin/rails test:unit
    bin/rails test:features

Contributions are welcome! This project is released under the BSD
License, and issue reports as well as pull requests (with accompanying
tests) are accepted as contributions to the site.

## Deployment

Run the following command to bump the version, create a new Git tag, and
push to GitHub which automatically deploys to Heroku.

    bin/rails release

By default, this will bump the **patch** version of the application.

To bump other parts of the version string, you can specify the type of
version to update:

    bin/rails release:major
    bin/rails release:minor
    bin/rails release:patch

All tag pushes to GitHub result in a deployment to the production
server at http://brother.ly automatically after a successful CI build.
Successful CI builds of the 'master' branch are deployed to
http://beta.brother.ly.

## License

This software is released under the [Simplified BSD
License](https://opensource.org/licenses/BSD-2-Clause). See the
`BSD-LICENSE` file for more details.
