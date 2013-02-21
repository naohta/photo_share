#coding:utf-8
require 'sinatra'
require 'json'

before do
  content_type:html
end

post '/photo/*' do |photo|
  p photo
  "Thx!"
end

