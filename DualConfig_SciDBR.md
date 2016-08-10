Check which nodes have different versions
```
sshg $ALL "R --slave -e 'packageDescription(\"scidb\")' | grep GithubSHA1"
```

Finally install the version you want:

```
# for the master branch
sshg $ALL "R --slave -e 'devtools::install_github(\"Paradigm4/SciDBR\")'" #  latest comment on the master branch

# -- or ---

#  for a specific commit / branch
sshg $ALL "R --slave -e 'devtools::install_github(\"Paradigm4/SciDBR\", ref=\"<commit id or branch name>\")' 
```
