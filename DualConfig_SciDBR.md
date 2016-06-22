Check which nodes have different versions
```
sshg $ALL "R --slave -e 'packageDescription(\"scidb\")' | grep GithubSHA1"
```

Then remove the existing version if required
```
sshg $ALL "R --slave -e 'remove.packages(\"scidb\")'"
```

Finally install the version you want
```
sshg $ALL "R --slave -e 'devtools::install_github(\"Paradigm4/SciDBR\", ref=\"<commit name>\")'
```

