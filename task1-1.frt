g" Checks if first argument is integrally divisible by second argument."
: isDivisibleBy % not ; with-doc

g" Checks if a number is even (1) or odd (0). Consumes it."
: isEven 2 isDivisibleBy ; with-doc

g" Checks if a number is even (1) or odd (0). Does not consume it."
: isEven~ dup isEven ; with-doc

g" Squares a number, consuming it."
: sq dup * ; with-doc

g" Checks if a number is prime (1) or not (0). Does not consume it."
: isPrime~
	( check for numbers <=0 )
	dup 1 < if 0 exit then
	( check for trivial numbers )
	dup	1 = if 0 exit then
	dup 2 = if 1 exit then
	( check for even numbers )
	dup isEven if 0 exit then
	( main loop )
	>r 3
	repeat
		dup sq r@ <= if
			r@ over isDivisibleBy if
				drop r> 0 exit
			else
				2 + 0
			endif
		endif
	until
	drop r> 1
; with-doc

g" Checks if a number is prime (1) or not (0). Consumes it."
: isPrime isPrime~ swap drop ; with-doc

( : sieve for r@ isPrime~ if . cr else drop endif endfor ;)

g" Allocates one memory cell, returning its address."
: allocate-cell 8 allot ; with-doc

g" Saves value to a new cell, returning its address."
: save allocate-cell dup -rot ! ; with-doc
