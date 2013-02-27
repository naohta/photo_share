#coding:utf-8
require 'sinatra'
require 'fileutils'
require 'exifr'
require 'securerandom'

PHOTO_DIR = "uploaded/"

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
    d = EXIFR::JPEG.new(f).date_time
    date_kind = ""
    if(d==nil) then
      d = Time.now.localtime("+09:00")
      date_kind = "upload_date";
    else
      date_kind = "shot_date"
    end
    if(!File.exist?(PHOTO_DIR)) then Dir.mkdir(PHOTO_DIR) end
    FileUtils.cp(f,"#{PHOTO_DIR}#{d.strftime("%Y-%m-%d")}[#{SecureRandom.uuid}]#{date_kind}.jpg")
    "OK, Uploaded! - PhotoShare"
  else
    "Error. Didn't upload. - PhotoShare"
  end
end

get '/filenames/*' do |date|
  content_type:json
  files = Dir.glob("#{PHOTO_DIR}#{date}*.jpg")
  p files.to_s
end

get '/file/*' do |filename|
  #content_type:image/jpeg
  send_file filename
end


#get '/file2/*' do |filename|
#  content_type:'image/jpeg'
#  send_file EXIFR::JPEG.new(filename).thumbnail
#end

