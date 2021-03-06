#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 09:26:31
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-02-27 10:50:15

# script to run the necessary preprocessing steps before starting the wrf run
# $1: the path to the wrf root folder
# $2: the path to the gfs input data
# $3: the resolution of the input data

# variable declaration
GFS_PATH=${1}
RESOLUTION=${2}

source ../set_env.sh

# cleaning up in wps preprocessing folder
SCRIPT_PATH=$(pwd)
now=$(date +"%T")
printf "Cleaning up wps data from last time at ${now}\n" >> ${LOG_PATH}/log.info
cd ${BUILD_PATH}/WPS

# remove met_em files from the last run
rm met_em.d01.*

# remove grib files
rm GRIB*

# remove FILE objects of the time stamps
rm FILE*
rm PFILE*

# cleaning up in wrf
now=$(date +"%T")
printf "Cleaning up wrf data from last time at ${now}\n" >> ${LOG_PATH}/log.info
cd ${BUILD_PATH}/WRFV3/test/em_real/

# remove met_em files from the last run
rm met_em.d01.*

cd ${SCRIPT_PATH}
sh ./pre_processing.sh ${GFS_PATH} ${RESOLUTION}
