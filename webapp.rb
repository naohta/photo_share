#coding:utf-8
require 'sinatra'
require 'fileutils'
require 'exifr'
require 'securerandom'

post '/photo' do
  content_type:json
  p params
  if params[:imgData]
    f = params[:imgData][:tempfile]
    tm = (d=EXIFR::JPEG.new(f).date_time) ? d : Time.now.localtime("+09:00")
    FileUtils.cp(f,"uploaded/#{tm.strftime("%Y-%m-%d")} [#{SecureRandom.uuid}].jpg")
    "OK, Uploaded! - PhotoShare"
  else
    "Error. Didn't upload. - PhotoShare"
  end
end

get '/filenames/*' do |date|
  content_type:json
  files = Dir.glob("uploaded/#{date}*.jpg")
  p files.to_s
end

get '/file/*' do |filename|
  content_type:'imgage/jpeg'
  send_file filename
end


