#require_relative './GoogleDriveAPI.jar'
require './GoogleDriveAPI.jar'
#require_relative '/git/Google_API_Test/GoogleDriveAPI.jar'
#require '/git/Google_API_Test/GoogleDriveAPI.jar'

java_import "GoogleDriveAPI"

file_path = ARGV

GoogleDriveAPI.setup # This line is very important!!
fileID = GoogleDriveAPI.upload('../File_System_Guard/\"#{file_path}\"')
# fileID = GoogleDriveAPI.upload('/home/alan/Desktop/檔案屬性判斷.jpg')
GoogleDriveAPI.download(fileID, '../File_System_Guard/\"#{file_path}\"')
