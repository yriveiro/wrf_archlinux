#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-09-04 11:57:18
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-02-22 17:49:42

# Script that loads the WPS geodata specified by argument or 
# selectable index
# ${1}: the index of the chosen geo data:
# 1: WRFV3 high resolution data
# 2: WRFV3 low resolution data
# 3: WRFV4 high resolution data
# 4: WRFV4 low resolution data

function print_options () {
  printf "${YELLOW} 1: WRFV3 high resolution data\n${NC}"
  printf "${YELLOW} 2: WRFV3 low resolution data\n${NC}"
  printf "${YELLOW} 3: WRFV4 high resolution data\n${NC}"
  printf "${YELLOW} 4: WRFV4 low resolution data\n${NC}"
}

# define terminal colors
source ../libs/terminal_color.sh

# Default selection
SELECT_VALUE=1

# check for script arguments
if [ $# -ne 1 ] 
then
  while true; do
    printf "${LIGHT_BLUE}Select geographical data for WPS preprocessing:\n${NC}"
    print_options        
    read INPUT
    case ${INPUT} in
      [1234]* ) SELECT_VALUE=${INPUT}; break;;
      * ) printf "${RED}Please use a numeric value in [1-4].${NC}\n";;
    esac
  done
else
  case ${1} in
    [1234]* ) SELECT_VALUE=${1} ;;
    ['--help']* ) printf "${LIGHT_BLUE}Usage:\n${NC}"; print_options;;
    * ) printf "${RED}Error: False argument. Please use a numeric value in [1-4] or --help.${NC}\n";;
  esac
fi

# select the geodata
case ${SELECT_VALUE} in
  [1]* ) FILE_NAME='geog_complete.tar.gz';;
  [2]* ) FILE_NAME='geog_minimum.tar.bz2';;
  [3]* ) FILE_NAME='geog_high_res_mandatory.tar.gz';;
  [4]* ) FILE_NAME='geog_low_res_mandatory.tar.gz';;
esac

# load and deploy the geodata
URL_PATH="http://www2.mmm.ucar.edu/wrf/src/wps_files/${FILE_NAME}"
mkdir ${HOME}/geo_data
cd ${HOME}/geo_data
printf "${YELLOW}\nLoading data files: ${NC}\n"
wget ${URL_PATH}
printf "${YELLOW}\nUnpacking archive: ${NC}\n"
if [ ${SELECT_VALUE} -eq 2 ]
then
  tar -xjf ${FILE_NAME}
else
  tar -xzf ${FILE_NAME}
fi
rm ${FILE_NAME}
printf "${YELLOW}\nFinished loading geodata.${NC}\n"
