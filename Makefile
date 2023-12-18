all: destination-passing-haskell.pdf

# Manual steps to submit to Arxiv:
# - the no-editing-mark trick isn't used on Arxiv submission. Make
#   sure that the editing marks are deactivated. Or that there is no
#   mark left in the pdf.
arxiv:
	$(MAKE) clean
	sed -i 's/\\usepackage{minted}/\\usepackage[finalizecache]{minted}/' destination-passing-haskell.tex
	$(MAKE) destination-passing-haskell.pdf
	sed -i 's/\\usepackage\[finalizecache\]{minted}/\\usepackage[frozencache]{minted}/' destination-passing-haskell.tex
	$(MAKE) destination-passing-haskell.tar.gz
	sed -i 's/\\usepackage\[frozencache\]{minted}/\\usepackage{minted}/' destination-passing-haskell.tex

destination-passing-haskell.tar.gz: destination-passing-haskell.tex destination-passing-haskell.bbl jflart.cls _minted-destination-passing-haskell schemas/*.tikz *.sty *.tikzstyles bench-charts.pdf
	tar -cvzf $@ $^

arxiv-nix:
	nix-shell --pure --run "make arxiv"

clean:
	rm -f *.aux *.bbl *.ptb destination-passing-haskell*.pdf *.toc *.out *.run.xml
	rm -f *.log *.bcf *.fdb_latexmk *.fls *.blg
	rm -f destination-passing-haskell.tar.gz
	rm -rf _minted-destination-passing-haskell

%.pdf %.bbl : %.tex bibliography.bib alpha-fr.bst pygmentize_local hc.py jflart.cls schemas/*.tikz *.sty *.tikzstyles bench-charts.pdf
	cd $(dir $<) && latexmk $(notdir $*)

nix::
	nix-shell --pure --run make

continuous::
	ls destination-passing-haskell.tex bibliography.bib alpha-fr.bst pygmentize_local hc.py jflart.cls schemas/*.tikz *.sty *.tikzstyles bench-charts.pdf | entr make

continuous-nix:: nix
	nix-shell --pure --run "make continuous"

# .SECONDARY:
# Uncommenting the line above prevents deletion of temporary files, which can be helpful for debugging build problems
