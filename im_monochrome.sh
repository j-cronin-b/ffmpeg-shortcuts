#! /bin/sh

out_format="png"

if [ "${#}" -lt 1 ] ; then
	echo "Usage: `basename ${0}` <file> ..."
	exit 1
fi

for im_input in "${@}" ; do
	if [ ! -f "${im_input}" ] ; then
		echo "Input file not found: '${im_input}'" >&2
	else
		kernel=`echo "${im_input}" | rev | cut -f 2- -d . | rev`
		convert "${im_input}" -monochrome "${kernel}_mono.${out_format}"
		echo "File '${im_input}' processed." | sed -e "s/^/`date`	/"
	fi
done

