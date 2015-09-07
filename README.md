# brother.ly

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

## Architecture

`Brotherly` is a Ruby on Rails application that powers
http://brother.ly. The application code itself is split into several
parts, based on the role they play in the app:

### Back-end Application

- **Controllers** parse parameters, instantiate model objects, and
    return responses. Controllers operate in a standardized way for both
    HTML and JSON API responses, by both authorizing each request
    against the resource's authorization policy as well as decorating it
    using its configured presenter object. By virtue of using
    `DecentExposure`, controllers also provide methods to the view layer
    for the resources it has allocated.
- **Decorators** present model objects to the view, typically containing
    logic that is only applicable to the view template layer. Decorators
    also contain handlers to Rails helper methods, so it's easy to
    refactor long or complex markup code out of the view template and
    into a decorator class. Decorators mostly map 1-to-1 with models.
- **Helpers** are global utility methods available in the view that is
    responsible for creating markup  For certain configurable things,
    like the app title, helper methods are a better choice than view
    models or decorators.
- **Jobs** run `Worker` objects (discussed below), and typically
    instantiate said worker class with the given model information as
    their only task. The main goal of a Job
- **Mailers** are used when we need to send custom emails to users. In
    the future, we'll use this as our main marketing engine so we have
    total control of how the email looks.
- **Models** are data models, usually persisted with PostgreSQL (but
    sometimes not persisted at all) that present various tables of
    information in a structured way, and validate their in-memory
    attributes when persisting back to the DB. In the case of search,
    the `Search` class is a "model" but is never saved, instead the
    "save" functionality comes by running the search query with
    `PgSearch.multisearch`.
- **Policies** define consistent authorization logic for the controller
    layer, and have the capability of allowing or denying each request.
    While used on the front-end by design (since it's baked in to how we
    expose resources in the controller), most of its value comes from
    controlling the permissions system on the backend.
- **Serializers** transform JSON requests into JSON API responses and
    act as "decorators" for the API, including presentation logic that
    is specific to JSON requests.
- **Services** communicate with 3rd-party promotional and event
    management services (such as Eventbrite, YouTube and Facebook) when
    new `Episode` records are created. Kicked off by a background job
    and initiated by the `ServiceWorker`, Service objects have a uniform
    model for sending event data to a service and getting back a URL to
    insert back into the Episode record. Alternatively, one can utilize
    the "identity" of a service object and leverage its run-time after
    create and within a background job. Since Service objects inherit
    from the `Worker` base class, one can override the `#perform` method
    completely and write your own code that communicates with a service
    (e.g. for Facebook or Twitter promotion).
- **Transcoders** are also special `Worker` classes that inherit from
    the `Transcoder`, and utilize [AWS Elastic Transcoder][awset] to
    encode uploaded audio into something that can be live streamed
    directly from our CDN. Cutting out the "middle man" of video hosting
    platforms with automated copyright detection, Transcoders allow the
    content hosting of past brother.ly events to be fully self-reliant.
- **Views** are [Haml][haml] templates, mostly logic-free, that define
    where we cache the HTML fragments defined by the app as well as how
    the app is presented to the user.
- **Workers** are objects designed to abstract the actual business logic
    away from Job classes. In many cases, it is desirable to run what
    would normally be done in a background job immediately, such as
    within a Rake task or in some other part of the codebase. Workers
    allow the creation of these tasks, by providing a place for all of
    the logic and leaving the ActiveJob class very light (much like a
    "controller" of the background).

### Libraries

Brotherly also ships with some library code that make the above
application logic possible and elegant:

- **Brotherly::ExposureStrategy** sets up [DecentExposure][de] to our
    liking...enabling decorator support, authorizing all records, and
    establishing proper Strong Parameters support for future Rails
    version upgrade compatibility.
- **Brotherly::Responder** is responsible for standardizing our HTML and
    JSON API responses by using internationalization-driven Flash
    messages, HTTP cache busting for JSON APIs, and insertion of Flash
    messages into HTTP headers for message handling in Ajax requests.
- **Brotherly::Service** The base class for Service objects, this is a
    **Brotherly::Worker** with a defined `perform` method and some nice
    sugar on top for defining the local and remote objects.
- **Brotherly::ShortLink** Since the `Bitly` library doesn't quite map
    to what we want out of a service object, this interim class was made
    to satisfy the hole in the abstraction.
- **Brotherly::Transcoder** A derivative of the `Worker`, transcoders
    all use [AWS Elastic Transcoder][awset] and perform their work in
    about the same way, just with slightly different data points. This
    base class actually creates the job on Elastic Transcoder, but
    requires information from the implementor classes to function
    properly.
- **Brotherly::Worker** is the base class for all worker objects, and by
    proxy, Transcoder and Service objects as well. Worker defines a
    simple model interface around what is basically a glorified "script"
    of code, allowing one to define the main body of the code to be run
    in `#perform` and the use of other ancillary methods to abstract
    away logic.

### Front-end Application

The front-end of brother.ly was created using [Zurb Foundation][zf],
[jQuery][jq] and the [Rails UJS][ujs] plugin that allows for easy remote
form and link handling. We also have some extensions built around Rails
for propagating error messages to JavaScript so they can be displayed
asynchronously to the user. Generally, most of our assets follow the
same convention as the application itself.

Our layout is HTML5-compliant and attempts to follow the guidelines of
Semantic HTML and conventional Haml whenever possible. We use a
`<header>` tag to define the top navigation bar, and a `<footer>` tag
for copyright and other information.

The `<main>` tag's ID is always equal to the current controller name,
while its class is equal to the current action name. This allows for
conventional CSS rules like:

```scss
#episodes {
  .show {
    .title {
      font-size: 36px;
    }
  }
  .current {
    .title {
      font-size: 24px;
    }
  }
}
```

Admin views are prefixed with an additional `#admin` id, coming from the
`<body>` tag:

```scss
#admin {
  #episodes {
    .show {
      .title {
        font-size: 16px;
      }
    }
  }
}
```

With our use of conventional Rails UJS, this also allows for JavaScript
form rules to be placed on, say, any admin new or edit form:

```scss
$(document)
  .on 'ajax:error', '#admin #episodes #dialog form', (xhr, status, error) ->
    console.log error
    flash.alert error
  .on 'ajax:success', '#admin #episodes #dialog form', (event, response, xhr) ->
    $('main').html(response)
```

These events are bound to any form that shows up in a dialog, which are
typically episodes you are creating or have already created and are
editing from the table view. Since that view is already open, there's no
real need to refresh the page. Instead, we can populate the existing
`<main>` tag on the page, which will just have the new page contents
anyway, and save ourselves a refresh.
