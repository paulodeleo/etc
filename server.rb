# encoding: utf-8

require 'socket'

port = 65432

server = TCPServer.new("", port)

puts "listening on port #{port}...\n\r"

#loop do
#  Thread.start(server.accept) do |client|  

    client = server.accept  

    puts "client connected!\n\r"

    request = ""
    while line = client.gets
      request << line
      break if line =~ /^\s*$/
    end

    file = request.split("\n").first.split[1]

    file = "index.html" if file == "/"

    file = file.sub("/","")

    if !File.exists? file
      responseBody = "<html><body><h1>404 NOT FOUND</h1></body></html>"
    else
      responseHeader = "HTTP/1.1 200 OK\n\r"

      t = Time.new.utc
      responseHeader << "Date: #{t.strftime("%A, %d %B %Y %H:%M:%S GMT")}\n\r"

      responseHeader << "Server: Navajo/0.0.1 (Win32)\n\r"

      responseBody = File.read(file)
    end

    client.puts responseHeader
    client.puts responseBody
    client.puts "\n\r"
    client.puts "\n\r"
   
    client.close
#  end
#end