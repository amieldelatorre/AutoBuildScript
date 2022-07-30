#!/bin/bash
# ------------------------------------------------------------------------------------------------------------------------------
# Pull changes from github

# Configs
REPO="https://github.com/you/repo.git"
BRANCHNAME="master"
GITFOLDERPATH="c:/git/repo"
AUTOPULL="True"
LOGFILEPATH="c:/where/you/want/logfile.log"
# End of configs

# Log date and time script is executed
date >> $LOGFILEPATH

# Get output of calling command git --version
gitOutput=$(git --version)

# Verify git command is available and if not, provide a way to install it
if [[ "$gitOutput" != *"git version"* ]]; then
    $gitOutput >> $LOGFILEPATH
    echo $'lease install git first to use script. You can use the following commands:' >> $LOGFILEPATH
    echo $'sudo apt install git' >> $LOGFILEPATH
    exit 0
else
    echo "git command was found. ${gitOutput}" >> $LOGFILEPATH
fi

# Change directory into the git repo 
cd $GITFOLDERPATH 

# Change to desired branch set in config BRANCHNAME and store in log file
gitCheckout=$(git checkout $BRANCHNAME)
echo $gitCheckout >> $LOGFILEPATH

# Get the result of a git diff between remote and local branch
gitDiff=$(git diff $BRANCHNAME origin/$BRANCHNAME)

# If there is a change present, set a variable to True/False
if [[ "$gitDiff" == "" ]]; then
    echo "No changes in branch ($BRANCHNAME) of repo ($REPO)" >> $LOGFILEPATH
    changePresent="False"
else
    echo "Changes present in branch ($BRANCHNAME) of repo ($REPO)" >> $LOGFILEPATH
    changePresent="True"
fi

# If there is a change present and config AUTOPULL is True, get changes. Store True or False in a variable to check if changes were pulled
if [ "$changePresent" == "True" ] && [ "$AUTOPULL" == "True" ]; then
    echo "Attempting to pull changes in branch ($BRANCHNAME) of repo ($REPO)" >> $LOGFILEPATH
    changes=$(git pull)
    echo $changes >> $LOGFILEPATH

    if [[ "$changes" == *"changed"* ]]; then
        echo "Successfully pulled changes in branch ($BRANCHNAME) of repo ($REPO)" >> $LOGFILEPATH
        pulledChanges="True"
    else
        echo "Error in pulling changes from branch ($BRANCHNAME) of repo ($REPO)" >> $LOGFILEPATH
        pulledChanges="False"
    fi
else
    echo "Not pulling changes present in branch ($BRANCHNAME) of repo ($REPO), AUTOPULL config variable is set to ($AUTOPULL)" >> $LOGFILEPATH
    pulledChanges="False"
fi

echo "" >> $LOGFILEPATH

# Echo / return if there are changes that were pulled
echo $pulledChanges
