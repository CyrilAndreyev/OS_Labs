#!/bin/bash

select _prompt in 'Search processes by name' 'Search processes by part of name' 'Search process by PID'; do
  case $_prompt in
    'Search processes by name')
      echo 'Search processes by name'
      read -r -p 'Please specify process name: ' _input
      echo 'Getting process list'
      if ! pidof "$_input"; then
        echo 'Processes not found'
      else
        echo "Do you want to kill found processes?"
        select yn in "Yes" "No"; do
          case $yn in
            Yes)
              echo 'Killing'
              kill "$(pidof "$_input")"
              echo 'Killed'
              break
              ;;
            No)
              exit
              ;;
          esac
        done
      fi
      break
      ;;

    'Search processes by part of name')
      echo 'Search processes by part of name'
      read -r -p 'Please specify part of process name: ' _input
      echo 'Getting process list'
      if ! pgrep "$_input"; then
        echo 'Processes not found'
      else
        echo "Do you want to kill found processes?"
        select yn in "Yes" "No"; do
          case $yn in
            Yes)
              echo 'Killing'
              pkill "$_input"
              echo 'Killed'
              break
              ;;
            No)
              exit
              ;;
          esac
        done
      fi
      break
      ;;

    'Search process by PID')
      echo 'Search process by PID'
      read -r -p 'Please specify PID: ' _input
      echo 'Getting process list'
      if ! ps -p "$_input"; then
        echo 'Process not found'
      else
        echo "Do you want to kill the found process?"
        select yn in "Yes" "No"; do
          case $yn in
            Yes)
              echo 'Killing'
              kill "$_input"
              echo 'Killed'
              break
              ;;
            No)
              exit
              ;;
          esac
        done
      fi
      break
      ;;
  esac
done
