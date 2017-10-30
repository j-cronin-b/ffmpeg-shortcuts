#! /bin/sh

# TODO: add description

if [ "${#}" != 1 ] ; then
	echo "Usage: ./`basename ${0}` <file>"
	exit 1
fi

ff_input="${1}"

## TODO: this is common for all the scripts
if [ ! -f "${ff_input}" ] ; then
	echo "Input file not found: '${ff_input}'" >&2
	exit 2
fi

## TODO: Audio is maybe not optimal.
## TODO: What about framerates?

set -x

exec ffmpeg -hide_banner -i "${ff_input}" -preset slower \
	-c:a aac -c:v libx264 -pix_fmt yuv420p final_`uuidgen`.mp4
