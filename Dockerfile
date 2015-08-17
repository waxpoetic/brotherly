#
# Container build script
#


# Start with the Ruby 2.2.2 base image
FROM ruby:2.2.2

# Install hard dependencies
RUN apt-get update -qq && apt-get install -y build-essential

# Install JavaScript runtime for execjs
RUN apt-get install -y nodejs

# Install PostgreSQL client library
RUN apt-get install -y libpq-dev

# Install Nokogiri support libraries
RUN apt-get install -y libxml2-dev libxslt1-dev

# Set up app directories
ENV APP_HOME /srv
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Add application codebase
ADD . $APP_HOME

# Run setup script
RUN bin/setup
