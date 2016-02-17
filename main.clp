
; +----------------------------------+
; | Computer Clasifier               |
; |                                  |
; | for the 2015/2016 Knowledge base |
; | class at Sofia University        |
; +----------------------------------+
(printout t 
	(if (not (load functions.clp))
	then
		"Something went wrong with the functions file"
	else
		"[INFO] Functions file loaded successfully!") crlf)

(printout t
	(if (not (load rules.clp))
	then
		"Something went wrong with the rules file"
	else
		"[INFO] Rules file loaded successfully!") crlf)
