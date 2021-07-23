NAME=nullius
TRANSLATION_NAME=$(NAME)-ja
TRANSLATION_VERSION=$(shell jq -rM .version < info.json)

dist:
	git archive --prefix $(TRANSLATION_NAME)_$(TRANSLATION_VERSION)/ HEAD -o $(TRANSLATION_NAME)_$(TRANSLATION_VERSION).zip
clean:
	-rm -v $(TRANSLATION_NAME)_*.zip

.latest-version:
	NAME="$(NAME)" ./tools/latest-version > $@

.latest-downloaded: .latest-version
	./tools/download-latest
	touch $@

update-locale-en: .latest-downloaded
	./tools/update-locale-en
