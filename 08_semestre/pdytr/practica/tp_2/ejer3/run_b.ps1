$server_ip = "192.168.0.201"

vagrant halt

Start-Sleep -Seconds 5

vagrant up

Start-Process -NoNewWindow -FilePath "vagrant" -ArgumentList "ssh vm1 -c 'cd /vagrant/sources/ && ./server.sh `"ejer_3b_`"'" -PassThru

Start-Sleep -Seconds 10

$cwd = (Get-Location).Path -replace '\\', '/' -replace 'C:', '/mnt/c'

$command = "cd $cwd/sources && ./client.sh ejer_3b_ $server_ip"

Start-Process -NoNewWindow -FilePath wsl -ArgumentList "-- bash -c '$command'" -Wait
