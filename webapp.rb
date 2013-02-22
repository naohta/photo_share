#coding:utf-8
require 'sinatra'
require 'fileutils'

post '/photo' do
  content_type:json
  p params
  if params[:imgData]
    content_type params[:imgData][:type]
    f = params[:imgData][:tempfile]
    FileUtils.cp(f,"public/uploaded/" + params[:imgData][:filename])
    #"OK, Uploaded!"
    @mes = 'upload completed!'
  else
    #"Error. Didn't upload."
    @mes = 'Error..'
  end
end

