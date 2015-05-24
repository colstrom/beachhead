#!/usr/bin/env ruby
require 'bundler/setup'
require 'mechanize'
require 'formatador'

def agent
  @agent ||= Mechanize.new.tap do |agent|
    agent.user_agent_alias = 'Mac Safari'
  end
end

def error?(url)
  agent.head url
  false
rescue Mechanize::ResponseCodeError
  true
end

def twitter_available?(name)
  error? "https://twitter.com/#{name}"
end

def github_available?(name)
  error? "https://github.com/#{name}"
end

def translate(value)
  value ? 'YES' : 'NO'
end

def check(name)
  {
    name: name,
    github: translate(github_available?(name)),
    twitter: translate(twitter_available?(name))
  }
end

data = ARGV.map { |name| check(name) }
Formatador.display_table(data, [:name, :github, :twitter])
