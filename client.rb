require 'socket'
hostname = 'localhost'
s = TCPSocket.open(hostname, 2000)

while line = s.gets
	puts line.chop      
end

s.close
