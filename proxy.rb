require "pry"
require "mechanize"
require "nokogiri"
require "open-uri"

    count = 32

    agent = Mechanize.new
    proxy = agent.get("http://www.proxy4free.com/list/webproxy1.html")
    link = proxy.links[count]
    if link.uri.to_s == ""
      count -= 1
      link = proxy.links[count]
    end
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

    blocklist = {ssh: "ssh", mail: "mail", Http_apache: "apache",
            imap: "imap", ftp: "ftp", sip: "sip", bots: "bots",
            brute_force_login: "bruteforcelogin", ircbot:"ircbot"}


    blocklist.each do |key, value|
      @hosts_file = []
      proxy_form.q = "http://lists.blocklist.de/lists/#{value}.txt"
      proxy = agent.submit(proxy_form)
      print "."
      doc = Nokogiri::HTML(open(proxy.uri.to_s))
      doc_text_full = doc.css("p").to_s
      text = doc_text_full.split("\n")

      text.each do |t|
        @hosts_file << t
      end

      fname = "text_files/#{key.to_s}.txt"
      File.open(fname, "w+") do |f|
        f.puts(@hosts_file)
      end
      print ""
    end

    print "done"

