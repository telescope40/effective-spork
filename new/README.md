# Iperf performance monitoring 
This is a new version to perform TCP & UDP based IPERF testing 
The docker-compose.yml file is the main orchestrator of the build on the CLIENT side only 
The remote iperf server is just running IPERF as a daemon 

The iperf jobs are executed by the iperf_metric.sh 
The iperf_metric.sh is a shell script that run from telegraf 

Installing Telegraf on the client 

wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
echo "deb https://repos.influxdata.com/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo apt update
sudo apt install telegraf
sudo systemctl enable telegraf

create the telegraf.conf file in /etc/telegraf/telegraf.conf

Steps to Fix the GPG Key Error
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D8FF8E1F7DF8B07E
lsb_release -sc
If needed, update the repository configuration in /etc/apt/sources.list or /etc/apt/sources.list.d/.

 telegraf version  Telegraf 1.34.3 (git: HEAD@983d399f)







