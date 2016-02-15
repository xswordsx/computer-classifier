; +----------------------------------+
; | Computer Clasifier               |
; |                                  |
; | for the 2015/2016 Knowledge base |
; | class at Sofia University        |
; +----------------------------------+

; +----------------------------------+
; | Helper functions - START         |
; +----------------------------------+

; Checks whether a multifield is empty
(deffunction is-empty$ ($?list) (= 0 (length$ ?list)))

; Checks if `value` is between `min` and `max`
(deffunction between (?value ?min ?max)
	(and (<= ?value ?max)
		 (>= ?value ?min)))

; Asks the user a question and returs his input (optional arguments)
(deffunction ask-question (?question $?additional)
	(bind ?plus (nth$ 1 (create$ ?additional "")))
	(printout t (format nil "[QUES] > %s %s: " ?question ?plus))
	(read)))

(deffunction ask-question-number (?question)
	(bind ?answer (ask-question ?question "(number)"))
	(if (numberp ?answer) then
		?answer else
		(printout t "[INFO] > Value must be a number" crlf)
		(ask-question-number ?question)))

; Asks the user for an integer
(deffunction ask-question-int (?question)
	(bind ?answer (ask-question ?question (create$)))
	(if (integerp ?answer) then
		?answer else
		(printout t "[INFO] > Value must be an integer" crlf)
		(ask-question-int ?question)))

; Asks the user for an integer in a range
(deffunction ask-question-int-range (?question ?min ?max)
	(bind ?answer (ask-question-int ?question (format nil "(%d - %d)" ?min ?max)))
	(if (between ?answer ?min ?max)) then
		?answer else
		(printout t "[WARN] > Value must be between " ?min " and " ?max crlf)
		(ask-question-int-range ?question ?min ?max)))

(deffunction ask-question-yes-no (?question)
	(bind ?answer (lowcase (ask-question ?question "(yes/no)")))
	(if (not (member ?answer (create$ y yes n no)))
		then 
		(printout t "[WARN] > Answer must be y(es) or n(o)" crlf)
		(ask-question-yes-no ?question)
		else
		(integerp (member ?answer (create$ y yes)))))