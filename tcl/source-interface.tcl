package require sqlite3
package require uuid

sqlite3 db girama

wm title . "Inserir Fonte"
grid [ttk::frame .c -padding "3 3 12 12"] -column 0 -row 0 -sticky nwes
grid columnconfigure . 0 -weight 1; grid rowconfigure . 0 -weight 1

grid [ttk::label .c.languagelbl -text "Língua"] -column 1 -row 1 -sticky w
grid [ttk::label .c.titlelbl -text "Título"] -column 1 -row 2 -sticky w
grid [ttk::label .c.authorlbl -text "Autor"] -column 1 -row 3 -sticky w
grid [ttk::label .c.yearlbl -text "Ano"] -column 3 -row 3 -sticky w
grid [ttk::label .c.license -text "Licença"] -column 1 -row 4 -sticky w

grid [ttk::entry .c.languagetxt -width 70 -textvariable languagevar] -column 2 -row 1 -sticky we
grid [ttk::entry .c.titletxt -width 70 -textvariable titlevar] -column 2 -row 2 -sticky we
grid [ttk::entry .c.authortxt -width 70  -textvariable authorvar] -column 2 -row 3 -sticky we
grid [ttk::entry .c.yeartxt -textvariable yearvar] -column 4 -row 3 -sticky we
grid [ttk::entry .c.licensetxt -width 70 -textvariable licensevar] -column 2 -row 4 -sticky we

grid [ttk::button .c.languagesearchbtn -text "Procurar..." -command search] -column 4 -row 1 -sticky we
grid [ttk::button .c.okbtn -text "Salvar" -command save] -column 4 -row 4 -sticky we


grid [ttk::label .c.test] -column 4 -row 2 -sticky we

foreach w [winfo children .c] {grid configure $w -padx 5 -pady 5}


proc search {} {
    set r [db eval "SELECT * FROM language WHERE name LIKE '$::languagevar'"]
    .c.test configure -text [lindex $r 0]
}

proc save {} {
    set uid [::uuid::uuid generate]
    set glottocode [.c.test cget -text]
    db eval "INSERT INTO ocun_source VALUES('$uid','$glottocode','$::titlevar','$::authorvar','$::yearvar','$::licensevar')"

}
