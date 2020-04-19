#!/usr/bin/env ruby

require "date"
require "erb"
require "json"
require "net/http"

# helpers
def format_date(date_str)
  DateTime.parse(date_str).strftime("%m/%d %I:%M%P")
end

def is_pr?(url)
  url.include?("/pull/")
end

def icon_for(state, url)
  return "pr_#{state}" if is_pr?(url)
  "issue_#{state}"
end

def render_atom
  ERB.new(File.read("templates/atom.erb")).result
end

repository = ARGV[0]
now = DateTime.now
since = (now - 1).iso8601
timestamp = now.iso8601
data_url = "https://api.github.com/repos/#{repository}/issues?since=#{since}&sort=updated&state=all"
response = Net::HTTP.get_response(URI(data_url))
if response.is_a?(Net::HTTPSuccess)
  data = JSON.parse(response.body)
  fn = "atom/#{repository.gsub('/', '_')}.xml"
  if data.size > 0
    File.open(fn, "w").do { |f| f.puts render_atom }
  else
    puts "#{repository}: No Data"
  end
else
  puts "#{repository}: Response Status #{response.code}"
end
