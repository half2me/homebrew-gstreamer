# homebrew-gstreamer
A brew repository for the latest Gstreamer framework and plugins

Sadly, the core repository contains very outdated, missing, or badly written formulas for gstreamer.
I've made this repo to have an always up to date repo for installing the latest gstreamer framework, and all of its plugins.

This is for linux only. Use with linuxbrew.

# Tapping
`brew tap half2me/gstreamer`

# Installing packages
I've kept the naming scheme used upstream, and in the core repos.  
Install packages the same as you would from core, just use this form: `half2me/gstreamer/<FORMULA>`  
For example to install gstreamer, use: `brew install half2me/gstreamer/gstreamer`  

## Installing everything :)
A quick copy+paste solution to install all the packages provided here.
``` bash
brew install half2me/gstreamer/gst-plugins-good half2me/gstreamer/gst-plugins-bad half2me/gstreamer/gst-plugins-ugly half2me/gstreamer/gst-libav half2me/gstreamer/gst-rtsp-server half2me/gstreamer/gstreamer-vaapi
```
and
``` bash
brew install half2me/gstreamer/gst-python --with-python3 --without-python
```
