# OTT_FILES = grammar.ott rules.ott
# OTT_OPTS = -tex_show_meta false -tex_wrap false -picky_multiple_parses false -tex_suppress_ntr Q
# OTT_TEX = ott.tex

all: jflart-programming-with-destinations.pdf

# submission:
# 	touch no-editing-marks
# 	$(MAKE) clean
# 	$(MAKE) jflart-programming-with-destinations-submission.pdf jflart-programming-with-destinations-supplementary.pdf

# Manual steps to submit to Arxiv:
# - the no-editing-mark trick isn't used on Arxiv submission. Make
#   sure that the editing marks are deactivated. Or that there is no
#   mark left in the pdf.
arxiv:
	$(MAKE) clean
	$(MAKE) jflart-programming-with-destinations.pdf.tar.gz

arxiv-nix:
	nix-shell --pure --run "make arxiv"

# submission-nix:
# 	nix-shell --pure --run "make submission"

# .PHONY: submission submission-nix

clean:
	rm -f *.aux *.bbl *.ptb jflart*.pdf *.toc *.out *.run.xml
	rm -f *.log *.bcf *.fdb_latexmk *.fls *.blg
	rm -f jflart-programming-with-destinations.pdf
	rm -f jflart-programming-with-destinations.lhs
	rm -f jflart-programming-with-destinations.tar.gz
	rm -rf _minted-jflart-programming-with-destinations

# %.tex: %.mng $(OTT_FILES)
# 	ott $(OTT_OPTS) -tex_filter $< $@ $(OTT_FILES)

# $(OTT_TEX): $(OTT_FILES)
# 	ott $(OTT_OPTS) -o $@ $^

# jflart-programming-with-destinations-submission.pdf: jflart-programming-with-destinations.pdf
# 	pdftk $< cat 1-27 output temp.pdf
# 	pdftk $< dump_data_utf8 | pdftk temp.pdf update_info_utf8 - output $@
# 	rm -f temp.pdf

# jflart-programming-with-destinations-supplementary.pdf: jflart-programming-with-destinations.pdf
# 	pdftk $< cat 28-end output $@

jflart-programming-with-destinations.tar.gz: jflart-programming-with-destinations.tex jflart-programming-with-destinations.bbl jflart.cls
	tar -cvzf $@ $^

%.pdf %.bbl : %.tex bibliography.bib pygmentize_local hc.py jflart.cls schemas/*.tikz *.sty *.tikzstyles bench-charts.pdf
	cd $(dir $<) && latexmk $(notdir $*)

nix::
	nix-shell --pure --run make

continuous::
	ls jflart-programming-with-destinations.tex bibliography.bib pygmentize_local hc.py jflart.cls schemas/*.tikz *.sty *.tikzstyles bench-charts.pdf | entr make

continuous-nix:: nix
	nix-shell --pure --run "make continuous"

# .SECONDARY:
# Uncommenting the line above prevents deletion of temporary files, which can be helpful for debugging build problems
