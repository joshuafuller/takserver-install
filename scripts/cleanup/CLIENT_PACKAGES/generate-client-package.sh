#!/bin/bash
clear
sleep 2
echo " "
echo " "
PS3='Please select which type of client you would like to provision: '
options=("ITAK" "ATAK" "WINTAK" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "ITAK") cd scripts; sudo bash itak-client.sh; cd ..; echo "Exiting now..."; sleep 2; clear; exit;;
            
        "ATAK") cd scripts; sudo bash atak-client.sh; cd ..; echo "Exiting now..."; sleep 2; clear; exit;;
        
        "WINTAK") cd scripts; sudo bash wintak-client.sh; cd ..; echo "Exiting now..."; sleep 2; clear; exit;;

        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done