First check the version of shim installed on the nodes
```
sshg $ALL "sudo yum list installed \"shim\" | grep shim"
```

To change the version of shim on any one node (you can modify the commands to work with `sshg`):
```
# Remove the current version
sudo yum remove shim

# Get the necessary version of shim
cd /tmp
wget http://paradigm4.github.io/shim/shim-15.7-1.x86_64.rpm
# or appropriate version as listed on https://github.com/Paradigm4/shim

# then install the appropriate version e.g.
sudo rpm -i shim-15.7-1.x86_64.rpm

# Invariably, you will have to manually edit the config file to include `aio=1`
sudo vi /var/lib/shim/conf

# Then stop and start shim
sudo service shimsvc stop
sudo service shimsvc start
```

Finally check that aio_save is actually working OK
```
# Start a live grep of the log file 
tail -f ~/scidb_data_ksen/000/0/scidb.log | grep Executing &

# Issue a few SciDBR commands and download any small array from the database
R --slave -e 'library(scidb); scidbconnect(); df = iquery("exchanges", return=TRUE)'

# Finally, after confirming that all save queries use `aio_save`, kill the live grep
fg
^C

```
