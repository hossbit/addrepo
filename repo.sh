#!/bin/sh
## v1.0 By: Mir

scriptdir=`dirname "$BASH_SOURCE"`
echo "Enter Repository name or enter "remove" to remove all repository."
echo "Repo name:"
for file in $scriptdir/*.repolist; do
        filename=`basename $file .repolist`
        echo $filename
done
read -p "Enter Repo: " fname
if [[ $fname == '' ]]; then
    echo "Enter repo name"
elif [[ $fname == 'remove' ]]; then
    rm -f /etc/zypp/repos.d/*
    echo "All repository delete."    
else
    input="$scriptdir/$fname.repolist"
    while IFS= read -r line
    do
        echo "$line"
        zypper addrepo $line
    done < "$input"
    zypper refresh
fi