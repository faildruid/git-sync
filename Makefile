HELM ?= helm
CHART_DIR ?= .

.PHONY: lint test template package

lint:
	$(HELM) lint $(CHART_DIR)

test:
	$(HELM) unittest -q $(CHART_DIR)

template:
	$(HELM) template test $(CHART_DIR) > /tmp/gitsync-manifests.yaml

package:
	mkdir -p dist
	$(HELM) package $(CHART_DIR) -d dist
