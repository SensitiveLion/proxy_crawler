require "pry"
require "mechanize"

agent = Mechanize.new
proxy = agent.get("http://www.proxy4free.com/list/webproxy1.html")
link = proxy.links[32]
proxy = link.click
proxy_form = proxy.form()
proxy.form.q = "http://hosts-file.net/?s=Download"
proxy = agent.submit(proxy_form)
binding.pry
pp proxy
