#!/usr/bin/env bash

function move {
  for file in kube* ; do
    current_loc=$(which $file)
    test -z "$current_loc" && echo "skip $file" || mv $file $current_loc
  done
}

move






test -z "$1" && echo "Usage: k8s-replace file_glob" && exit 1

move "$1"
