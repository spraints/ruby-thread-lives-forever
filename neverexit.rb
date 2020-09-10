Thread.new do
  puts "Starting thread"
  loop do
    begin
      should_raise = true
      begin
        sleep 1
        should_raise = false
        puts "... tick (thread state = #{Thread.current.status})"
      ensure
        raise "boom" if should_raise
      end
    rescue => e
      puts "ignoring #{e.message} (#{e.class})"
    end
  end
end

# Let the thread get started.
sleep 1.5
puts "all done! exiting..."
