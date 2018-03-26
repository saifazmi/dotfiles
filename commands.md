Terminal Commands and Hacks
===========================

### Terminal Clock

Puts a console clock in top right corner. You can add other infos such as cpu and mem usage too.

```
$ while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done & 
```

**// terminate:** fg ^c  
**// source:** https://www.reddit.com/r/commandline/comments/3eat0f/found_this_console_clock_in_my_collection/

