#require_relative './GoogleDriveAPI.jar'
require './GoogleDriveAPI.jar'
java_import "GoogleDriveAPI"

class API
  # Setup (e.g. credential)
  def initialize
    GoogleDriveAPI.setup # This line is very important!!
  end

  # Operation Body
  def call(*argv)
    if argv[0]=='upload'
      return GoogleDriveAPI.upload(argv[1])
    elsif argv[0]=='download'
      return GoogleDriveAPI.download(argv[1], "#{Dir.pwd}/#{argv[1]}")
    elsif argv[0]=='delete'
      return GoogleDriveAPI.delete(argv[1])
    else
      return "Unsupported Operation"
    end
  end
end
