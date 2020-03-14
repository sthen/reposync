#!/usr/bin/awk -f

/^#/ { next; }

$1 == "0" {
	if (url == "" || fp == "" || url == "-p")
		next;
	dump();
	reset();
	next;
	}

$1 == "CR" { url = $2; next }
$1 == "SE" && substr($2, 0, 7) == "SHA256:" && fp == "" { fp = $2; type = "ECDSA"; next }
$1 == "S2" && substr($2, 0, 7) == "SHA256:" { fp = $2; type = "ED25519"; next }

function dump() {
	print url " " fp " " type
}

function reset() {
	url = ""
	fp = ""
	type = ""
}

END {
	dump();		# don't forget the last guy!
}
