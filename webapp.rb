#coding:utf-8
require 'sinatra'
require 'fileutils'
require 'exifr'
require 'securerandom'

get '/auth/*/*' do |email,hashed_pw|
  p hashed_pw
  if(email != 'test@t.com') then return end
  if(hashed_pw != "037dee0bb90ceea74156f02832d0d9c88baca327cd9b469abcb2ce07cf033c10") then return end
  
  erb :gallery_snippet
end

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

get '/file2/*' do |filename|
  content_type:'imgage/jpeg'
  send_file EXIFR::JPEG.new(filename).thumbnail
end

