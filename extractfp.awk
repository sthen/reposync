#!/usr/bin/awk -f

/^#/ { next; }

$1 == "0" {
	if (url == "" || fp == "" || url == "-p")
		next;
	reset();
	next;
	}

$1 == "CR" { url = $2; next }
$1 == "SE" && substr($2, 0, 7) == "SHA256:" { fp = $2; type = "ECDSA"; dump(); next }
$1 == "S2" && substr($2, 0, 7) == "SHA256:" { fp = $2; type = "ED25519"; dump(); next }
$1 == "SM" && substr($2, 0, 7) == "SHA256:" { fp = $2; type = "MLDSA44-ED25519"; dump(); next }

function dump() {
	print url " " fp " " type
}

function reset() {
	url = ""
	fp = ""
	type = ""
}
