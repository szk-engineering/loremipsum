# coding: utf-8

require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader' if development?

class MainApp < Sinatra::Base
  get '/' do
    @text = 'hello'
    erb :index
  end
end
