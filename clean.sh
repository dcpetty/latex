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
exts="aux bbl blg gz idx ilg ind log out toc"

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
	find ${dir} -print |grep "[.]${ext}$" |xargs -n 1 -I {} -t rm {}
done
