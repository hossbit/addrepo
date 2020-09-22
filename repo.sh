#!/bin/sh
## v1.5 By: Mir

green=`tput setaf 2`
red=`tput setaf 1`
reset=`tput sgr0`

scriptdir=`dirname "$BASH_SOURCE"`

echo "${green}Enter Repository name or enter \"${red}remove${reset}${green}\" to remove all repository.${reset}"

echo "Repo name:"

for file in $scriptdir/*.repolist; do
        
	 filename=`basename $file .repolist`
         echo ${red}$filename${reset}
done

read -p "Enter Repo: " fname

if [[ $fname == '' ]]; then
    
   echo "Enter repo name"
  
 elif [[ $fname == 'remove' ]]; then
     rm -f /etc/zypp/repos.d/*
     echo "All repository delete."    
 
 else
     
     input="$scriptdir/$fname.repolist"
    
     if [ -f "$input" ]; then
 
       while IFS= read -r line
           do
             echo "$line"
             zypper addrepo $line
       done < "$input"
    
       zypper refresh

     else

       echo "${red}Enter valid repo name${reset}"
    fi  

fi
