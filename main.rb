# coding: utf-8

require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
  @text = 'hello world!'
  erb :index
end

