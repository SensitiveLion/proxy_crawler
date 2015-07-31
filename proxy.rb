require "pry"
require "mechanize"
require "nokogiri"
require "open-uri"

count = 32

agent = Mechanize.new
proxy = agent.get("http://www.proxy4free.com/list/webproxy1.html")
link = proxy.links[count]
proxy = link.click
proxy_form = proxy.form()

until proxy_form.q
  count += 3
  proxy = agent.get("http://www.proxy4free.com/list/webproxy1.html")
  link = proxy.links[count]
  proxy = link.click
  proxy_form = proxy.form()
end

files = ["ad_servers", "emd", "exp", "fsa", "grm", "hfs", "hjk", "mmt", "pha",
          "psh", "wrz"]

files.each do |type|
  proxy_form.q = "http://hosts-file.net/#{type}.txt"
  proxy = agent.submit(proxy_form)
  pry
end



