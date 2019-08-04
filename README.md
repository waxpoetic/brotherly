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

To install the app on your machine for local development, you'll need
[Docker][] installed.

First, clone down the repo:

```bash
git clone https://github.com/waxpoetic/brotherly.git
cd brotherly
```

Set up your `$COMPOSE_FILE` to read from **docker-compose.yml** and
**docker-compose.development.yml**. This isn't strictly necessary, but
avoids a bunch of `-f` arguments in your compose commands. We recommend
putting this in your `.envrc` if you use [direnv][]:

```bash
export COMPOSE_FILE="docker-compose.yml:docker-compose.development.yml"
```

Next, build the image and install the database:

```bash
docker-compose run --rm web bin/rails db:setup
```

Now you can start the server and browse to <http://localhost:3000> to
view the running application!

```bash
docker-compose up -d
```

This includes a minimal amount of data to view all features on the site.

The production data is stored in [Heroku](http://heroku.com), which is
also where we deploy all of our apps, so in order to pull down this data
you'll need a Heroku account and be authorized on the production server
to pull down data.

Run the following command to import our production data:

    HEROKU_API_KEY='your-heroku-api-key' bin/rails db:import

## Development

Contributions are welcome! This project is released under the BSD
License, and issue reports as well as pull requests (with accompanying
tests) are accepted as contributions to the site.

To run tests:

```bash
bin/rspec
```

You can also run both Ruby and JS/CSS lint checks at once by running:

```bash
bin/rails lint
```

As stated above, a passing build is required for your contributions to
be accepted into the codebase. Failing lint checks _might_ prevent a pull
request from being merged, but a maintainer may override this.

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

Much like the development environment, we use Docker to build the
production image and ensure that the exact same code (and its
dependencies) are used on production as are used on development.

## License

This software is released under the [Simplified BSD
License](https://opensource.org/licenses/BSD-2-Clause). See the
`BSD-LICENSE` file for more details.
