	/*
	 * Returns
	 *   a0 - comparison result, value like strcmp
	 *
	 * Parameters
	 *   a0 - string1
	 *   a1 - string2
	 *
	 * Clobbers
	 *   t0, t1
	 */

.global strcmp1	     # Allow other files to call this routine

strcmp1:	 
1:
	lbu	t0, 0(a0)
	lbu	t1, 0(a1)
	addi	a0, a0, 1
	addi	a1, a1, 1
	bne	t0, t1, 2f
	bnez	t0, 1b
	li	a0, 0
	ret
2:
	/*
	 * strcmp only needs to return (< 0, 0, > 0) values
	 * not necessarily -1, 0, +1
	 */
	sub	a0, t0, t1
	ret
	
