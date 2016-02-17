
; +---------------------------------------+
; | Computer Clasifier - Evaluations file |
; |                                       |
; | for the 2015/2016 Knowledge base      |
; | class at Sofia University             |
; +---------------------------------------+
(defrule evaluate-for-docs-and-browsing
	(or (machine-type Laptop)
		(machine-type Desktop))
	(or (frequency Low)
		(frequency Medium))
	(or (cpu-count Low)
		(cpu-count Medium))
	(or (ram Low))
	(not (hdd-size Low))
	(extra usb)
	=>
	(printout t "The computer is suitable for Docs and Internet" crlf)
	(assert (suits-type DocsAndInternet)))

(defrule evaluate-for-movies
	(or (machine-type Laptop)
		(machine-type Desktop))
	(or (cpu-count Low)
		(cpu-count Medium))
	(or (ram Low)
		(ram Medium))
	(or (hdd-size Low)
		(hdd-size Medium))
	(not (gpu Low))
	(monitor Large)
	(extra usb)
	(extra hdmi)
	(extra dvd)
	=>
	(printout t "The computer is suitable for Movies" crlf)
	(assert (suits-type Movies)))

(defrule evaluate-for-business
	(machine-type Laptop)
	(or (frequency  Medium)
		(frequency  High))
	(not (cpu-count Low))
	(not (ram Low))
	(not (hdd-speed Slow))
	(not (gpu Low))
	(extra usb)
	(extra dvd)
	=>
	(printout t "The computer is suitable for Business" crlf)
	(assert (suits-type Business)))

(defrule evaluate-for-gaming
	(or (machine-type Laptop)
		(machine-type Desktop))
	(frequency  High)
	(cpu-count High)
	(ram High)
	(hdd-size High)
	(hdd-speed Fast)
	(gpu High)
	(monitor Large)
	(cooling Extra)
	(extra usb)
	(extra vga)
	(extra hdmi)
	(extra dvd)
	=>
	(printout t "The computer is suitable for Gaming" crlf)
	(assert (suits-type Gaming)))

(defrule evaluate-for-server
	(or (machine-type Rack)
		(machine-type Desktop))
	(frequency  High)
	(cpu-count High)
	(ram High)
	(hdd-size High)
	(hdd-speed Fast)
	(cooling Extra)
	(extra usb)
	=>
	(printout t "The computer is suitable Server" crlf)
	(assert (suits-type Server)))

(defrule no-type-summary "This is called last if no computer type was fount"
	(declare (salience -1))
	(not (suits-type DocsAndInternet))
	(not (suits-type Movies))
	(not (suits-type Business))
	(not (suits-type Gaming))
	(not (suits-type Server))
	=>
	(printout t "The computer is no suitable for a particular type ot operations." crlf))
