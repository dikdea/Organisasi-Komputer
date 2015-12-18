hitungsb2:

	;ragam
	mov ebx, 0
	
loop_rg:
		fld dword[data+4*ebx]
		fld dword[temp1]
		fsub
		fstp dword[data2+4*ebx]
		inc ebx
		cmp ebx, [jumlah]
		jl loop_rg
		
		mov ebx, 0

loop_rg2:
		fld dword[data2+4*ebx]
		fld dword[data2+4*ebx]
		fmul
		fstp dword[data2+4*ebx]
		inc ebx
		cmp ebx, [jumlah]
		jl loop_rg2
		
		mov ebx, 0

loop_rg3:
		fld dword[data2+4*ebx]
		fld dword[temp2]
		fadd
		fstp dword[temp2]
		inc ebx
		cmp ebx, [jumlah]
		jl loop_rg3
		
		;fld dword[banyak]
		;fld dword[kurangsatu]
		;fsub
		;fstp dword[banyakmin]
		
		fld dword[temp2]
		fld dword[banyak]
		fdiv
		fstp dword[temp2]
		fld dword[temp2]
		fsqrt
		fstp qword[jumlah_ragam]
		;endragam
		
		;nilai ragam
		push dword[jumlah_ragam+4]
		push dword[jumlah_ragam]
		push forout_ragam
		call printf
		add esp, 12
		
		ret
