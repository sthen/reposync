V !=	date +%Y%m%d

tar: reposync-$V.tar.gz

reposync-$V.tar.gz: reposync reposync.1 ssh_known_hosts Makefile
	mkdir reposync-$V
	cp reposync reposync.1 ssh_known_hosts reposync-$V/
	tar czf reposync-$V.tar.gz reposync-$V
	rm -r reposync-$V

ssh_known_hosts: /var/www/openbsd-www/build/mirrors.dat
	echo "# public keys match fingerprints supplied by mirror operators, recorded in" > ssh_known_hosts; \
	echo "# `what /var/www/openbsd-www/build/mirrors.dat | tail -1`" >> ssh_known_hosts
	genkeys >> ssh_known_hosts

upload: reposync-$V.tar.gz
	scp reposync-$V.tar.gz naiad:mirrors/
