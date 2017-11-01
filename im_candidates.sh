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

		out_orig="${kernel}_0_orig.${out_format}"
		out_norm="${kernel}_1_norm.${out_format}"
		out_gama="${kernel}_2_gama.${out_format}"
		out_enhc="${kernel}_3_enhc.${out_format}"
		out_eqlz="${kernel}_4_eqlz.${out_format}"

		convert "${im_input}" 				"${out_orig}" &
		convert "${im_input}" -normalize 		"${out_norm}" &
		convert "${im_input}" -auto-gamma 		"${out_gama}" &
		convert "${im_input}" -enhance 			"${out_enhc}" &
		convert "${im_input}" -equalize 		"${out_eqlz}" &

		wait && echo "File '${im_input}' processed." | sed -e "s/^/`date`	/"
	fi
done
