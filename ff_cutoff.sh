#! /bin/sh

# TODO: add description

if [ "${#}" != 3 ] ; then
	echo "Usage: ./`basename ${0}` <HH:MM:SS> <duration> <file>"
	exit 1
fi

ff_seek="${1}"
ff_duration="${2}"
ff_input="${3}"

## TODO: this is common for all the scripts
if [ ! -f "${ff_input}" ] ; then
	echo "Input file not found: '${ff_input}'" >&2
	exit 2
fi

set -x

exec ffmpeg -hide_banner -ss "${ff_seek}" -t "${ff_duration}" -i "${ff_input}" \
	-c:a copy -c:v copy output_fragment_${ff_seek}_${ff_duration}.mkv
