First check the version of shim installed on the nodes
```
sshg $ALL "sudo yum list installed \"shim\" | grep shim"
```

To change the version of shim on any one node (you can modify the commands to work with `sshg`)
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
tail -f PATH_TO_SCIDB_DIR/0/0/scidb.log | grep Executing &

# Issue a few SciDBR commands and download any small array from the database
R --slave -e 'library(scidb); scidbconnect(); df = iquery("build(<val:double>[i=0:3,2,0], random())", return=TRUE)'

# Finally, after confirming that the main save query (i.e. the one which downloads the data) uses `aio_save`, kill the live grep
fg
^C

```

## Note

At one point of SciDBR development, all save queries could be replaced by `aio_save`. This was broken in a particular version. See issue description https://github.com/Paradigm4/SciDBR/issues/101
