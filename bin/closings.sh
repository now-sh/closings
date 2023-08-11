#!/usr/bin/env bash

SCRIPTNAME="$(basename $0)"
SCRIPTDIR="$(dirname "${BASH_SOURCE[0]}")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.pro
# @File        : closings
# @Created     : 16/03/2020
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : scrape site for closings
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Main progam
srchtml="<a href="http://wnyt.com/closings" target="_blank">wnyt.com</a></p>"
url="$(curl -LSs https://wnyt.com/closings | grep -iv "captioning" | grep -i "closed" | sed 's#</strong></div>#:</strong></div>#g;s#<div class="col-xs-6">#<div class="p-3 mb-2 bg-secondary text-white">#g'  )"
count="$(curl -LSs https://wnyt.com/closings | grep "Active Closings and Delays" | grep -o '[0-9]\+')"
gitrepo="https://github.com/casjay/closings"
date="$(date +"%m-%d-%y-%H-%M")"
folder="$(date +"%m-%d-%y-%H")"
file="$date.txt"

cd ~/Projects/github/casjay/closings

if [ ! -d "$folder" ]; then
  mkdir -p $folder
fi

echo "$(date +"%m-%d-%y %H:%M")" >> "$folder/$file"
echo "Current closing count for the capital district is: $count" >> "$folder/$file" && \
echo "<a href=./$file>./$file</a><br>" >> "$folder/index.html"

cat ./header.html > index.html
echo -e "<h1 class="text-danger"><center>Current closings for the capital region: $count</center></h1>" >> index.html
echo -e "<h2 class="text-success"><center><a href="http://covid19.casjay.pro" target="_blank">covid19.casjay.pro</a></center></h2>" >> index.html
echo -e "<h6 class="text-warning"><center>Updated on: $(date +"%m-%d-%y at %H:%M")  from $srchtml</center></h6><br /></br>" >> index.html
echo -e "$url" >> index.html
cat ./footer.html >> index.html

gitup -m "🏫 Updated count 📚" 2> /tmp/gitup-closings.log

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ ! -z "$EXIT" ]; then exit "$EXIT"; fi

# end


#/* vi: set ts=2 sw=2 noai ft=sh syntax=sh expandtab :
