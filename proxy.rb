require "pry"
require "mechanize"
require "nokogiri"
require "open-uri"

count = 32

agent = Mechanize.new
proxy = agent.get("http://www.proxy4free.com/list/webproxy1.html")
link = proxy.links[count]
proxy = link.click
proxy_form = proxy.forms.last
print "."

until proxy.form.field.name == "q"
  count += 3
  proxy = agent.get("http://www.proxy4free.com/list/webproxy1.html")
  link = proxy.links[count]
  proxy = link.click
  proxy_form = proxy.forms.last
  print "."
end

files = ["ad_servers", "emd", "exp", "fsa", "grm", "hfs", "hjk", "mmt", "pha",
          "psh", "wrz"]

@hosts_file = []

files.each do |type|
  proxy_form.q = "http://hosts-file.net/#{type}.txt"
  proxy = agent.submit(proxy_form)
  print "."
  doc = Nokogiri::HTML(open(proxy.uri.to_s))
  doc_text_full = doc.css("p").to_s
  doc_text_parse = doc_text_full.gsub(/^<p>.*\n.*\n.*\n.*\n.*\n.*\n.*\n.*\n.*\n/, '')
  doc_text_end_parse = doc_text_parse.gsub(/# Hosts:.*\n<\/p>/,'')
  doc_text = doc_text_end_parse.gsub(/#\r\n/,'')
  @hosts_file << doc_text
  print "."
end

fname = "test.txt"
File.open(fname, "w+") do |f|
  f.puts(@hosts_file)
end
print "done"



