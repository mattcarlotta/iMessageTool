#!/bin/bash
#
# iMessageTool Version 2.1.0 - Copyright (c) 2016 by M.F.C.
#
# Introduction:
#     - iMessageTool is a simple automated bash script that removes cached
#        iMessage files and folders or generates user specified SmUUIDs!
#     - Simply unzip the iMessageTool file to your Desktop and
#        double click to execute the script!
#
#
# Bugs:
#     - Bug reports can be filed at: https://github.com/mfc88/iMessageTool/issues
#        Please provide clear steps to reproduce the bug and the output of the
#        script. Thank you!
#

#===============================================================================##
## GLOBAL VARIABLES #
##==============================================================================##
errNum=0

# Get current user
gUSER=$(stat -f%Su /dev/console)

# Macgen path that will be overriden by load_macgen
gpathMG=""

# MLB serial name
gMG="mg-mlb-serial"

# MacGen Repo
gRacerMG="https://github.com/theracermaster/MacGen"

#===============================================================================##
## USER ABORTS SCRIPT #
##==============================================================================##
function clean_up()
{
  clear
  exit 1
}

#===============================================================================##
## ERROR HANDLING #
##==============================================================================##
function error ()
{
  errNum=$1

  if [[ $errNum -eq 0 ]];
    then
      # user mistake at main
      printf '\n'
      printf '*—-ERROR—-* Invalid choice! Please input “dic” or “idgen” at the prompt.\n'
      printf '            Otherwise, type "help" at the prompt for instructions!\n'
      printf '\n'
      printf 'Restarting the script...\n'
      sleep 2.5
      main
    else
      # user inputs invalid choice at help
      printf '\n'
      printf '*—-ERROR—-* Invalid input.\n'
      printf '\n'
      printf 'Restarting the script...\n'
      sleep 2.5
      main
  fi
}

#===============================================================================##
## DISPLAY INSTRUCTIONS #
##==============================================================================##
function display_instructions()
{
  printf "\n"
  printf "To delete iMessage cache files and folders, input 'dic' or 'DIC'\n"
  printf "       -At next prompt, type 'y' or 'Y' to begin deleting the caches\n"
  printf "       -At next prompt, type 'y' or 'Y' to reboot your computer\n"
  printf "\n"
  printf "To generate SmUUIDs, input 'idgen' or 'IDGEN'\n"
  printf "       -Will automatically generate 20 unique IDs\n"
  printf "\n"
  printf "To generate a MLB Serial, input 'macgen' or 'MACGEN'\n"
  printf "       -Will automatically generate a unique MLB Serial\n"
  printf "\n"
  read -p "Would you like to reload the script now? (y/n)? " choice
    case "$choice" in
    y|Y )
    main
    ;;
    n|N )
    clean_up
    ;;
    * )
    error 1
    ;;
esac
}

#===============================================================================##
## Load MacGen #
##==============================================================================##
function load_macgen()
{
  printf " \n"
  printf "${gMG} was successfully loaded...\n"
  printf " \n"
  chown $gUSER $gdirectoryMG
  gpathMG="${gdirectoryMG}/${gMG}"
  ${gpathMG}
}

#===============================================================================##
## Find MacGen #
##==============================================================================##
function find_macgen()
{
  # Directory path
  local gdirectoryMG="$HOME/Desktop/MacGen"

  printf " \n"
  printf "Searching for the MacGen folder on the Desktop...\n"
  if [[ ! -d "${gdirectoryMG}" ]];
    then
      printf " \n"
      printf "${gMG} wasn't found on the Desktop!\n"
      printf " \n"
      printf "Downloading MacGen from theracermaster's GitHub instead...\n"
      printf " \n"
      cd ~/Desktop
      git clone "${gRacerMG}"
      if [[ $? -ne 0 ]];
        then
          printf ' \n'
          printf '*—-ERROR—-* Make sure your network connection is active!\n'
          exit 1
        else
          load_macgen
      fi
    else
      load_macgen
  fi
}

#===============================================================================##
## GENERATE SMUUIDS #
##==============================================================================##
function generate_ids()
{
      for (( i=1; i <= 20; i++ ))
      do
        printf "%s" "$i: "
        uuidgen
      done
}

#===============================================================================##
## REBOOT COMPUTER #
##==============================================================================##
function reboot_computer()
{
  printf '\n'
  read -p "Would you like to reboot now? (y/n) " choice
    case "$choice" in
    # user requests reboot
    y|Y )
    reboot now
    ;;
    # user refuses reboot, terminate script
    n|N )
    printf "\n"
    printf "It’s highly recommended that you restart your computer as soon as possible!\n"
    printf "\n"
    exit 1
    ;;
    # oops - user made a mistake, terminate script anyway
    * )
    printf "\n"
    printf '*—-ERROR—-* Invalid choice! If deleting the iMessage caches was successful,\n'
    printf 'then it’s highly recommended that you restart your computer as soon as possible!\n'
    printf "\n"
    printf 'Script was aborted!\n'
    exit 1
    ;;
    esac
}

#===============================================================================##
## DELETE IMESSAGE CACHES #
##==============================================================================##
function del_caches()
{
  # remove cache folders in Library/Caches
  cd ~/Library/Caches
  rm -rf com.apple.iCloudHelper com.apple.imfoundation.IMRemoteURLConnectionAgent com.apple.Messages
  # remove files from Library/Preferences
  cd ~/Library/Preferences
  rm com.apple.iChat* com.apple.icloud* com.apple.ids.service* com.apple.imagent* com.apple.imessage* com.apple.imservice*
  # remove messages from library/messages
  find ~/Library/Messages/ -mindepth 1 -delete
  printf '\n'
  printf 'All related iMessage files and folders have been successfully removed!\n'
  sleep 0.25
  reboot_computer
}

#===============================================================================##
## MAIN #
##==============================================================================##
function user_choices()
{
  read -p "Delete iMessage caches or generate SmUUIDs? (dic/idgen/macgen/help/exit)? " choice
    case "$choice" in
      # call delete caches
      dic|DIC )
      del_caches
      ;;
      # call generate ids
      idgen|IDGEN )
      generate_ids
      printf "\n"
      printf "All done!"
      printf "\n"
      exit 0
      ;;
      # call macgen for MLB serial
      macgen|MACGEN )
      find_macgen
      ;;
      # display help instructions
      help|HELP )
      display_instructions
      ;;
      # kill the script
      exit|EXIT )
      clean_up
      ;;
      # oops - user made a mistake, reload script
      * )
      error
      ;;
    esac
}

#===============================================================================##
## GREET USER #
##==============================================================================##
function greet()
{
  printf '            iMessageTool Version 2.1.0 - Copyright (c) 2016 by M.F.C.'
  printf  "\n%s" '--------------------------------------------------------------------------------'
  printf ' \n'
  sleep 0.25
}

#===============================================================================##
## START PROGRAM #
##==============================================================================##
function main() {
  clear
  greet
  user_choices
}

trap '{ clean_up; exit 1; }' INT

if [[ `id -u` -ne 0 ]];
  then
    printf "This script must be run as ROOT!\n"
    sudo "$0"
  else
    main
fi

#================================================================================
