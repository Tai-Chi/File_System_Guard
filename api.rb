#require_relative './GoogleDriveAPI.jar'
require './GoogleDriveAPI.jar'
java_import 'GoogleDriveAPI'

class API
  # Setup (e.g. credential)
  def initialize
    #GoogleDriveAPI.setup # Now it is useless.
  end

  # Operation Body
  def call(*argv)
    if argv[0]=='upload'
      return GoogleDriveAPI.upload(argv[1], argv[2])
    elsif argv[0]=='download'
      return GoogleDriveAPI.download(argv[1], argv[2], "#{Dir.pwd}/#{argv[2]}")
    elsif argv[0]=='delete'
      return GoogleDriveAPI.delete(argv[1], argv[2])
    elsif argv[0]=='getSpace'
      return GoogleDriveAPI.getSpace(argv[1])
    else
      return "Unsupported Operation"
    end
  end
end

class Setting
  @@folder = File.realpath(".")
  @@api = API.new
  def self.folder
    @@folder
  end
  def self.api
    @@api
  end
end
