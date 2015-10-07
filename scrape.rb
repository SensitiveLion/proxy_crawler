require "pry"
require "mechanize"
require "nokogiri"
require "open-uri"

@hosts_file = []
proxy = "http://www.malwaredomainlist.com/hostslist/hosts.txt"

doc = Nokogiri::HTML(open(proxy))
doc_text_full = doc.css("p").text
doc_text_parse = doc_text_full.gsub(/.*#/, '')
doc_text_end_parse = doc_text_parse.gsub(/.*localhost/,'')
doc_text = doc_text_end_parse.gsub(/127.0.0.1/,'')
text_empty = doc_text.split("\r\n")
text = text_empty.reject(&:empty?)

text.each do |t|
  @hosts_file << t.strip
end

fname = "text_files/malwaredomainlist.txt"
File.open(fname, "w+") do |f|
  f.puts(@hosts_file)
end

print "."
print "done"


@hosts_file = []
proxy = "http://www.malwaredomainlist.com/hostslist/ip.txt"
doc = Nokogiri::HTML(open(proxy))
text = doc.css("p").text.split("\r\n")

text.each do |t|
  @hosts_file << t.strip
end

fname = "text_files/malwaredomainlist_ip.txt"
File.open(fname, "w+") do |f|
  f.puts(@hosts_file)
end

print "."
print "done"
binding.pry
