# Script to switch back and forth between SciDB versions

1.
There should be a `.scidbrc` existing already (under `scidb` user home). Copy that into two files `.scidbrc.15.12` and `.scidb.rc.15.7`. Then edit the file so that the only difference between 15.12 and 15.7 versions is in `SCIDB_VER`

For example, `.scidbrc.15.12` looks like:
```
export SCIDB_VER=15.12
export PATH=/opt/scidb/$SCIDB_VER/bin:/opt/scidb/$SCIDB_VER/share/scidb:$PATH
export IQUERY_PORT=1239
export IQUERY_HOST=localhost
```

2.
Add the following lines to `.bashrc`:
```
alias switchto15p12="cp .scidbrc.15.12 .scidbrc; source .bashrc"
alias switchto15p7="cp .scidbrc.15.7 .scidbrc; source .bashrc"
```

Note that `.bashrc` should source the `.scidbrc` file and not have any independent references to the SciDB version. These are typically the SciDB specific lines in `.bashrc`:
```
source ~/.scidbrc
export SCIDB="/opt/scidb/$SCIDB_VER/"
```

3. 
```
source .bashrc
```

4.
Now you can just execute the commands
```
# SciDB 15.7 is running. First, stop it
scidb.py stopall <15.7DBNAME>
switchto15p12
scidb.py startall <15.12DBNAME>
```

And you can verify the running version of SciDB by:
```
iquery -aq "list('libraries')" | grep -i scidb
```


# Configure dual SciDB installs on salty

The following assumes that:
 - SciDB version 15.12 already exists with profile `polioc..`
 - Want to also have 15.7 working with the profile `ksen`
Thus, this section has to be completed before we can actually switch back and forth between different SciDB versions

## Create folders in the data drives

## For each node in the cluster, do the following:

NOTE: There were 8 disks per node. Needed to create 20 instance folders per node.
```
for i in $(seq 0 7); 
  do 
  sudo mkdir -p /data$i/scidb_ksen/ ; 
  sudo chown scidb:scidb /data$i/scidb_ksen ; 
  sudo mkdir -p /data$i/scidb_ksen/ ; 
  sudo chown scidb:scidb /data$i/scidb_ksen ; 
done
for i in $(seq 0 7); 
  do 
  mkdir -p /data$i/scidb_ksen/cluster.1 ; 
  mkdir -p /data$i/scidb_ksen/cluster.2 ; 
done
for i in $(seq 0 3) ; do mkdir /data$i/scidb_ksen/cluster.3 ; done 
```

## Config files

Based on the data folders created above, populate the config file for 15.7

## Initialize `ksen` database on postgres 
```
sudo -u postgres /opt/scidb/15.12/bin/scidb.py init-syscat ksen
```

## Update `.pgpass` on all nodes

The previous step will update `~/.pgpass` on the postgres node. Copy the changed line across the cluster. 
```
salty1_xge:5432:ksen:scidb_pg_user:scidb_pg_user
```
