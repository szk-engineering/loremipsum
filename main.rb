# coding: utf-8
# LastModified: 2015/03/10

require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
  @text = 'hello world!'
  erb :index
end

