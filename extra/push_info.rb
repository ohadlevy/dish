#! /usr/bin/env ruby

# URL where dish lives
url="http://0.0.0.0:3000"

require 'net/http'
require 'uri'

# hosts to loop though SSH
hosts = %w{ host1 host2 host3 }

# toggle this based on your os - we'll add the logic later on
rpm_cmd = "rpm -qa --qf  \"%{name}===%{version}-%{release}===%{arch} \n\""
#dpkg_cmd = "dpkg-query -W -f=\\${Package}===\\${Version}===\\${Architecture}\\\\n"

for host in hosts
  puts "importing #{host}"
  splitter = "!!~split~!!"
  cmd = "ssh -l root #{host} 'facter operatingsystem lsbdistrelease && echo #{splitter} && #{rpm_cmd}'"
  output = %x{#{cmd}}
    next if output.empty?
    helper , list = output.split("#{splitter}\n")
    os = ""
    helper.split("\n").each do |l|
      if l =~ /^operatingsystem => (.*)$/
        os = $1 + os
      end
      if l =~ /^lsbdistrelease =>(.*)$/
        os = os + $1
      end
    end
    t=Time.now
    begin
      Net::HTTP.post_form(URI.parse("#{url}/hosts"), {:script => true, "host[name]"=> host, :os => os, :packagelist => list })
      puts "finished #{host} in #{Time.now - t} seconds"
    rescue Exception => e
      raise "Could not send facts to dish: #{e}"
    end
end
