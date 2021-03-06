/* SPDX-License-Identifier: BSD-2-Clause */
/*
 * Copyright (c) 2019, Linaro Limited
 */

#include <asm.S>

#if defined(CFG_UNWIND)
#define UNWIND(...) __VA_ARGS__
#else
#define UNWIND(...)
#endif

/*
 * This function is the bottom of the user call stack. Mark it as such so that
 * the unwinding code won't try to go further down.
 * We need an assembly wrapper because Clang does not accept asm(".cantunwind")
 * in a C function:
 *
 *  user_ta_header.c:44:6: error: .fnstart must precede .cantunwind directive
 *          asm(".cantunwind");
 *              ^
 */
FUNC __ta_entry, :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	bl	__ta_entry_c
	/*
	 * The nop makes the stack unwinding more clear (without it,
	 * symbolize.py may show a file/line outside the function).
	 */
	nop
UNWIND(	.fnend)
END_FUNC __ta_entry
