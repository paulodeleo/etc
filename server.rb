# encoding: utf-8

require 'socket'

port = 65432

server = TCPServer.new("", port)

puts "server initiated...\n\r"
puts "listening on port #{port}...\n\r"

loop do
  puts "waiting for client connection...\n\r"

  client = server.accept
  
  puts "client connected!\n\r"  
  puts "sending message...\n\r" 

  responseBody = "<html>\r\n"
  responseBody << "<body>\r\n"
  responseBody << "<h1>hello world</h1>\r\n"
  responseBody << "</body>\r\n"
  responseBody << "</html>\r\n"
  responseBody << "\r\n"
  responseBody << "\r\n"

  responseHeader = "HTTP/1.1 200 OK\r\n"
  responseHeader << "Content-Type: text/html; charset=utf-8\r\n"
  responseHeader << "Content-Length: #{responseBody.length.to_s}\r\n"
  responseHeader << "\r\n"

  client.puts responseHeader+responseBody

  client.close

  puts "done!"
  puts "--------------------------------------------------"
end