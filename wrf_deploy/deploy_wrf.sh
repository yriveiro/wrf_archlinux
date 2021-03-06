# @Author: Benjamin Held
# @Date:   2018-11-15 18:08:23
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-01-04 22:16:32

# main script to deploy a pre compiled version of wrf
# Version 0.3.0
# created by Benjamin Held and other sources, June 2017

# enable termination on error
set -e

# check and load required packages
sh load_packages.sh

# create neccessary directories
sh create_directories.sh

# load and unpack the neccessary geodata, WRFV3 minimal
sh load_geodata.sh 2

# load and unpack the wrf archive, version 3.9.1
sh load_wrf.sh 1
