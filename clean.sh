#!/usr/bin/env sh
#
# Delete all extraneous TeX files from all subdirectories.
#
# Without any command-line arguments, cleans all files in globs list 
# below '.'.
#
# Sample usage with command-line arguments:
#
#	% ./clean.sh -d dir pdf -v
#
# This uses -d to select top directory 'dir', add '*.pdf' to list of
# globs, and (with -v) echo all globs including those that don't match.
#

dir="."

# LaTeX globs from .gitignore file.

read -r -d '' globs << EOM
_minted*
.*.lb
.*.swp
./auto/*
.pdf
.texpadtmp
*-blx.aux
*-blx.bib
*-concordance.tex
*-converted-to.*
*-gnuplottex-*
*-tags.tex
*-tikzDictionary
*.?end
*.[1-9]
*.[1-9][0-9]
*.[1-9][0-9][0-9]
*.[1-9][0-9][0-9]R
*.[1-9][0-9]R
*.[1-9]R
*.4ct
*.4tc
*.acn
*.acr
*.alg
*.aux
*.auxlock
*.backup
*.bak
*.bbl
*.bcf
*.blg
*.brf
*.cb
*.cb2
*.cpt
*.cut
*.dpth
*.dvi
*.el
*.eledsec[1-9]
*.eledsec[1-9][0-9]
*.eledsec[1-9][0-9][0-9]
*.eledsec[1-9][0-9][0-9]R
*.eledsec[1-9][0-9]R
*.eledsec[1-9]R
*.end
*.ent
*.fdb_latexmk
*.fff
*.fls
*.fmt
*.fot
*.gaux
*.glg
*.glo
*.glog
*.gls
*.glsdefs
*.glstex
*.gnuplot
*.gtex
*.hst
*.idv
*.idx
*.ilg
*.ind
*.lg
*.listing
*.loa
*.lod
*.loe
*.lof
*.log
*.lol
*.lot
*.lox
*.lpz
*.ltjruby
*.lyx~
*.lzo
*.lzs
*.maf
*.md5
*.mf
*.mlf
*.mlt
*.mp
*.mtc[0-9]*
*.mw
*.nav
*.newpax
*.nlg
*.nlo
*.nls
*.out
*.pax
*.pdfpc
*.pdfsync
*.pre
*.ptc
*.pyg
*.pytxcode
*.run.xml
*.sagetex.py
*.sagetex.sage
*.sagetex.scmd
*.sav
*.slf[0-9]*
*.slg
*.slo
*.sls
*.slt[0-9]*
*.snm
*.soc
*.sout
*.spl
*.sta
*.stc[0-9]*
*.sympy
*.synctex
*.synctex.gz
*.synctex.gz(busy)
*.synctex(busy)
*.t[1-9]
*.t[1-9][0-9]
*.table
*.tdo
*.tfm
*.thm
*.toc
*.tps
*.trc
*.ttt
*.upa
*.upb
*.ver
*.vrb
*.vtc
*.wrt
*.xcp
*.xdv
*.xdy
*.xmpi
*.xref
*.xwm
*.xyc
*.xyd
*~[0-9]*
acs-*.bib
latex.out/
pythontex-files-*/
svg-inkscape/
sympy-plots-for-*.tex/
TSWLatexianTemp*
EOM

# Process command-line arguments.
while ((${#})); do
	case $1 in
	-d)
		shift
		dir="$1"
		;;
	-v)
		verbose=true
		;;
	*)
		globs="${globs} *.$1"
		;;
	esac
	shift
done

# Check whether ${dir} exists.
if [ ! -d "${dir}" ]; then
  echo "Directory \"${dir}\" does not exist."
  exit 1
fi

# Remove all files below ${dir} matching any glob in ${globs}.
for glob in ${globs}; do
	[ -n "${verbose}" ] && echo \# ${glob}
	find ${dir} -name "${glob}" -print 2>&1 \
		|xargs -n 1 -I {} -t rm -rf {}
done
