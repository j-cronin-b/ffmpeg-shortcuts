#! /bin/sh

out_format="png"
grayscale_methods="Rec601Luma Rec601Luminance Rec709Luma Rec709Luminance Brightness Lightness Average MS RMS"

if [ "${#}" -lt 1 ] ; then
	echo "Usage: `basename ${0}` <file> ..."
	exit 1
fi

for im_input in "${@}" ; do
	if [ ! -f "${im_input}" ] ; then
		echo "Input file not found: '${im_input}'" >&2
	else
		kernel=`echo "${im_input}" | rev | cut -f 2- -d . | rev`
		for grayscale_method in ${grayscale_methods} ; do
			convert "${im_input}" -grayscale "${grayscale_method}" \
				"${kernel}_6_gray_${grayscale_method}.${out_format}" &
		done
		wait && echo "File '${im_input}' processed." | sed -e "s/^/`date`	/"
	fi
done

