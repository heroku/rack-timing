# rack-timing

Ever wondered if some of your app's latency is coming from myserious middleware? Want to be able to tie requests to specific workers and threads while you're at it? Add this gem to a Rails app to get a log line like this for each request:

    at=info thread_id=70351652783840 process_id=55394 request_id=013f9cc29c1e4c483435dbc15ab260f4 pre_request=0ms rack_in=202ms app=505ms rack_out=301ms

That includes:

* `thread_id`: For tracking requests across threads, (e.g. Puma)
* `process_id`: For tracking requests across workers (e.g. Puma or Unicorn)
* `request_id`: Correlate with your app (or Heroku router) logs
* `pre_request`: Measure the time between `HTTP_X_REQUEST_START` and the start of your rack stack (similar to New Relic's 'reuqest queueing' metric)
* `rack_in`: The time in the rack stack before your app sees the request
* `app`: The time spent processing the request in your app
* `rack_out`: The time spent going back out of the rack stack

## Installation

Add this line to your application's Gemfile:

    gem 'rack-timing'

And then execute:

    $ bundle

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
