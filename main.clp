
; +----------------------------------+
; | Computer Clasifier               |
; |                                  |
; | for the 2015/2016 Knowledge base |
; | class at Sofia University        |
; +----------------------------------+

; Clean system
(reset)

(load functions.clp)
(load rules/rules.clp)
 
(printout t crlf crlf "[INFO] Entering Question mode... " crlf crlf)

(run)

(printout t crlf crlf)

(load rules/evaluations.clp)

(printout t crlf crlf "[INFO] Entering Evaluation mode... " crlf crlf)

(run)
(printout t crlf crlf "[INFO] Entering Evaluation mode... " crlf crlf)
(load rules/advantages.clp)
(printout t crlf crlf "Let's talk about the advantages of the system..." crlf crlf)
(run)
