#!/usr/bin/env sh
# Delete all extraneous TeX files from all subdirectories

dir="."
exts="aux bbl blg gz idx ilg ind log out toc"

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

for ext in ${exts}; do
	echo \# .${ext}
	find ${dir} -print |grep "[.]${ext}$" |xargs -n 1 -I {} -t rm {}
done
