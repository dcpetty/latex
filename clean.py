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

    % python3 clean.py *.tex -e pdf -v

This specifies which '*.tex' files should have their intermediate files cleaned,
adds '*.pdf' to the list of patterns (with -e), and (with -v) echos all files
matched by patterns from https://www.toptal.com/developers/gitignore/api/latex.
"""

import os
import fnmatch
import ssl
import urllib.request
import argparse
import sys

def find_files_dir(base_dir, patterns, verbose=False):
    """
    Search for files in a given directory matching the specified patterns.

    Args:
        base_dir (str): The base directory to start the search from.
        patterns (list): List of patterns (glob-style) to match files against.
        verbose (bool): If True, prints each pattern and its matched files.

    Returns:
        list: A sorted list of unique files that match the given patterns.
    """
    # TODO: removed -d option, so find_files_dir is not used
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

def find_files_tex(tex_files, patterns, verbose=False):
    """
    Search for files matching the specified patterns with the same head as the files
    in the tex_files .TEX files list.

    Args:
        tex_files (list): List of .TEX files.
        patterns (list): List of patterns (glob-style) to match files against.
        verbose (bool): If True, prints each pattern and its matched files.

    Returns:
        list: A sorted list of unique files matching the given patterns for tex_files.
    """
    matches = dict()
    for pathname in tex_files:
        path, name = os.path.split(os.path.realpath(pathname))
        head, tail = os.path.splitext(name)
        assert tail.lower() == '.tex', f"{pathname} not .TEX"
        files = fnmatch.filter(os.listdir(path), f"{head}.*")
        for pattern in patterns:
            for filename in fnmatch.filter(files, pattern):
                file_path = os.path.join(path, filename)
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

def get_patterns(uri='https://www.toptal.com/developers/gitignore/api/latex'):
    """
    Read LaTeX toptal.com .gitignore glob extensions.

    Args:
        uri (str): URI

    Returns:
        list: A list of LaTeX toptal.com .gitignore glob extensions
    """
    headers = { "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" }
    try:
        request = urllib.request.Request(uri, headers=headers)  # create request w/ User-Agent
        context = ssl._create_unverified_context()              # create unverified SSL context
        with urllib.request.urlopen(request, context=context) as response:
            lines = [ line for line in response.read().decode("utf-8").splitlines()
                if line and not line.startswith('#') ]
    except Exception as e:
        print(f"An error occurred: '{e}'")
        lines = list()
    return lines

def main(args, patterns):
    """
    Parse command-line arguments, search for files, and handle their removal.

    Args:
        patterns (list): List of file patterns to search for.
    """
    parser = argparse.ArgumentParser(description='Delete extraneous TeX files from subdirectories.')
    # TODO: removed -d option in favor of .TEX files
    # parser.add_argument('-d', '--dir', default='.', help='Top directory to search (default: current directory).')
    parser.add_argument('-e', '--ext', action='append', help='Extension(s) to add to .gitignore extension list.')
    parser.add_argument('-n', '--dry-run', action='store_true', help='Log file removal without actual file deletion.')
    parser.add_argument('-v', '--verbose', action='store_true', help='Print verbose output.')
    parser.add_argument('files', nargs='*', help='.TEX files to clean.')

    args = parser.parse_args(args)
    # base_dir = args.dir
    extensions = args.ext if args.ext else list()
    dry_run = args.dry_run
    verbose = args.verbose
    files = args.files
    
    # if not os.path.isdir(base_dir):
    #     print(f"Directory '{base_dir}' does not exist.")
    #     return

    # Add user-specified patterns
    for ext in extensions:
        patterns.append(f"*.{ext}")

    # Find files based on patterns
    filenames = find_files_tex(files, patterns, verbose)

    for filename in filenames:
        base_name = os.path.splitext(filename)[0]
        tex_file = f"{base_name}.tex"
        if filename.lower().endswith('.pdf') and not os.path.exists(tex_file):
            print(f"## {filename} has no TeX file...")
            continue
        remove_file(filename, dry_run)

if __name__ == "__main__":
    is_idle, is_pycharm, is_jupyter = (
        'idlelib' in sys.modules,
        int(os.getenv('PYCHARM', 0)),
        '__file__' not in globals()
        )
    if is_idle or is_pycharm or is_jupyter:
        main([ '-n', '-v', '-e', 'pdf',
               'doc/math/math-tex-example.tex',
               'doc/math/license-plates-example.tex',
               'foo.tex', ], get_patterns())
    else:
        # https://stackoverflow.com/a/76997871/17467335 re: sys.argv[1: ]
        main(sys.argv[1: ], get_patterns())
