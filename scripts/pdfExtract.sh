#! /usr/bin/env sh

# Migrated from a shell function, as I don't call it all that often it's silly it's always loaded into memory

# extract specific pages from a PDF using ghostscript, which is included by default in many distributions of linux, and probably freebsd and OS X.
#
# If getting an error like this: 
# GPL Ghostscript 9.22: **** Could not open the file Faktura_p1-p1.pdf .
# **** Unable to open the initial device, quitting.
# It might be a somewhat cryptic way of saying the output device/dir is readonly or some such

# Check if the third argument exists, which implies $1 and $2 are not null either
if [ -z $3 ] ; then
  echo 'This function takes 3 arguments:' "\n"\
    '$1 is the first page of the range to extract' "\n"\
    '$2 is the last page of the range to extract' "\n"\
    '$3 is the input file' "\n"\
    'output file will be named "inputfile_pXX-pYY.pdf"'
else
  # -sDEVICE Selects an alternate initial output device, instead of the default: "If built with X11 support, often the default device is an X11 window (previewer),"
  # -dNOPAUSE "Disables the prompt and pause at the end of each page.  This may be desirable for applications  where  another  program  is  driving Ghostscript"
  # -dSAFER "    The -dSAFER option disables the "deletefile" and "renamefile" operators and prohibits opening piped commands ("%pipe%cmd"). Only  "%stdout"
  #        and  "%stderr" can be opened for writing. It also disables reading from files, except for "%stdin", files given as a command line argument, [..]
  # -o makes it output the file and exit the gs prompt, implying batch. Instead of -o one could do -dBATCH -sOutPutFile=
  # ${3%.*} removes the extension of the file regardless of it being pdf, pDf or PDF.
  gs -sDEVICE=pdfwrite -dNOPAUSE -dSAFER \
     -dFirstPage=${1} \
     -dLastPage=${2} \
     -o ${3%.*}_p${1}-p${2}.pdf \
     ${3}
fi
