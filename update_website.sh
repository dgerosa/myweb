#!/bin/bash
# Usage:
# bash update_website.sh "REPDIR" "COMMENT"

# Set a default if no comment is given
COMMENT=${2:-"Automatic commit from update_website.sh"}

HERE=$(pwd)

# Upload this website...
MYWEB="davidegerosa.com"
#MYWEB="https://davidegerosa.com"
#MYWEB="davidegerosa.wordpress.com"

# Here is my repository
REPDIR=${1-${HOME}/reps/myweb}

echo $MYWEB
echo $REPDIR
echo $COMMENT


cd $REPDIR



# Download all the website
wget -k -r "https://${MYWEB}" # -k converts links

# Remove index.html from converted links
for f in ${MYWEB}/index.html ${MYWEB}/*/index.html; do
  sed -i -e "s/index.html//g" $f
  rm -f $f-e
done
#scp -r $MYWEB/* dg438@ssh.damtp.cam.ac.uk:public_html

# Upload website to Caltech
#scp -r $MYWEB/* dgerosa@tapir.caltech.edu:public_html
# Caltech needs 755 permission. Be sure it's there
#ssh dgerosa@tapir.caltech.edu chmod 755 public_html

# Upload website to Birmingham
#scp -r $MYWEB/* dgerosa@hydra.sr.bham.ac.uk:www_html
# Birmingham needs 755 permission. Be sure it's there
#ssh dgerosa@hydra.sr.bham.ac.uk chmod 755 www_html



# Store website on github
git add $MYWEB
git commit -m "$COMMENT"
git push

# Go back
cd $HERE
