# encoding: utf-8

require 'socket'

port = 65432

server = TCPServer.new("", port)

puts "listening on port #{port}...\n\r"

loop do
  Thread.start(server.accept) do |client|    

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
      response = "<html><body><h1>404 NOT FOUND</h1></body></html>"
    else
      response = File.read(file)
    end

    client.puts response

    client.close
  end
end