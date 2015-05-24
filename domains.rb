#!/usr/bin/env ruby

require 'bundler/setup'
require 'hiredis'
require 'redis'
require 'formatador'
require 'whois'

def redis
  @redis ||= Redis.new
end

redis.smembers('tld:interest').each do |tld|
  redis.srem 'tld:interest', tld.downcase
  redis.sadd 'tld:interest', tld.upcase
end

def availability(name)
  progress = Formatador::ProgressBar.new redis.scard('tld:interest')
  redis.sinter('tld:valid', 'tld:interest').sort.map do |extension|
    domain = "#{name}.#{extension}"
    progress.increment
    { domain: domain, available: Whois.whois(domain).available? }
  end
end

Formatador.display_table availability(ARGV.first.upcase), [:domain, :available]
