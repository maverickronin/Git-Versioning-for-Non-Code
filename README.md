# Git Versioning for Non-Code
This is a quick little script I made for using git to make indefinitely versioned backups of things other than source code like config files, game saves, or even documents.

This script targets PowerShell 5.1 on Windows and assumes that Git for Windows is installed and configured.

A GUI such as TortoiseGit which lets you browse commit history and easily revert individual files is recommended for getting your data back out.

This definitely isn't the most robust implementation possible but I'm throwing it out here in case anyone else wants to use it as a starting point.

## Initialize Repositories
Initialize git repositories in the folders to version and add .gitignore files as needed.

## Set variables inside the script

#### $GitFolders
Array of folder paths with existing/initialized git repositories which you would like to version with a single run of the script.  Replace the examples with your own.

#### $MessageLimit

Maximum length of the commit message before it will stop listing individual files and just give the total number of changes.

## Decide How to Run it

On every run it will add and commit all changes to the folder and list changed files in the commit message until it exceeds the $MessageLimit.

Run it manually, make a scheduled task, or get fancy with monitoring directories for changes.