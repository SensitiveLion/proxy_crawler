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

until proxy_form.q == "" || proxy_form.q == "http://www."
  count += 3
  proxy = agent.get("http://www.proxy4free.com/list/webproxy1.html")
  link = proxy.links[count]
  proxy = link.click
  proxy_form = proxy.forms.last
end

files = ["ad_servers", "emd", "exp", "fsa", "grm", "hfs", "hjk", "mmt", "pha",
          "psh", "wrz"]


fname = "test.txt"

files.each do |type|
  proxy_form.q = "http://hosts-file.net/#{type}.txt"
  proxy = agent.submit(proxy_form)
  doc = Nokogiri::HTML(open(proxy.uri.to_s))
  doc_text_full = doc.css("p").to_s
  doc_text_parse = doc_text_full.gsub(/^<p>.*\n.*\n.*\n.*\n.*\n.*\n.*\n.*\n.*\n/, '')
  doc_text = doc_text_parse.gsub(/#\r\n/,'')
  text = doc_text.split("\r\n")
  binding.pry
end
  File.open(fname, "w+") do |f|
    text.each { |element| f.puts(element) }
  end





