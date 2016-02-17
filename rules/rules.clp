
; +----------------------------------+
; | Computer Clasifier               |
; |                                  |
; | for the 2015/2016 Knowledge base |
; | class at Sofia University        |
; +----------------------------------+

(defrule assert-machine-type
	=>
	(assert (machine-type (eval (capitalize 
		(ask-question-choice "What's the machine type?"	"laptop" "desktop" "rack"))))))

(defrule assert-cpu-frequency
	=>
	(assert-intensity "frequency"
		1500 3000
		(ask-question-int-range "What's the CPU frequency? (MHz)" 1 6000)))

(defrule assert-cpu-count
	=>
	(assert-intensity "cpu-count"
		2 4
		(ask-question-int-range "What's the CPU count?" 1 64)))

(defrule assert-ram
	=>
	(assert-intensity "ram"
		2000 8000
		(ask-question-int-range "How much RAM do you have (MB)?" 1 256000)))

(defrule assert-hdd-size
	=>
	(assert-intensity "hdd-size"
		250 1000
		(ask-question-int-range "What is the HDD Capacity (GB)?" 10 16000)))

(defrule assert-hdd-speed
	=>
	(assert (hdd-speed (eval (capitalize
		(ask-question-choice "What's the HDD speed?" "slow" "medium" "fast"))))))

(defrule assert-gpu
	=>
	(assert (gpu (eval (capitalize
		(ask-question-choice "What's the GPU class?" "low" "medium" "high"))))))

(defrule assert-monitor-size
	=>
	(assert-intensity "monitor-size"
		17 23
		(ask-question-int-range "What is the monitor size (inches)?" 1 64)))

(defrule assert-cooling 
	=>
	(assert (cooling (eval (capitalize
		(ask-question-choice "What's the cooling?" "normal" "good" "extra"))))))

; Extra stats

(defrule assert-extra-usb
	=>
	(if (ask-question-yes-no "Does the machine have a USB port?")
	then
		(assert (extra usb))))

(defrule assert-extra-hdmi
	=>
	(if (ask-question-yes-no "Does the machine have an HDMI port?")
	then
	(assert (extra hdmi))))

(defrule assert-extra-vga
	=>
	(if (ask-question-yes-no "Does the machine have a VGA output?")
	then
	(assert (extra vga))))

(defrule assert-extra-dvd
	=>
	(if (ask-question-yes-no "Does the machine have a CD/DVD reader?")
	then
	(assert (extra dvd))))
