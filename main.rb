#!/usr/bin/env ruby

require "bundler/inline"
require "csv"

gemfile do
  source "https://rubygems.org"
  gem "haml"
  gem "pg"
  gem "puma"
  gem "rackup"
  gem "sinatra"
end

db = PG.connect(ENV.fetch("DATABASE_URL"))

set :views, "."

get "/" do
  haml :index
end

post "/run" do
  sql = params["sql"] || "SELECT 1"
  @rows = db.exec(sql)
  haml :index
end

post "/export" do
  headers "Content-Type" => "text/csv"
  headers "Content-Disposition" => "attachment; filename=dataclip.csv"

  stream = StringIO.new
  sql = params["sql"] || "SELECT 1"

  db.copy_data("COPY (#{sql}) TO STDOUT DELIMITER ',' CSV HEADER FORCE QUOTE *") do
    while (row = db.get_copy_data)
      stream.write(row)
    end
  end

  stream.string
end

Sinatra::Application.run!
