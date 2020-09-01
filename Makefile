SHELL := /bin/bash
DEST := /home/lenni/www/blog/

deploy: build
	rsync -rC \
		-e "ssh" --rsync-path="sudo rsync" \
		`pwd`/_site/ \
		lenni@leonard.io:${DEST}
	ssh lenni@leonard.io 'sudo chown www-data:www-data -R ${DEST}'

build:
	jekyll build
