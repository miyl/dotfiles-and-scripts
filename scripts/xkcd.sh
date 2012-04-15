#! /usr/bin/env bash

# // Marcus, lys:
# This script downloads and displays the newest xkcd comic along with its title and mouse over text.

# Except that the joining part still doesn't work, because I still haven't found out how to do it with imagemagick.

# Dependencies: 
# wget, grep, cat, head, tail, sed, imagemagick, awk and feh.
# It could easily be written to not depend on either awk or sed though, maybe even both with grep alone? And feh could easily be substituted.

# =============================================================

# You need to manually create this subfolder below xkcd.sh:
sub=sub

# Get HTML-document:
wget http://xkcd.com/ -O $sub/xkcd.html

# Isolate relevant lines
grep 'h1\|"http://imgs.xkcd.com/comics/' $sub/xkcd.html > $sub/isolated_lines.html
head -1 $sub/isolated_lines.html > $sub/raw_title.html 
tail -1 $sub/isolated_lines.html >  $sub/raw_image.html


# Isolate title:
sed $sub/raw_title.html -e 's/<[a-z0-9/]*>//g' > $sub/title.txt

#   Converting the title text to an image:
cat $sub/title.txt | convert text:- $sub/title_raw.png

#   Cropping this image and inverting the colors:
convert $sub/title_raw.png -negate -trim $sub/title.png

# Isolate image:
awk -F\" '{print $2}' $sub/raw_image.html | awk -F\" '{print $1}' > $sub/image.html

#   Download image:
wget `cat $sub/image.html` -O $sub/newest_xkcd.png


# Isolate mouse over text:
awk -F\" '{print $4}' $sub/raw_image.html | awk -F\" '{print $1}' > $sub/mouse_over_raw.txt

#   Inserting line breaks after every 70th character for displaying as the background image:
fold -b70 $sub/mouse_over_raw.txt > $sub/mouse_over.txt

#   Converting the mouse over text to an image:
cat $sub/mouse_over.txt | convert text:- $sub/mouse_over_raw.png

#   Resizing and cropping this image:
convert $sub/mouse_over_raw.png -negate -trim $sub/mouse_over.png

# Joining all three images into one:
# Something like this: 
# convert \( $sub/newest_xkcd.png -gravity center $sub/mouse_over.txt +append \) -background black -append $sub/test.png



# Set as background image:
feh --bg-center $sub/newest_xkcd.png


# Resources:
# http://www.linuxquestions.org/questions/linux-software-2/sed-and-printing-only-part-of-a-line-347116/

# http://stackoverflow.com/questions/171480/regex-grabbing-values-between-quotation-marks


# Retired code:

# Isolate image:
#'s/"[a-z0-9:/.]*"/TEST/'
