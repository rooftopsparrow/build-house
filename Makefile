default: test

test: house.lisp 
	@clisp house.test.lisp

test-utils: utils.lisp
	@clisp utils.test.lisp
