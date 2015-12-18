rataan: ;untuk memilih menghitung rataan atau tidak
    
    push pilih
    push format_int ;pilihan ingin menghitung rata atau tidak (1/0)
    call scanf
    add esp, 8
    
    mov eax, [pilih]
    mov ebx, 0
    cmp ebx, eax 
    
	ret
