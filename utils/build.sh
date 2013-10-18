#!/bin/bash

usage()
{
	echo -e ""
	echo -e ${txtbld}"Usage:"${txtrst}
	echo -e "  build.sh [options] device"
	echo -e ""
	echo -e ${txtbld}"  Options:"${txtrst}
	echo -e "    -c  Clean before build"
	echo -e "    -d  Use dex optimizations"
	echo -e "    -j# Set jobs"
	echo -e "    -s  Sync before build"
	echo -e ""
	echo -e ${txtbld}"  Example:"${txtrst}
	echo -e "    ./build.sh -c mako"
	echo -e ""
	exit 1
}

# get OS (linux / Mac OS x)
IS_DARWIN=$(uname -a | grep Darwin)
if [ -n "$IS_DARWIN" ]; then
	CPUS=$(sysctl hw.ncpu | awk '{print $2}')
	DATE=gdate
else
	CPUS=$(grep "^processor" /proc/cpuinfo | wc -l)
	DATE=date
fi

export USE_CCACHE=1

opt_clean=0
opt_dex=0
opt_jobs="$CPUS"
opt_sync=0

while getopts "cdj:s" opt; do
	case "$opt" in
	c) opt_clean=1 ;;
	d) opt_dex=1 ;;
	j) opt_jobs="$OPTARG" ;;
	s) opt_sync=1 ;;
	*) usage
	esac
done
shift $((OPTIND-1))
if [ "$#" -ne 1 ]; then
	usage
fi
device="$1"

# Omni device dependencies
echo -e ""
echo -e ${bldblu}"Looking for Omni product dependencies${txtrst}"${cya}
build/tools/roomservice.py "$device"
echo -e "${txtrst}"

if [ "$opt_clean" -ne 0 ]; then
	make clean >/dev/null
fi

# sync with latest sources
if [ "$opt_sync" -ne 0 ]; then
	echo -e ""
	echo -e ${bldblu}"Fetching latest sources"${txtrst}
	repo sync -j"$opt_jobs"
	echo -e ""
fi

rm -f out/target/product/$device/obj/KERNEL_OBJ/.version

# get time of startup
t1=$($DATE +%s)

# setup environment
echo -e ${bldblu}"Setting up environment"${txtrst}
. build/envsetup.sh

# Remove system folder (this will create a new build.prop with updated build time and date)
rm -f out/target/product/$device/system/build.prop
rm -f out/target/product/$device/system/app/*.odex
rm -f out/target/product/$device/system/framework/*.odex

# brunch device
echo -e ""
echo -e ${bldblu}"Brunching device"${txtrst}
lunch "omni_$device-userdebug";

echo -e ""
echo -e ${bldblu}"Starting compilation"${txtrst}

# start compilation
if [ "$opt_dex" -ne 0 ]; then
	export WITH_DEXPREOPT=true
fi

make -j"$opt_jobs" bacon
echo -e ""

# finished? get elapsed time
t2=$($DATE +%s)

tmin=$(( (t2-t1)/60 ))
tsec=$(( (t2-t1)%60 ))

echo -e ${bldgrn}"Total time elapsed:${txtrst} ${grn}$tmin minutes $tsec seconds"${txtrst}
