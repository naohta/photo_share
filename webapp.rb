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
    FileUtils.cp(f,"public/uploaded/" + params[:photo][:filename])
    redirect 'ec2-54-248-48-75.ap-northeast-1.compute.amazonaws.com:8000'
  else
    "Error. Didn't upload."
  end
end

