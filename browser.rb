require 'socket'
require 'json'
host = 'localhost'
port = 2000
path = "./index.html"
socket = TCPSocket.open(host, port)

puts "Would you like to GET or POST?"
response = gets.chomp.upcase

case response
when "GET"
	request = "GET #{path} HTTP/1.0\r\n\r\n"
	
	socket.print(request)
	response = socket.read
	print response

when "POST"
	puts "What is your name?"
	name = gets.chomp
	puts "What is your email?"
	email = gets.chomp
	member={:viking => {:name=>name, :email=>email}}
	request = "POST ./thanks.html HTTP/1.0"
	socket.puts "#{request}: #{member.to_json.size} #{member.to_json}"
	response = socket.read
	print response
end

