SSH_HOST = wvr
WWW_DIR = /var/www/html

all:
	mkdir -p out
	./bin/mkpage.sh src/index.md
	cp -rf res out/

clean:
	rm -r out wiki 2>/dev/null ||:

view: all
	cp -rf out ~/tmp/
	brws ~/tmp/out/index.html

wiki: all
	./bin/mkwiki.sh

push:
	rsync -rvhtu --progress --delete out/ ${SSH_HOST}:${WWW_DIR}
	ssh ${SSH_HOST} chmod -R 0755 ${WWW_DIR} ${WWW_DIR}/res
