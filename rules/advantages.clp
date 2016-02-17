
; +--------------------------------------+
; | Computer Clasifier - Advantages file |
; |                                      |
; | for the 2015/2016 Knowledge base     |
; | class at Sofia University            |
; +--------------------------------------+
(defrule frequency-advantage
	(suits-type ?type)
	(frequency High)
	(test (eq ?type Movies))
	=>
	(assert (pros ?type frequency)))

(defrule hddcapacity-advantage
	(suits-type ?type)
	(hddcapacity High)
	(test (eq ?type Business))
	=>
	(assert (pros ?type hddcapacity)))

(defrule hddspeed-advantage
	(suits-type ?type)
	(hddspeed Fast)
	(test (eq ?type DocsAndInternet))
	=>
	(assert (pros ?type hddspeed)))

(defrule monitor-advantage
	(suits-type ?type)
	(monitor Large)
	(or (test (eq ?type DocsAndInternet))
		(test (eq ?type Business))
	)
	=>
	(assert (pros ?type monitor)))

(defrule cooling-advantage
	(suits-type ?type)

	(or (and(test (eq ?type DocsAndInternet))
			(test (eq cooling Good)))
		(and(test (eq ?type Movies))
			(test (eq cooling Good)))
		(and(test (eq ?type Business))
			(test (eq cooling Good)))
	)
	=>
	(assert (pros ?type monitor)))

(defrule extras-advantage
	(suits-type ?type)
	(extra ?extra)
	(or (and (test (eq ?type DocsAndInternet))
			 (test (neq ?extra usb)))
		(and (test (eq ?type Movies))
			 (test (neq ?extra hdmi))
			 (test (neq ?extra usb))
			 (test (neq ?extra dvd)))
		(and (test (eq ?type Business))
			 (test (neq ?extra usb))
			 (test (neq ?extra dvd)))
		(and (test (eq ?type Server))
			 (test (neq ?extra dvd)))
	)
	=>
	(assert (pros ?type ?extra)))

(defrule pros-summary
	(pros ?type ?pros)
	=>
	(printout t "As a " ?type " computer, its ")
	(printout t ?pros)
	(printout t " is considered a pro." crlf))
