require 'listen'
listener = Listen.to('/home/alan/Desktop') do |modified, added, removed|
  puts "absolute path: #{modified}, #{added}, #{removed}"
end
puts "ready"
listener.start # not blocking
while true do
end
