#! /bin/sh

# TODO: add description

if [ "${#}" != 1 ] ; then
	echo "Usage: `basename ${0}` <file>"
	exit 1
fi

im_input="${1}"

## TODO: this is common for all the scripts
if [ ! -f "${im_input}" ] ; then
	echo "Input file not found: '${im_input}'" >&2
	exit 2
fi

kernel=`echo "${im_input}" | rev | cut -f 2- -d . | rev`

out_format="png"

    out_orig="${kernel}_1_orig.${out_format}"
      out_ng="${kernel}_2_ng.${out_format}"
   out_ng_eq="${kernel}_3_ng_eq.${out_format}"
   out_ng_en="${kernel}_4_ng_en.${out_format}"
   out_ng_gs="${kernel}_5_ng_gs.${out_format}"
out_ng_gs_eq="${kernel}_6_ng_gs_nq.${out_format}"
 out_ng_mono="${kernel}_7_ng_mono.${out_format}"

convert "${im_input}" "${out_orig}"
convert "${out_orig}" -normalize -auto-gamma "${out_ng}"
convert "${out_ng}" -equalize "${out_ng_eq}"
convert "${out_ng}" -colorspace gray "${out_ng_gs}"
convert "${out_ng}" -enhance "${out_ng_en}"
convert "${out_ng_gs}" -equalize "${out_ng_gs_eq}"
convert "${out_ng}" -monochrome "${out_ng_mono}"
