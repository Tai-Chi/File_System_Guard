# File_System_Guard
* 0. Final model should be a installation package for client, and the guard would listen all change and send proper message to activate the steps.

## TODO
1. direcotry change didn't check.
2. The system cannot detect renaming now.
3. How to upload initial data?

## USUAGE
0. $ rvm use jruby
1. $ bundle install
2. $ (rvmsudo) bundle exec guard
3. $ (Use other terminal) (Add/Modify/Rename any type of files, the former terminal will know it.)
