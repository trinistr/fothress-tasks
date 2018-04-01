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
	dup 1 < if 0 exit endif
	( check for trivial numbers )
	dup	1 = if 0 exit endif
	dup 2 = if 1 exit endif
	( check for even numbers )
	dup isEven if 0 exit endif
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

g" Checks if a number is prime, saves result to a new cell and returns its address."
: isPrimeSave isPrime save ;

g" Increment by one."
: ++ 1 + ; with-doc

g" Decrement by one."
: -- 1 - ; with-doc

g" Copies string from first argument to second. Returns address of ending null character."
: strcopy
	over count 0 do
		>r dup c@ r@ c!
		++ r> ++
	loop
	swap drop 0 over c!
; with-doc

g" Concatenates two strings and returns pointer to new string."
: concat 
	( Count needed bytes )
	2dup count swap count 1 + +
	heap-alloc dup >r
	rot swap strcopy strcopy drop r>
; with-doc
