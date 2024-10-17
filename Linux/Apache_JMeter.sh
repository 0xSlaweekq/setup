sudo apt update -y
sudo apt install -y openjdk-8-jdk apache2
java -version

sudo systemctl start apache2
sudo systemctl enable apache2

wget https://downloads.apache.org//jmeter/binaries/apache-jmeter-5.6.3.tgz
sudo mkdir /opt/jmeter
sudo tar -xvzf apache-jmeter-5.6.3.tgz -C /opt/jmeter --strip-components=1

tee -a ~/.bashrc <<< \
'
export PATH="$PATH:/opt/jmeter/bin"'
source ~/.bashrc
