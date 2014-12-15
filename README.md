wp-make
=======

A Simple Shell script that automates the process of downloading and setting up a WordPress environment locally on your mac.


###Requires

1.) wget
2.) sed ?
3.) mysqladmin
4.) an alias in .bashrc that points to where you put wpmake.sh
 
example: 
alias wpmake="~/wpmake/wpmake.sh"

edit your wpmake-config.sh to 
contain your root mysql creds

and to use it, just navigate 
to the parent directory of where 
you want wordpress installed 
and type:

wpmake sitename databasename