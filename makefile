tmp = /tmp/wvr.sh
SSH_HOST = wvr
WWW_DIR = /var/www/html

all:
	rm -r out 2>/dev/null ||:
	cp -rf src out

copy: all
	rm -r ${tmp} 2>/dev/null ||:
	cp -r src ${tmp}

view: copy
	${BROWSER} ${tmp}/index.html &

push: all
	openrsync -avlprt --del out/ ${SSH_HOST}:${WWW_DIR}
	ssh ${SSH_HOST} chmod -R 0755 ${WWW_DIR} ${WWW_DIR}/res
