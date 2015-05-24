#!/usr/bin/env ruby

require 'bundler/setup'
require 'hiredis'
require 'redis'
require 'net/http'
require 'formatador'

def fetch
  source = 'https://data.iana.org/TLD/tlds-alpha-by-domain.txt'
  Net::HTTP.get URI.parse(source)
end

def process(data)
  data.split("\n").reject { |line| line.start_with? '#' }
end

def import(extensions)
  redis = Redis.new
  progress = Formatador::ProgressBar.new extensions.count
  extensions.each do |extension|
    progress.increment
    redis.sadd 'tld:valid', extension.chomp
  end
end

import process fetch
