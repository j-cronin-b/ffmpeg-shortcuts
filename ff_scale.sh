#! /bin/sh

# TODO: add description

if [ "${#}" != 2 ] ; then
	echo "Usage: ./`basename ${0}` <scale> <file>"
	exit 1
fi

ff_scale="${1}"
ff_input="${2}"

## TODO: this is common for all the scripts
if [ ! -f "${ff_input}" ] ; then
	echo "Input file not found: '${ff_input}'" >&2
	exit 2
fi

set -x

exec ffmpeg -hide_banner -i "${ff_input}" -vf scale="${ff_scale}" -c:a copy \
	-c:v libx265 -preset ultrafast -x265-params lossless=true output_scaled_${ff_scale}.mkv
