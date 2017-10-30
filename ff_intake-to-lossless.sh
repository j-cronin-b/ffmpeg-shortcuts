#! /bin/sh

# TODO: add description

if [ "${#}" -lt 2 ] ; then
	echo "Usage: ./`basename ${0}` fast|small file" >&2
	exit 1
fi

# TODO: a common check if a given parameter has one of expected values.
# TODO: a common policy for output file names.
# TODO: enable H.264 as well as H.265 encoding
# TODO: enable lossless audio codec alongside with 'copy' codec. 

ff_preset="ultrafast"
if [ "${1}" = "small" ] ; then
	ff_preset="veryslow"
fi

ff_input="${2}"

# TODO: this is common for all the scripts
if [ ! -f "${ff_input}" ] ; then
	echo "Usage: Input file not found: '${ff_input}'" >&2
	exit 2
fi

exec ffmpeg -hide_banner -i "${ff_input}" -c:a copy 				\
	-c:v libx265 -preset "${ff_preset}" -x265-params lossless=true 	\
	output_lossless_h265.mkv
