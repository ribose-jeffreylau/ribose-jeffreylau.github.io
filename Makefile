SHELL := bash

REGISTRY_YAML_OUTPUT_DIR ?= data

all: _documents $(CSD_OUTPUT_HTML) $(RELATON_INDEX_OUTPUT)

clean:
	rm -rf _site _documents
	rm -rf $(MN_ARTIFACTS)
	rm -rf _input/*.rxl _input/csd.yaml
	rm -rf $(BIB_OUTPUT_DIR)

_site: all
	bundle exec jekyll build

distclean: clean clean-csd

# Make collection YAML files into adoc files
_documents: $(REGISTRY_YAML_OUTPUT_DIR)
	mkdir -p $@; \
	for filename in $(REGISTRY_YAML_OUTPUT_DIR)/*.yaml; do \
		FN=$${filename##*/}; \
		$(MAKE) $@/$${FN//yaml/adoc}; \
	done

_documents/%.adoc: $(REGISTRY_YAML_OUTPUT_DIR)/%.yaml
	cp $< $@ && \
	echo "---" >> $@;

serve:
	pnpm run dev

.PHONY: bundle all serve clean clean-csd build-csd update update-modules
