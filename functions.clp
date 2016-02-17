; +----------------------------------+
; | Computer Clasifier - functions   |
; |                                  |
; | for the 2015/2016 Knowledge base |
; | class at Sofia University        |
; +----------------------------------+


(deffunction is-empty$ "Checks whether a multifield is empty"
    ($?list)
    (= 0 (length$ ?list)))

(deffunction between "Checks if `value` is in the (min, max] range"
    (?value ?min ?max)
    (and (<= ?value ?max)
         (> ?value ?min)))

(deffunction map$ "A hacky way of running map in a language with no first class citizen functions"
    (?func-name $?list)
    ;   [func-name] - Can be both the name of a single-parameter function
    ;                 or something that can be evaled
    ;        [list] - A multifield value
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


(deffunction assert-intensity "Asserts [?fact-name] with Low / Medium / High"
    (?fact-name ?value ?mid ?high)
    (if (< ?value ?mid) then 
        (bind ?intesity "Low"))
    (if (between ?value ?mid ?high) then 
        (bind ?intesity "Medium"))
    (if (>= ?value ?high) then 
        (bind ?intesity "High"))
    (eval (format nil "(assert (%s %s))" ?fact-name ?intesity)))

(deffunction capitalize "capitalizes the first letter of the first word in a string"
    (?value)
    (str-cat
        (upcase (sub-string 1 1 ?value)) 
        (sub-string 2 (length ?value) ?value)))

(deffunction quick-key "Creates a string that hints a quick key <-> [`name` -> `(N)ame`]"
    (?value)
    (str-cat 
        "(" (upcase (sub-string 1 1 ?value)) ")" 
        (sub-string 2 (length ?value) ?value)))

(deffunction ask-question "Asks the user a question and returs his input"
    (?question $?additional)
    (printout t (str-cat "[QUES] > " ?question " " (implode$ ?additional) ": "))
    (read))

(deffunction ask-question-choice "Asks a question - multiple choice answer"
    (?question $?choices)
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

(deffunction ask-question-number "Asks a question and expects a number as input"
    (?question)
    (bind ?answer (ask-question ?question "(number)"))
    (if (numberp ?answer) then
        ?answer else
        (printout t "[INFO] > Value must be a number" crlf)
        (ask-question-number ?question)))

(deffunction ask-question-int "Asks a question and expects an integer as input"
    (?question)
    (bind ?answer (ask-question ?question))
    (if (integerp ?answer) then
        ?answer else
        (printout t "[INFO] > Value must be an integer" crlf)
        (ask-question-int ?question)))

(deffunction ask-question-int-range "Asks a question and the input to be in (min, max]"
    (?question ?min ?max)
    (bind ?answer (ask-question-int (str-cat ?question " (" ?min " - " ?max ")")))
    (if (between ?answer ?min ?max) then
        ?answer else
        (printout t "[WARN] > Value must be between " ?min " and " ?max crlf)
        (ask-question-int-range ?question ?min ?max)))

(deffunction ask-question-yes-no "Asks a question and expects a yes/no response"
    (?question)
    (bind ?answer (lowcase (ask-question ?question "(yes/no)")))
    (if (not (member ?answer (create$ y yes n no)))
    then 
        (printout t "[WARN] > Answer must be (y)es or (n)o" crlf)
        (ask-question-yes-no ?question)
    else
        (integerp (member ?answer (create$ y yes)))))
