default: test

test: house.lisp 
	@clisp house.test.lisp

test-utils: functions.lisp
	@clisp functions.test.lisp
