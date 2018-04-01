g" Prints a Collatz sequence for positive input number"
: collatz
	( check for numbers <=0 )
	dup 1 < if exit endif
	repeat
		dup . ."  "
		dup 1 = if drop exit endif
		isEven~ if
			2 /
		else
			3 * 1 +
		endif
		0
	until
; with-doc

