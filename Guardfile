require 'json'
require './api.rb'

#directories %w(/home/alan/Desktop)
directories %w(.)

# IMPORTANT!! To set global variables in this Guardfile,
# please refer to the "Setting" class in api.rb.

## Issue: How can we detect renaming files or directories??
def add_file(change)
  # Get attributes and Upload
  size = File.size(change) # integer
  path = File.realpath(change)

  # Set input information
  uri = URI.parse("http://localhost:9292/create/file")
  header = {'Content-Type': 'application/json'}
  obj = { username: 'alan',
          path: path,
          portion: 1,
          size: size
        }
  # Create the HTTP objects
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.request_uri, header)
  request.body = obj.to_json

  # Send the request to our server to update info
  response = http.request(request)
  if response.code != '200'
    puts 'Add file failed at Guardfile'
    return -1
  end

  # Get file record id and allocated gaccount
  file_id, gaccount = response.body.split(/[ ]/)

  # Call Java API to upload files to Drive
  gfile_id = Setting.api.call("upload", gaccount, path)
  space = Setting.api.call("getSpace", gaccount)

  # Update file metadata to our server
  uri = URI.parse("http://localhost:9292/update/metadata")
  header = {'Content-Type': 'application/json'}
  obj = { username: 'alan',
          file_id: file_id, #.to_s, # Body must only yield String values?
          gfile_id: gfile_id,
          drive_space: space
        }
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.request_uri, header)
  request.body = obj.to_json
  http.request(request)
end

def remove_file(change)
  # Get attributes
  path = Pathname.new("#{Setting.folder}/#{change}").relative_path_from(Pathname.new("/")).to_path

  # Set input information
  uri = URI.parse("http://localhost:9292/delete/file")
  header = {'Content-Type': 'application/json'}
  obj = { username: 'alan',
          path: path
        }
  # Create the HTTP objects
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.request_uri, header)
  request.body = obj.to_json
  # Send the request to our server to update info
  response = http.request(request)

  # Delete files on Google Drive
  if response.code == '200'
    gaccount_gfid_list = response.body.split(/[ ]/)
    gaccount_gfid_list.select! { |unit| !unit.empty? }
    gaccount_gfid_list.each_slice(2) do |email, id|
      Setting.api.call("delete", email, id)
    end
  end
end

additions_pipe = proc do |_, _, changes|
  changes.each do |change|
    if !File.symlink?(change) # ignore symbolic link
      if !File.directory?(change)
        # Debug Message
        puts "FILE #{File.realpath(change)} added" || throw(:task_has_failed)
        # Add file
        add_file(change)
      else
        puts "DIR #{File.realpath(change)} added" || throw(:task_has_failed) # IMPORTANT!
      end
    else
      puts "Is a symbolic link!!"
    end
  end
end

modifications_pipe = proc do |_, _, changes|
  changes.each do |change|
    if !File.symlink?(change)
      # system("ls") || throw(:task_has_failed) # IMPORTANT!
      if !File.directory?(change)
        # Debug Message
        puts "FILE #{change} modified" || throw(:task_has_failed) # IMPORTANT!
        # Should be deleted and added again!
        remove_file(change)
  ##!!!! I think here should wait for a moment to let the process run!!!!
        add_file(change)
      end
      # If a directory changes, it means files under it change.
      # We have nothing to do here.
    else
      puts "Is a symbolic link!!"
    end
  end
end

removals_pipe = proc do |_, _, changes|
  changes.each do |change|
    if !File.symlink?(change)
      # system("tree") || throw(:task_has_failed) # IMPORTANT!
      if !File.directory?(change)
        # Debug Message
        puts "FILE #{change} removed" || throw(:task_has_failed) # IMPORTANT!
        # Delete File
        remove_file(change)
      else
        # I think the guard cannot check directory removal?
        puts "DIR #{change} removed" || throw(:task_has_failed) # IMPORTANT!
      end
    else
      puts "Is a symbolic link!!"
    end
  end
end

yield_options = {
  run_on_modifications: modifications_pipe,
  run_on_additions: additions_pipe,
  run_on_removals: removals_pipe
}

guard :yield, yield_options do
    watch /.*/
#    watch /.*\//    ##Didn't work
#    watch /s.*c/
#    watch(%r{^spec/(.+)\.rb$})
#    watch(%r{^spec/(.+)\.rb$})
#    watch(%r{^spec/.+_spec\.rb$})
end

# directories %w(. config db models specs) \
#.select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}
## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

# Add files and commands to this file, like the example:
#   watch(%r{file/path}) { `command(s)` }

#guard :shell do
#  watch(/(.*).txt/) {|m| `tail #{m[0]}` }
#end

#guard :shell do
#  watch /(.*)/ do |m|
#    n m[0], 'Changed'
#    `say -v cello #{m[0]}`
#  end
#end

#guard :shell do
#  watch /.*/ do |m|
#    m[0] + " has changed."
#  end
#end

#guard :shell do
#  watch /.*/ do |m|
#    n m[0], 'File Changed'
#  end
#end


#for comment:
#:66,70s/^/#
#for uncomment:
#:66,70s/^#/

# Example 1: Run a single command whenever a file is added
#notifier = proc do |title, _, changes|
#  Guard::Notifier.notify(changes * ",", title: title )
#end
#
#guard :yield, { run_on_additions: notifier, object: "Add missing specs!" } do
#  watch(/^(.*)\.rb$/) { |m| "spec/#{m}_spec.rb" }
#end

# Example 2: log all kinds of changes
#require 'logger'
#yield_options = {
#  object: ::Logger.new(STDERR), # passed to every other call
#
#  start: proc { |logger| logger.level = Logger::INFO },
#  stop: proc { |logger| logger.info "Guard::Yield - Done!" },
#
#  run_on_modifications: proc { |log, _, files| log.info "!! #{files * ','}" },
#  run_on_additions: proc { |trigger, _, files| trigger.warn "++ #{files * ','}" },
#  run_on_removals: proc { |log, _, files| log.error "xx #{files * ','}" },
#}
#
#guard :yield, yield_options do
#  watch /.*/
#end
