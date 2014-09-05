# encoding: utf-8
require 'readline'
require 'open-uri'
require 'json'
require 'terminal-table'
require 'colorize'
require 'optparse'
require_relative 'src/card.rb'
require_relative 'src/search.rb'

search = Search.new()
search.buildAutocomplete
search.initParser
search.initReadline
