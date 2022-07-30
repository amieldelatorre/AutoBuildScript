#!/bin/bash
# ------------------------------------------------------------------------------------------------------------------------------
# Build dotnet project

# Configs
BUILDSCRIPTPATH="c:/git/repo/folder/{folder containing project file}"
GITFOLDERPATH="c:/git/repo"
REPO="https://github.com/you/repo.git"
BRANCHNAME="master"
AUTOBUILD="True"
PROJECTFILE="project.csproj"
LOGFILEPATH="c:/where/you/want/logfile.log"
# End of configs

# Log date and time script is executed
date >> $LOGFILEPATH

# Get output of calling command dotnet
dotnetOutput=$(dotnet)


# Verify dotnet command is available and if not, provide a way to install it
if [[ "$dotnetOutput" != *"Usage: dotnet [options]"* ]]; then
    $dotnetOutput >> $LOGFILEPATH
    echo $'Please install dotnet first to use script. You can use the following commands:' >> $LOGFILEPATH
    echo $'wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb\nsudo dpkg -i packages-microsoft-prod.deb\nrm packages-microsoft-prod.deb' >> $LOGFILEPATH
    echo $'sudo apt-get update && sudo apt-get install -y aspnetcore-runtime-6.0' >> $LOGFILEPATH
    echo $'sudo apt-get update && sudo apt-get install -y dotnet-sdk-6.0' >> $LOGFILEPATH
    exit 0
else
    dotnetVersion=$(dotnet --version)
    echo "[$]dotnet command was found. dotnet version ${dotnetVersion}" >> $LOGFILEPATH
fi

# Get value True or False based on the result of checking if there are any changes in remote branch and possibly pulling it
pullScriptResult=$(./AutoPullScript.sh)

# If the changes have been pulled and AUTOBUILD config is set to true, then build and log result
if [ "$pullScriptResult" == "True" ] && [ "$AUTOBUILD" == "True" ]; then
    echo "Attempting to build changes in branch ($BRANCHNAME) of repo ($REPO)" >> $LOGFILEPATH
    buildLog=$(dotnet build $BUILDSCRIPTPATH/$healthTracker.csproj)

    if [[ "$buildLog" == *"Build succeeded."* ]]; then
        echo "Build succeeded." >> $LOGFILEPATH
    else
        echo "Build failed." >> $LOGFILEPATH
    fi

else
    echo "Not building changes present in branch ($BRANCHNAME) of repo ($REPO), AUTOBUILD config variable is set to ($AUTOBUILD)" >> $LOGFILEPATH
fi

echo "" >> $LOGFILEPATH
