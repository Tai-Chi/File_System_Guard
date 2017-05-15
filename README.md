# File_System_Guard
* 0. Final model should be a installation package for client, and the guard would listen all change and send proper message to activate the steps.

## TODO
1. direcotry change didn't check.
2. The system cannot detect renaming now.
3. How to upload initial data?
4. How to change listened folders to Guardfile in programming way?
5. For now, the listened folders still cannot be too large, due to efficiency.

## USUAGE
0. $ rvm use jruby
1. $ bundle install
2. $ (rvmsudo) bundle exec guard -i
3. $ (Use other terminal) (Add/Modify/Rename any type of files, the former terminal will know it.)
4. If the listened folders may contain lots of files, run the following in a terminal.  
$ echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p  
It means that we increase the number of watched files to 524288.
