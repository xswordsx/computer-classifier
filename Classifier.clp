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

(deffunction map$ (?func-name $?list)
	(if (is-empty$ ?list)
		then
		(create$)
		else
		(if (= 1 (length ?list)) then
			(eval (str-cat "(" ?func-name " " (nth 1 ?list) ")"))
			else
		(create$ 
			(eval (str-cat "(" ?func-name " " (nth 1 ?list) ")"))
			(map$ ?func-name (subseq$ ?list 2 (length$ ?list)))))))

; --- Assertion helper ---
(deffunction assert-intensity (?fact-name ?value ?mid ?high)
	(if (< ?value ?mid) then 
		(bind ?intesity "Low"))
	(if (between ?value ?mid ?high) then 
		(bind ?intesity "Medium"))
	(if (>= ?value ?high) then 
		(bind ?intesity "High"))
	(eval (format nil "(assert (%s %s))" ?fact-name ?intesity)))

; --- String functions ---------------------
(deffunction capitalize (?value)
	(str-cat
		(upcase (sub-string 1 1 ?value)) 
		(sub-string 2 (length ?value) ?value)))

(deffunction quick-key (?value)
	(str-cat 
		"(" (upcase (sub-string 1 1 ?value)) ")" 
		(sub-string 2 (length ?value) ?value)))
; --- String functions ---------------------

; Checks if `value` is between `min` and `max`
(deffunction between (?value ?min ?max)
	(and (<= ?value ?max)
		 (> ?value ?min)))

; Asks the user a question and returs his input (optional arguments)
(deffunction ask-question (?question $?additional)
	(printout t (str-cat "[QUES] > " ?question " " (implode$ ?additional) ": "))
	(read))

(deffunction ask-question-choice (?question $?choices)
	(bind ?answer (ask-question ?question (map$ quick-key ?choices)))
	(bind ?index (member 
		(lowcase (sub-string 1 1 ?answer))
		(map$ "sub-string 1 1" (map$ "lowcase" ?choices))))
	(if (numberp ?index)
		then
		(capitalize (nth ?index ?choices))
		else
		(printout t "[WARN] > " ?answer " is not a valid answer." crlf)
		(ask-question-choice ?question $?choices)))

(deffunction ask-question-number (?question)
	(bind ?answer (ask-question ?question "(number)"))
	(if (numberp ?answer) then
		?answer else
		(printout t "[INFO] > Value must be a number" crlf)
		(ask-question-number ?question)))

; Asks the user for an integer
(deffunction ask-question-int (?question)
	(bind ?answer (ask-question ?question))
	(if (integerp ?answer) then
		?answer else
		(printout t "[INFO] > Value must be an integer" crlf)
		(ask-question-int ?question)))

; Asks the user for an integer in a range
(deffunction ask-question-int-range (?question ?min ?max)
	(bind ?answer (ask-question-int (str-cat ?question " (" ?min " - " ?max ")")))
	(if (between ?answer ?min ?max) then
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

; +----------------------------------+
; | Helper functions - END           |
; +----------------------------------+


(defrule assert-machine-type
	=>
	(bind ?answer
		(ask-question-choice "What's the machine type?"
			"laptop" "desktop" "rack"))
	(assert (machine-type (capitalize ?answer))))

(defrule assert-cpu-frequency
	=>
	(bind ?answer
		(ask-question-int-range "What's the CPU frequency? (MHz)" 1 6000))
	(if (> 3000 ?answer) then
		(assert (frequency High))
	else
		(if (>1500 ?answer) then
			(assert (frequency Medium))
		else
			(assert (frequency Slow)))))

(defrule assert-cpu-count
	=>
	(assert cpu-count (ask-question-int-range "What's the CPU count?" 1 64)))

(defrule assert-ram
	=>
	(bind ?answer
		(ask-question-int-range "How much RAM do you have (MB)?" 1 256000))
	)