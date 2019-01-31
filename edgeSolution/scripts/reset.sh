#
#  Purpose: Clean up Delete and Reset the environment
#  Usage:
#    clean.sh

###############################
## ARGUMENT INPUT            ##
###############################
usage() { echo "Usage: clean.sh ssh" 1>&2; exit 1; }

if [ ! -z $1 ]; then SSH_DELETE=$1; fi
if [ -z $SSH_DELETE ]; then
  SSH_DELETE=false
fi

function rmFile() {
  # Required Argument $1 = FILE

  if [ -z $1 ]; then
    tput setaf 1; echo 'ERROR: Argument $1 (FILE) not received' ; tput sgr0
    exit 1;
  fi

  if [ -f $1 ]; then rm $1; fi
}

function rmDirectory() {
  # Required Argument $1 = DIRECTORY

  if [ -z $1 ]; then
    tput setaf 1; echo 'ERROR: Argument $1 (DIRECTORY) not received' ; tput sgr0
    exit 1;
  fi

  if [ -d $1 ]; then rm -rf $1; fi
}



##############################
## Clean Up Solution Files ##
##############################

DIR_SOLUTION_CONFIG="./solution/config"
FILE_SOLUTION_ENV="./solution/.env"

tput setaf 2; echo 'Cleaning up the Solution Resources' ; tput sgr0
rmDirectory $DIR_SOLUTION_CONFIG
rmFile $FILE_SOLUTION_ENV
