#coding:utf-8
require 'sinatra'
require 'fileutils'

post '/pict' do
  content_type:json
  #raw = request.body.read
  #p raw = request.POST
  p raw = request.body.string
  
  if raw!=nil
    FileUtils.cp(raw,"public/uploaded/nao.jpg")
    #"OK, Uploaded!"
    @mes = 'upload completed!'
  else
    #"Error. Didn't upload."
    @mes = 'Error..'
  end
end

post '/photo' do
  p "Hello!"
  p params
  content_type:json
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

