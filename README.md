Hearthstone Card Search in the Terminal
==============

![Screenshot](http://i.imgur.com/lsdQFoJ.png)

Large screenshow with several hits: [http://i.imgur.com/TpUWeTn.png](http://i.imgur.com/TpUWeTn.png)

This is a script written in ruby to search for specific cards via data from [http://hearthstonejson.com/](http://hearthstonejson.com/)

It already supports autocompletion with tab when the application is running. So ed and tab will become "edwin van cleef". The tab completion will show all 400+ cards. These have been downloaded and stored in the repo for fast access. You can now also search directly via the command line with the -c or --card argument. The script now supports partial search as well, so "doom" will find Doomhammer, Doomguard, Bane of Doom and Doomsayer.

Quite happy with what it does now. What i would like in the future is like a ascii version of the card and bash completion for the CLI.

Input and contributions are always welcome!
