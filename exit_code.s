.global _start
.balign 4
_start:
	mov w0, #7
	mov w16, #1
	svc #0x80
