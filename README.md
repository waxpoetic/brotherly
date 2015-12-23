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
- Automatic social media promotion and event management using
    Eventbrite, YouTube, Facebook and Bitly.

## Setup

Clone this repo and run the following command to install dependencies
and set up the database:

    ./bin/setup

Then, run the following command to start the server:

    ./bin/rails server

## Development

Contributions are welcome! This project is released under the MIT
License, and issue reports as well as pull requests (with accompanying
tests) are accepted as contributions to the site.

## Deployment

Run the following command to bump the version, create a new Git tag, and
push to GitHub which automatically deploys to Heroku.

```bash
$ bin/rake release
```

By default, this will bump the **patch** version of the `.semver` file.
To bump other parts of the version string, specify the type as the
argument to the Rake task:

```bash
$ bin/rake release[major]
$ bin/rake release[minor]
$ bin/rake release[special]
```

Note that all tag pushes to GitHub will result in a deployment to
Heroku, which as of now is the only deployment of the application on the
Web.
