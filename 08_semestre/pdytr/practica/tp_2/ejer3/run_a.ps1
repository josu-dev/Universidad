$server_ip = "192.168.0.201"

vagrant halt

Start-Sleep -Seconds 5

vagrant up

Start-Process -NoNewWindow -FilePath "vagrant" -ArgumentList "ssh vm1 -c 'cd /vagrant/sources/ && ./server.sh `"ejer_3a_`"'" -PassThru

Start-Sleep -Seconds 10

vagrant ssh vm2 -c "cd /vagrant/sources/ && ./client.sh `"ejer_3a_`" $server_ip"
