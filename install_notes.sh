## NOTES for installing multiple software on salty

## SHIM
# shim on all nodes
sudo yum remove shim

# Download shim on Mac 
wget http://paradigm4.github.io/shim/shim-15.7-1.x86_64.rpm # somehow this did not work directly on salty

# Scp to all nodes
scp shim-15.7-1.x86_64.rpm scidb@salty[1-4]_xge:/tmp/

# Then install shim
cd  /tmp/
sudo rpm -i shim-15.7-1.x86_64.rpm

# Make sure to set `aio=1`
sudo vi /var/lib/shim/conf

# Then restart
sudo /etc/init.d/shimsvc restart

## REDIS-SERVER
sudo yum install redis

