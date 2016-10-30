# SlowServer

[![CircleCI](https://circleci.com/gh/jescholl/slow_server.svg?style=svg)](https://circleci.com/gh/jescholl/slow_server)
[![Code Climate](https://codeclimate.com/github/jescholl/slow_server/badges/gpa.svg)](https://codeclimate.com/github/jescholl/slow_server)
[![Test Coverage](https://codeclimate.com/github/jescholl/slow_server/badges/coverage.svg)](https://codeclimate.com/github/jescholl/slow_server/coverage)

This Gem has two parts, slow_server and slow_client, together they can be used to
test timeouts in various stages of connections.

Currently there are two types of delays supported by both client and server,
initial delay and chunk delay.

Initial delay (--delay) causes both client and server to wait some amount of
seconds after the connection is opened before sending anything.

Chunk delay (--chunk-delay) works together with chunk count (--chunks) to split the
message into chunks and send them one chunk at a time with some delay between.  You
can think of this similar to Chunked Encoding for HTTP, but it's not actually using
Chunked Encoding

## Installation

    $ gem install slow_server

## Usage

###slow_client

slow_client is somewhat similar to slowloris, it has tunable delays for various different phases of connection.

```
$ slow_client --help
Usage: slow_client [OPTIONS] [URI]
    -X, --method METHOD              Request Method                      (default: GET)
    -p, --port NUMBER                Listen Port                         (default: 4000)
    -c, --chunks BYTES               Chunks                              (default: 1)
    -d, --delay SECONDS              Transmission delay after connecting (default: 0)
    -k, --chunk-delay SECONDS        Delay between chunks                (default: 0)
    -v, --version                    Show Version
```

###slow_server

slow_server is the counterpart to slow_client, by default it will respond with the story of The Tortoise and The Hare, but it too has tunable delays.

```
$ slow_server --help
Usage: slow_server [OPTIONS] [RESPONSE]
    -p, --port NUMBER                Listen Port                         (default: 4000)
    -c, --chunks BYTES               Chunks                              (default: 1)
    -d, --delay SECONDS              Transmission delay after connecting (default: 0)
    -k, --chunk-delay SECONDS        Delay between chunks                (default: 0)
    -v, --version                    Show Version
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jscholl/slow_server.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

