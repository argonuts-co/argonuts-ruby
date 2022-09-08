# Argonuts Ruby Library

The Argonuts Ruby library provides access to the Argonuts API.

## Documentation

See the [full documentation](https://argonuts.co/docs).

## Installation

You can install it via rubygems:

```console
gem install argonuts-ruby
```

### Bundler

In Gemfile:

```ruby
gem 'argonuts-ruby'
```

And then, type in your terminal:

```console
bundle install
```

## Usage

The library needs you to set your API key which can be found in your [profile](https://argonuts.co/profile).


```ruby
Argonuts.api_key = 'api-key'

Argonuts.notification = {
  url: "https://yoursite.co/api/argonuts/webhook"
}

Argonuts.storage = {
  url: "https://yoursite.co/api/argonuts/upload",
}
```

## Creating a job

```ruby
job = Argonuts::Job.create(
  input: { url: "https://yoursite.co/path/file.mp4" },
  outputs: {
    "jpg:300x": { path: "/image.jpg" },
    "mp4:1080p": { path: "/1080p.mp4" },
    "httpstream": {
      hls: { path: "hls/" }
    }
  }
)
```

## Getting information about a job

```ruby
Argonuts::Job.retrieve(job.id)
```

*Released under the [MIT license](http://www.opensource.org/licenses/mit-license.php).*
