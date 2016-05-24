# Configure dual SciDB installs on salty

SciDB version 15.12 already exists with profile `polioc..`

Want to also have 15.7 working with the profile `ksen`

# Create folders in the data drives

# For each node in the cluster, do the following:

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

# Config files

Based on the data folders created above, populate the config file for 15.7

# Script to switch back and forth

```
alias switchto15p12="cp .scidbrc.15.12 .scidbrc; source .bashrc"
alias switchto15p7="cp .scidbrc.15.7 .scidbrc; source .bashrc"
```

where the only difference between 15.12 and 15.7 is only in `SCIDB_VER`

# Initialize `ksen` database on postgres 
```
sudo -u postgres /opt/scidb/15.12/bin/scidb.py init-syscat ksen
```

# Update `.pgpass` on all nodes

The previous step will update `~/.pgpass` on the postgres node. Copy the changed line across the cluster. 
```
salty1_xge:5432:ksen:scidb_pg_user:scidb_pg_user
```
