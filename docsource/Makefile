THIS_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

SPHINXOPTS    :=
SPHINXBUILD   := sphinx-build
SPHINXPROJ    := Quakestarter
SOURCEDIR     := .
BUILDDIR      := _build
COPYDIR       := $(THIS_DIR)/../quakestarter_html

UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
SEDSEPARATOR =
SEDIGNORECASE = 'I'
else
SEDSEPARATOR = ''
SEDIGNORECASE =
endif

COPYDIR_BASE := $(notdir $(COPYDIR))

.PHONY: html copydocs clean copyclean

html:
	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS)

$(BUILDDIR)/html: html

copydocs: $(BUILDDIR)/html
	@rm -rf "$(COPYDIR)"
	@mkdir -p "$(COPYDIR)"
	@cp -r "$(BUILDDIR)/html/"* "$(COPYDIR)/"
	@rm -f "$(COPYDIR)/objects.inv"
	@mv "$(COPYDIR)/quakestarter_readme.html" "$(COPYDIR)/../"
	@sed -i ${SEDSEPARATOR} \
		-e 's/<head>/<head><base href="$(COPYDIR_BASE)\/">/${SEDIGNORECASE}' \
		"$(COPYDIR)/../quakestarter_readme.html"
	@sed -i ${SEDSEPARATOR} \
		-e 's/href="#"/href="..\/quakestarter_readme.html#"/${SEDIGNORECASE}' \
		"$(COPYDIR)/../quakestarter_readme.html"
	@sed -i ${SEDSEPARATOR} \
		-e 's/quakestarter_readme/..\/quakestarter_readme/g' \
		"$(COPYDIR)/"*/*.html
	@sed -i ${SEDSEPARATOR} \
		-e 's/quakestarter_readme/..\/quakestarter_readme/g' \
		"$(COPYDIR)/"search*

clean:
	@$(SPHINXBUILD) -M clean "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS)

copyclean:
	@rm -rf "$(COPYDIR)/../quakestarter_readme.html" "$(COPYDIR)"
