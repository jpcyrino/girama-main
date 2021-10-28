package require sqlite3

set langs [open "langs.csv" r]
fconfigure $langs -encoding utf-8
sqlite3 db girama

while { [gets $langs line] >= 0 } {
	set data [split $line "#"]
	db eval "INSERT INTO language (glottocode, name) VALUES('[lindex $data 0]','[lindex $data 1]')"
	}

close $langs
db close


