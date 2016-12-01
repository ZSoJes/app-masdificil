# Hace require de los gems necesarios.
# Revisa: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

# Require gems we care about
require "carrierwave"         # añadiendo las gemas
require 'carrierwave/orm/activerecord'  # necesarias para mini_magick
require 'mini_magick' 

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'
require 'bcrypt'
require 'twitter'
require 'yaml'

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s
Encoding.default_external = Encoding::UTF_8

Encoding.default_internal = Encoding::UTF_8
# Configura los controllers y los helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'uploaders', '*.rb')].each { |file| require file }

# Configura la base de datos y modelos
require APP_ROOT.join('config', 'database')


yaml = YAML.load(File.open("config/twitter_public.yml"))
CLIENT = Twitter::REST::Client.new do |config|
   config.consumer_key        = yaml["consumer_key"]
   config.consumer_secret     = yaml["consumer_secret"]
   config.access_token        = yaml["access_token"]
   config.access_token_secret = yaml["access_token_secret"]
end

#Configuración global de todos los uploaders de CarrierWave
CarrierWave.configure do |config|
  config.root = APP_ROOT + 'public/'
end
