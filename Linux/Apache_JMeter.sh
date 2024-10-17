echo "Update package"
sudo apt update -y

echo "Install java and apache"
sudo apt install openjdk-11-jdk apache2 -y

echo "Check version java"
java -version

echo "Start and enable apache2.service"
sudo systemctl start apache2
sudo systemctl enable apache2

echo "Download apache-jmeter-5.6.3"
wget https://downloads.apache.org//jmeter/binaries/apache-jmeter-5.6.3.tgz

echo "Extract apache-jmeter-5.6.3 to /opt/jmeter"
sudo mkdir /opt/jmeter
sudo tar -xvzf apache-jmeter-5.6.3.tgz -C /opt/jmeter --strip-components=1

echo "Export path for /opt/jmeter/bin"
tee -a ~/.bashrc <<< \
'
export PATH="$PATH:/opt/jmeter/bin"'
source ~/.bashrc

echo "Start UI: jmeter
Start CLI: jmeter -n -t your_test_plan.jmx -l results.jtl"
