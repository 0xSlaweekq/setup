# Monero
wget https://downloads.getmonero.org/gui/monero-gui-linux-x64-v0.18.3.3.tar.bz2
wget -O binaryfate.asc https://raw.githubusercontent.com/monero-project/monero/master/utils/gpg_keys/binaryfate.asc
wget -O hashes.txt https://www.getmonero.org/downloads/hashes.txt

gpg --keyid-format long --with-fingerprint binaryfate.asc
gpg --import binaryfate.asc
gpg --verify hashes.txt

shasum -a 256 monero-gui-linux-x64-v0.18.3.3.tar.bz2

tar xf monero-gui-linux-x64-v0.18.3.3.tar.bz2
cd monero-gui-v0.18.3.3

./monero-wallet-gui
./monero-wallet-cli
nano ~/.local/share/applications/monero-gui.desktop
cp ~/.local/share/applications/monero-gui.desktop ~/Desktop

sudo apt-get install -y pandoc make
sudo apt-get install -y texlive texlive-xetex
sudo apt-get install -y monero monero-tests
flatpak install flathub org.getmonero.Monero

elbow rustled orphans veered sailor seasons asked upstairs voted tweezers paper elope cinema utopia angled nail beware films bicycle lava piloted fetches slug smidgen smidgen


# Mainnet Nodes
opennode.xmr-tw.org at port 18089 - RANDOM, UNTRUSTED. - Remote nodes volunteered by community members. Independent scanning effort from another community member. Will work with all DNS providers.
node.moneroworld.com at port 18089 - I point this one to whatever I think is best at the time being. Currently, its a small cohort of trusted monero community members.
node.xmrbackb.one at port 18081 - Remote nodes maintained by Snipa
uwillrunanodesoon.moneroworld.com at port 18089 - High speed servers sponsored by community and managed by me.
nodes.hashvault.pro at port 18081 - node run by hashvault pool
node.supportxmr.com at port 18081 - node run by supportxmr.com pool

# Testnet Nodes
node.xmrbackb.one:28081 should have remote access to a testnet. I think its master.
testnet.node.xmrlab.com:28081 is on testnet v6, so same as monero blockchain
testnet.node.xmrlab.com:38081 is on testnet v7, needs github master for access
