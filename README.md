# AutoBuildScript

Bash script auto updating / pulling changes from a remote repository & also building a dotnet project. This was made with the intention of CI, making sure that changes at least are able to build successfully and don't break in that sense. Made to run on linux.

## Configs before running
Make sure to change the config at the top of AutoBuildScript.sh and AutoPullScript.sh

### Config at AutoPullScript.sh
```bash
# Configs
REPO="https://github.com/you/repo.git"
BRANCHNAME="master"
GITFOLDERPATH="c:/git/repo"
AUTOPULL="True"
LOGFILEPATH="c:/where/you/want/logfile.log"
# End of configs
```

### Config at AutoBuildScript.sh
```bash
# Configs
BUILDSCRIPTPATH="c:/git/repo/folder/{folder containing project file}"
GITFOLDERPATH="c:/git/repo"
REPO="https://github.com/you/repo.git"
BRANCHNAME="master"
AUTOBUILD="True"
PROJECTFILE="project.csproj"
LOGFILEPATH="c:/where/you/want/logfile.log"
PULLSCRIPTPATH="c:/path/to/pull/script.sh"
# End of configs
```

## Cron Job
To add to crontab
```bash
$ crontab -e
```
Example addition to crontab
```vim
*/10 * * * * /home/path/to/AutoBuildScript.sh
```

