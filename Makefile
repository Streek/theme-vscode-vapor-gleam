.PHONY: help install check package publish-only clean

help:
	@printf '%s\n' 'make install       Install locked dependencies' 'make check         Validate metadata and package a VSIX' 'make package       Create a local VSIX without publishing' 'make publish-only  Interactively publish to the VS Code Marketplace' 'make clean         Remove local VSIX artifacts'

install:
	npm ci

check:
	npm run check

package:
	npm run package

publish-only:
	npm run publish:only

clean:
	rm -f ./*.vsix
