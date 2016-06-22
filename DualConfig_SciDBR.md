Check which nodes have different versions
```
sshg $ALL "R --slave -e 'packageDescription(\"scidb\")' | grep GithubSHA1"
```

Then remove the existing version if required
```
sshg $ALL "R --slave -e 'remove.packages(\"scidb\")'"
```

Finally install the version you want:

For 15.7
```
sshg $ALL "R --slave -e 'devtools::install_github(\"Paradigm4/SciDBR\", ref=\"<commit name>\")' #  specific comment on the master branch
# -- or ---
sshg $ALL "R --slave -e 'devtools::install_github(\"Paradigm4/SciDBR\")' #  latest comment on the master branch

```
For 15.12
```
sshg $ALL "R --slave -e 'devtools::install_github(\"Paradigm4/SciDBR\", ref=\"laboratory")' #  latest commit on the `laboratory` branch
```
