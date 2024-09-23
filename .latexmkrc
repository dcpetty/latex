# TODO: this does not seem to work to remove these files on latexmk clean
push(@clean_exts, qr/^.*\.aux$/);
push(@clean_exts, qr/^.*\.lof$/);
push(@clean_exts, qr/^.*\.log$/);
push(@clean_exts, qr/^.*\.lot$/);
push(@clean_exts, qr/^.*\.fls$/);
push(@clean_exts, qr/^.*\.out$/);
push(@clean_exts, qr/^.*\.toc$/);
push(@clean_exts, qr/^.*\.fmt$/);
push(@clean_exts, qr/^.*\.fot$/);
push(@clean_exts, qr/^.*\.cb$/);
push(@clean_exts, qr/^.*\.cb2$/);
push(@clean_exts, qr/^\..*\.lb$/);
push(@clean_exts, qr/^.*\.dvi$/);
push(@clean_exts, qr/^.*\.xdv$/);
push(@clean_exts, qr/^\.pdf$/);
push(@clean_exts, qr/^.*\.bbl$/);
push(@clean_exts, qr/^.*\.bcf$/);
push(@clean_exts, qr/^.*\.blg$/);
push(@clean_exts, qr/^.*\-blx\.aux$/);
push(@clean_exts, qr/^.*\-blx\.bib$/);
push(@clean_exts, qr/^.*\.run\.xml$/);
push(@clean_exts, qr/^.*\.fdb_latexmk$/);
push(@clean_exts, qr/^.*\.synctex$/);
push(@clean_exts, qr/^.*\.synctex\(busy\)$/);
push(@clean_exts, qr/^.*\.synctex\.gz$/);
push(@clean_exts, qr/^.*\.synctex\.gz\(busy\)$/);
push(@clean_exts, qr/^.*\.pdfsync$/);
push(@clean_exts, qr/^latex\.out\/$/);
push(@clean_exts, qr/^.*\.alg$/);
push(@clean_exts, qr/^.*\.loa$/);
push(@clean_exts, qr/^acs\-.*\.bib$/);
push(@clean_exts, qr/^.*\.thm$/);
push(@clean_exts, qr/^.*\.nav$/);
push(@clean_exts, qr/^.*\.pre$/);
push(@clean_exts, qr/^.*\.snm$/);
push(@clean_exts, qr/^.*\.vrb$/);
push(@clean_exts, qr/^.*\.soc$/);
push(@clean_exts, qr/^.*\.cut$/);
push(@clean_exts, qr/^.*\.cpt$/);
push(@clean_exts, qr/^.*\.spl$/);
push(@clean_exts, qr/^.*\.ent$/);
push(@clean_exts, qr/^.*\.lox$/);
push(@clean_exts, qr/^.*\.mf$/);
push(@clean_exts, qr/^.*\.mp$/);
push(@clean_exts, qr/^.*\.t[1-9]$/);
push(@clean_exts, qr/^.*\.t[1-9][0-9]$/);
push(@clean_exts, qr/^.*\.tfm$/);
push(@clean_exts, qr/^.*\.end$/);
push(@clean_exts, qr/^.*\..end$/);
push(@clean_exts, qr/^.*\.[1-9]$/);
push(@clean_exts, qr/^.*\.[1-9][0-9]$/);
push(@clean_exts, qr/^.*\.[1-9][0-9][0-9]$/);
push(@clean_exts, qr/^.*\.[1-9]R$/);
push(@clean_exts, qr/^.*\.[1-9][0-9]R$/);
push(@clean_exts, qr/^.*\.[1-9][0-9][0-9]R$/);
push(@clean_exts, qr/^.*\.eledsec[1-9]$/);
push(@clean_exts, qr/^.*\.eledsec[1-9]R$/);
push(@clean_exts, qr/^.*\.eledsec[1-9][0-9]$/);
push(@clean_exts, qr/^.*\.eledsec[1-9][0-9]R$/);
push(@clean_exts, qr/^.*\.eledsec[1-9][0-9][0-9]$/);
push(@clean_exts, qr/^.*\.eledsec[1-9][0-9][0-9]R$/);
push(@clean_exts, qr/^.*\.acn$/);
push(@clean_exts, qr/^.*\.acr$/);
push(@clean_exts, qr/^.*\.glg$/);
push(@clean_exts, qr/^.*\.glo$/);
push(@clean_exts, qr/^.*\.gls$/);
push(@clean_exts, qr/^.*\.glsdefs$/);
push(@clean_exts, qr/^.*\.lzo$/);
push(@clean_exts, qr/^.*\.lzs$/);
push(@clean_exts, qr/^.*\.slg$/);
push(@clean_exts, qr/^.*\.slo$/);
push(@clean_exts, qr/^.*\.sls$/);
push(@clean_exts, qr/^.*\.gnuplot$/);
push(@clean_exts, qr/^.*\.table$/);
push(@clean_exts, qr/^.*\.gaux$/);
push(@clean_exts, qr/^.*\.glog$/);
push(@clean_exts, qr/^.*\.gtex$/);
push(@clean_exts, qr/^.*\.4ct$/);
push(@clean_exts, qr/^.*\.4tc$/);
push(@clean_exts, qr/^.*\.idv$/);
push(@clean_exts, qr/^.*\.lg$/);
push(@clean_exts, qr/^.*\.trc$/);
push(@clean_exts, qr/^.*\.xref$/);
push(@clean_exts, qr/^.*\.brf$/);
push(@clean_exts, qr/^.*\-concordance\.tex$/);
push(@clean_exts, qr/^.*\-tikzDictionary$/);
push(@clean_exts, qr/^.*\.lol$/);
push(@clean_exts, qr/^.*\.ltjruby$/);
push(@clean_exts, qr/^.*\.idx$/);
push(@clean_exts, qr/^.*\.ilg$/);
push(@clean_exts, qr/^.*\.ind$/);
push(@clean_exts, qr/^.*\.maf$/);
push(@clean_exts, qr/^.*\.mlf$/);
push(@clean_exts, qr/^.*\.mlt$/);
push(@clean_exts, qr/^_minted.*$/);
push(@clean_exts, qr/^.*\.pyg$/);
push(@clean_exts, qr/^.*\.mw$/);
push(@clean_exts, qr/^.*\.newpax$/);
push(@clean_exts, qr/^.*\.nlg$/);
push(@clean_exts, qr/^.*\.nlo$/);
push(@clean_exts, qr/^.*\.nls$/);
push(@clean_exts, qr/^.*\.pax$/);
push(@clean_exts, qr/^.*\.pdfpc$/);
push(@clean_exts, qr/^.*\.sagetex\.sage$/);
push(@clean_exts, qr/^.*\.sagetex\.py$/);
push(@clean_exts, qr/^.*\.sagetex\.scmd$/);
push(@clean_exts, qr/^.*\.wrt$/);
push(@clean_exts, qr/^svg\-inkscape\/$/);
push(@clean_exts, qr/^.*\.sout$/);
push(@clean_exts, qr/^.*\.sympy$/);
push(@clean_exts, qr/^sympy\-plots\-for\-.*\.tex\/$/);
push(@clean_exts, qr/^.*\.upa$/);
push(@clean_exts, qr/^.*\.upb$/);
push(@clean_exts, qr/^.*\.pytxcode$/);
push(@clean_exts, qr/^pythontex\-files\-.*\/$/);
push(@clean_exts, qr/^.*\.listing$/);
push(@clean_exts, qr/^.*\.loe$/);
push(@clean_exts, qr/^.*\.dpth$/);
push(@clean_exts, qr/^.*\.md5$/);
push(@clean_exts, qr/^.*\.auxlock$/);
push(@clean_exts, qr/^.*\.ptc$/);
push(@clean_exts, qr/^.*\.tdo$/);
push(@clean_exts, qr/^.*\.hst$/);
push(@clean_exts, qr/^.*\.ver$/);
push(@clean_exts, qr/^.*\.lod$/);
push(@clean_exts, qr/^.*\.xcp$/);
push(@clean_exts, qr/^.*\.xmpi$/);
push(@clean_exts, qr/^.*\.xdy$/);
push(@clean_exts, qr/^.*\.xyc$/);
push(@clean_exts, qr/^.*\.xyd$/);
push(@clean_exts, qr/^.*\.ttt$/);
push(@clean_exts, qr/^.*\.fff$/);
push(@clean_exts, qr/^TSWLatexianTemp.*$/);
push(@clean_exts, qr/^.*\.bak$/);
push(@clean_exts, qr/^.*\.sav$/);
push(@clean_exts, qr/^\.texpadtmp$/);
push(@clean_exts, qr/^.*\.lyx\~$/);
push(@clean_exts, qr/^.*\.backup$/);
push(@clean_exts, qr/^\..*\.swp$/);
push(@clean_exts, qr/^.*\.tps$/);
push(@clean_exts, qr/^\.\/auto\/.*$/);
push(@clean_exts, qr/^.*\.el$/);
push(@clean_exts, qr/^.*\-tags\.tex$/);
push(@clean_exts, qr/^.*\.sta$/);
push(@clean_exts, qr/^.*\.lpz$/);
push(@clean_exts, qr/^.*\.xwm$/);
push(@clean_exts, qr/^.*\.vtc$/);
push(@clean_exts, qr/^.*\.glstex$/);
# print(@clean_exts);
sub clean_hook {
    print "Cleaning: $_
" foreach @clean_ext;
}
