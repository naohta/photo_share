#coding:utf-8
require 'sinatra'
require 'json'

before do
  content_type:html
end

post '/photo' do
  p params
  if params[:photo]
    content_type params[:photo][:type]
    f = params[:photo][:tempfile]
    f.read f.size
  end
end

