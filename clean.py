#!/usr/bin/env python3
#
# clean.py
#
# https://chatgpt.com/share/66eabd2d-ea28-8011-910a-39f79d347fbd
# Adapted from shell scripts w/ ChatGPT.
#
"""
Delete all extraneous TeX files from all subdirectories.

Without any command-line arguments, cleans all files in the patterns 
below the current directory ('.').

Sample usage with command-line arguments:

    % python3 clean.py -d dir pdf -v

This uses -d to select top directory 'dir', add '*.pdf' to the list of
patterns, and (with -v) echo all files matched by patterns.
"""

import os
import fnmatch
import argparse

def find_files(base_dir, patterns, verbose=False):
    """
    Search for files in a given directory matching the specified patterns.

    Args:
        base_dir (str): The base directory to start the search from.
        patterns (list): List of patterns (glob-style) to match files against.
        verbose (bool): If True, prints each pattern and its matched files.

    Returns:
        list: A sorted list of unique files that match the given patterns.
    """
    matches = dict()
    for root, dirs, files in os.walk(base_dir):
        for pattern in patterns:
            for filename in fnmatch.filter(files, pattern):
                file_path = os.path.join(root, filename)
                matches[pattern] = matches.get(pattern, list()) + [file_path]
    if verbose:
        for k, v in matches.items():
            print(f"# {k} \u2192 {v}:")
    return sorted(set(f for k, v in matches.items() for f in v))

def remove_file(filename, dry_run=False):
    """
    Remove a file or simulate the removal if dry-run is enabled.

    Args:
        filename (str): The path to the file to be removed.
        dry_run (bool): If True, only simulates the deletion by printing a message.
    """
    if dry_run:
        print(f"# rm {filename}")
    else:
        print(f"rm {filename}")
        os.remove(filename) # FILE REMOVAL

def main(patterns):
    """
    Parse command-line arguments, search for files, and handle their removal.

    Args:
        patterns (list): List of file patterns to search for.
    """
    parser = argparse.ArgumentParser(description='Delete extraneous TeX files from subdirectories.')
    parser.add_argument('-d', '--dir', default='.', help='Top directory to search (default: current directory).')
    parser.add_argument('-n', '--dry-run', action='store_true', help='Log file removal without actual file deletion.')
    parser.add_argument('-v', '--verbose', action='store_true', help='Print verbose output.')
    parser.add_argument('extension', nargs='*', help='File extensions to match (e.g., pdf).')

    args = parser.parse_args()
    base_dir = args.dir
    dry_run = args.dry_run
    verbose = args.verbose
    extensions = args.extension
    
    if not os.path.isdir(base_dir):
        print(f"Directory '{base_dir}' does not exist.")
        return

    # Add user-specified patterns
    for ext in extensions:
        patterns.append(f"*.{ext}")

    # Find files based on patterns
    filenames = find_files(base_dir, patterns, verbose)

    for filename in filenames:
        base_name = os.path.splitext(filename)[0]
        tex_file = f"{base_name}.tex"
        if filename.lower().endswith('.pdf') and not os.path.exists(tex_file):
            print(f"## {filename} has no TeX file...")
            continue
        remove_file(filename, dry_run)

if __name__ == "__main__":
    # Using splitlines to handle the patterns, each pattern on a new line
    patterns = [g for g in """
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
""".splitlines() if g ]
    
    main(patterns)
