
input_rata:

    push masuk_data 
    call printf
    add esp, 4
    
    push jumlah
    push format_int ;fungsi untuk memasukkan banyaknya nilai yang ingin dirata-ratakan
    call scanf
    add esp, 8
    
    mov eax, [jumlah]
    fild dword [jumlah] ;fungsi untuk mengkonversi dari integer ke float
    fstp dword [banyak]	;fungsi ini dibuat karena jumlah angka yang ingin di ratakan integer
						;sedangkan inputan angkanya float
						;maka harus mengkoversi ke float agar hasilnya float juga
    mov ebx, 0
    
    push masuk_nilai
    call printf
    add esp, 4
    
;rata2    
loopinput:   
    push temp
    push format_flt
    call scanf		;fungsi ini untuk menginputkan sejumlah angka yang ingin dirata-ratakan 
    add esp, 8
    push dword[temp]
    pop dword[data+4*ebx]
    fld dword[data+4*ebx]
    fld dword[temp1]
    fadd					;fungsi ini untuk menambahkan angka saat proses looping
							;jika sudah selesai maka akan dibagi dengan jumlah inputan_lainnya
							;lihat proses pembagian dibawah (fdiv)
							
    fstp dword[temp1]
    inc ebx
    cmp ebx, [jumlah]
    jl loopinput	;terdapat fungsi looping sampai angkanya berjumlah sama dengan yang diinputkan
					;jika belum sama maka akan loncat (jump) ke loopinput
					;jika sudah maka akan lanjut ke instruksi selanjutnya
    
    
    fld dword[temp1]
    fld dword[banyak]
    fdiv				;fungsi ini untuk membagi angka dari inputan awal
    fstp dword[temp1]	;hasil dari pembagian itu disimpan pada temp1
    fld dword[temp1]
    fstp qword[rata1]
    
;rata2
    push dword[rata1+4]
    push dword[rata1]
    push hasil_rata
    call printf		;fungsi ini untuk mencetak hasil rataan
    add esp, 12
	ret
