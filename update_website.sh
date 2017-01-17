# Usage:
# bash update_website.sh "COMMENT"

# Set a default if no comment is given
COMMENT=${1:-"Automatic commit from update_website.sh"}

HERE=$(pwd)

# Upload this website...
MYWEB="davidegerosa.com"
#MYWEB="https://davidegerosa.com"
#MYWEB="davidegerosa.wordpress.com"
echo $MYWEB

# Here is my repository
REPDIR="${HOME}/Documents/reps/myweb"
cd $REPDIR

# Download all the website
wget --convert-links -r "https://${MYWEB}"

# Upload website the department server
scp -r $MYWEB/* dg438@ssh.damtp.cam.ac.uk:public_html
scp -r $MYWEB/* dgerosa@tapir.caltech.edu:public_html

# Caltech needs 755 permission. Be sure it's there
ssh dgerosa@tapir.caltech.edu chmod 755 public_html


# Store website on github
git add $MYWEB
git commit -m "$COMMENT"
git push

# Go back
cd $HERE
