#!/bin/sh

## Script to extract and patch retail iso files designed for the Microsoft Xbox 360 Console and convert them for use with a Devkit
## Written by Luke Mellor

## Set some variables
isopath="Downloads/Finished/Games/XBOX360/ISO/"
filespath="XBOX360-EXT/Games/"

## Decide which iso to extract
filename=`zenity  --file-selection --title="Select the iso to extract" --filename=$HOME/$isopath/`

case $? in
         1)
                zenity --info --text="No file selected.";;
        -1)
                zenity --info --text="An unexpected error has occurred.";;
esac

## Decide where to extract to
dest=`zenity  --file-selection --title="Select the destination folder" --directory --filename=$HOME/$filespath/`

case $? in
         1)
                zenity --info --text="No file selected.";;
        -1)
                zenity --info --text="An unexpected error has occurred.";;
esac

## Name the game
name=`zenity --entry --title="Name your game" --text="Enter title of the game" --entry-text "${dest##*/}" --width="500"`

zenity --question \
        --title="Are these details correct?" \
        --text="<b>name:</b> $name

<b>iso:</b> $filename

<b>destination:</b> $dest"

case $? in
    0)
## extract the file
(extract-xiso -x "$filename" -d "$dest" && find "$dest" -name "*.xex" -exec wine ~/.local/share/exe/xextool.exe -ra -md {} \; && find "$dest" -name "*.dll" -exec wine ~/.local/share/exe/xextoo$

if [ "$?" = -1 ] ; then
        zenity --error \
          --text="Extraction canceled."
fi
        ;;
    1)
        zenity --info --text="User Cancelled"
        ;;
    -1)
        zenity --info --text="An unexpected error has occurred."
        ;;
esac

zenity --info \
--text="Finished extracting $name

As requested you will find it in: 
$dest

It has been patched for devkit and renamed for you.

The cake was a lie"

exit
