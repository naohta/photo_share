#coding:utf-8
require 'sinatra'
require 'fileutils'

before do
  content_type:html
end

post '/photo' do
  p params
  if params[:photo]
    content_type params[:photo][:type]
    f = params[:photo][:tempfile]
    FileUtils.cp(f,params[:photo][:filename])
    "OK!"
  else
    "Error. Didn't upload."
  end
  
end

