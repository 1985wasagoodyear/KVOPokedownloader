#  Git vs GitHub

## Git
* Source Version Control technology (SVC)
* allows you to keep track of different states of some source over a period of time
* see who made what changes
* made a variety of different changes, have means to do changes
* doesn't make duplicate copies
* Git: tracks changes.

## GitHub
* service, company
* provide a place to host Git repositories
* competitors: GitLab, Bitbucket, etc.

## Git Repositories
* the filesystem that Git manages
* contains all your different changes
* decentralized by design.

## What if I want to put my changes back on the server?
* or, on GitHub, etc.
* problems: Merge Conflicts, etc.

## Git Commands

`git init`

* makes a git repo
* only do this once

`git add <filename here>`

* stages/adds files to a commit
* a commit represents a snapshot of your project
    * all the changes thus far, author information, date, etc.

`git commit -m "<message here>"`

* makes the commit, with a message
* updates your local repository

`git remote add origin <your remote link here>.git`

* declare a remote repo to connect to
* only do this once

`git push -u origin master`

* pushes/updates the remote with your local changes
* merge conflicts can happen here.
* merge conflicts usually start here.


