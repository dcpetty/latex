#!/usr/bin/env sh
# Delete all extraneous TeX files from all subdirectories
#
# Without any command-line arguments, cleans all files in exts list below '.'.
#
# Sample usage with command-line arguments:
#
#	% ./clean.sh -d dir pdf
#
# This uses -d to select top directory and addr 'pdf' to the list of exts.
#

dir="."
exts="aux bbl bcf blg cfg cut dvi glo gls gz hd idx ilg ind lof log lot out ps"
exts="${exts} run.xml thm tgz toc zip"

# Process command-line arguments.
for arg in $@; do
	case ${arg} in
	-d)
		shift
		dir="$1"
		shift
		;;
	*)
		exts="${exts} $1"
		shift
		;;
	esac
done

# Remove all files below ${dir} ending in any extension in ${exts}.
for ext in ${exts}; do
	echo \# .${ext}
	find ${dir} -print 2>&1 |grep "[.]${ext}$" |xargs -n 1 -I {} -t rm {}
done
