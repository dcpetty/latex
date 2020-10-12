#!/usr/bin/env sh
# Delete all extraneous TeX files from all subdirectories
for ext in aux bbl blg gz idx ilg ind log out toc
do
	echo \# .${ext}
	find . -print |grep [.]${ext}$ |xargs -n 1 -I {} -t rm {}
done
