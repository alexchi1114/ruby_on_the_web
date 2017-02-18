require 'socket' 
require 'json'
server = TCPServer.new(2000)
loop {
	client = server.accept
	request = client.gets.split
	#STDERR.puts request
	body=""
	case request[0]
	when 'GET'
		path = request[1]
		if File.exist?(path)
			file=File.open(path)
			body=File.read(path)
			status_code = 200
			reason_phrase = "OK"
		else
			status_code = 404
			reason_phrase = "Not Found"
			puts "nope"
		end
		client.puts "HTTP/1.0 #{status_code} #{reason_phrase}"
		client.puts "Content-Type: text/plain\r\n"
		client.puts "Date: Time.now.ctime"
		client.puts "Content-Length: #{body.size}"
		client.puts ""
		client.puts "#{body}"
	when 'POST'
		member = JSON.parse(request[4])
		template = File.read(request[1])
		data = "<li>Name: #{member["viking"]["name"]}</li><li>Email: #{member["viking"]["email"]}</li>"
		template.gsub!("<%= yield %>", data)
		client.puts template
	end
	client.puts "Closing!"
	client.close

}

