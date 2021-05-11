# Crono

Crono is a GTD "like" application, made both for real life usage (mine ;) ).
It is also a good example on how a Pharo + Spec + Gtk3 application can be made. 

You can do something like this: 

<img src="https://raw.githubusercontent.com/estebanlm/crono/master/images/mainwindow.png" alt="Nevermind Tasks ScreenShot" width="800px">

# Install
## Prereqs 
I still do not have time to do a real bundle and auto-install everything needed, but here is a list of pre-requisittes: 
You need: `Gtk3` and [ejdb2](https://github.com/Softmotions/ejdb).

### In Linux
use your distro package manager to install `libejdb2`, `gtk3` should be pre-installed

### MacOS
you need to have [homebrew](https://brew.sh/) installed and execute: 
```Shell
$ brew install gtk3
$ brew install adwaita-icon-theme
$ brew install ejdb
```

### Windows
TBD

## Pharo
You need the latest Pharo 9 and VM-headless.
You can get them with your Pharo launcher, or executing : 
```Shell
$ wget -O- https://get.pharo.org/64/90+vmHeadlessLatest | bash 
```
## Install project 

```Smalltalk
 Metacello new 
        repository: 'github://estebanlm/crono';
        baseline: 'Crono';
        load. 
```

Enjoy :)
