hitungsb:

	;simpangan baku
	mov ebx, 0
	
loop_sb:
		fld dword[data+4*ebx]
		fld dword[temp1]
		fsub
		fstp dword[data2+4*ebx]
		inc ebx
		cmp ebx, [jumlah]
		jl loop_sb
		
		mov ebx, 0

loop_sb2:
		fld dword[data2+4*ebx]
		fld dword[data2+4*ebx]
		fmul
		fstp dword[data2+4*ebx]
		inc ebx
		cmp ebx, [jumlah]
		jl loop_sb2
		
		mov ebx, 0

loop_sb3:
		fld dword[data2+4*ebx]
		fld dword[temp2]
		fadd
		fstp dword[temp2]
		inc ebx
		cmp ebx, [jumlah]
		jl loop_sb3
		
		fld dword[banyak]
		fld dword[kurangsatu]
		fsub
		fstp dword[banyakmin]
		
		fld dword[temp2]
		fld dword[banyakmin]
		fdiv
		fstp dword[temp2]
		fld dword[temp2]
		fsqrt
		fstp qword[jumlah_sb]
		;end simpangan baku
		
		;nilai simpangan baku
		push dword[jumlah_sb+4]
		push dword[jumlah_sb]
		push forout_sb
		call printf
		add esp, 12
		
		ret
