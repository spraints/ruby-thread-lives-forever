# Ruby threads that never exit

Ruby is supposed to kill threads when the main thread exits. But it's easy to accidentally make this not happen by raising an error from an ensure block within the thread.

```ruby
neverexits = Thread.new do
  loop do
  begin
    begin
      sleep 10000
    ensure
      raise "you can't make this thread exit"
    end
  rescue
  end
end
```

To view a reproduction of this, run `docker-compose run neverexit`.

```
$ docker-compose run neverexit
Creating ruby-thread-lives-forever_neverexit_run ... done
Starting thread
... tick (thread state = run)
all done! exiting...
ignoring boom (RuntimeError)
... tick (thread state = aborting)
... tick (thread state = aborting)
... tick (thread state = aborting)
(repeats forever)
```

Control-C can't interrupt this program. You'll need to kill the container with `docker-compose down`.
