# Configure dual SciDB installs on salty

SciDB version 15.12 already exists with profile `polioc..`

Want to also have 15.7 working with the profile `ksen`

# Create folders in the data drives

# For each node in the cluster, do the following:
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
```

# Config files

Based on the data folders created above, populate the config file for 15.7

# Script to switch back and forth

```
alias switchto15p12="cp .scidbrc.15.12 .scidbrc; source .bashrc"
alias switchto15p7="cp .scidbrc.15.7 .scidbrc; source .bashrc"
```

where the only difference between 15.12 and 15.7 is only in `SCIDB_VER`
