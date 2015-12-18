simdiketahui2:

	fld dword[nilai] ;mengambil nilai = 100
	fld dword[selang] ;mengambil nilai selang sebelumnya
	fsub				;fungsi untuk mengurangkan nilai selang dengan 100
	fstp qword[kurangselang] ;hasilnya akan disimpan di [kurangselang]

	fld qword[kurangselang] ;mengambil nilai pada [kurangselang]
	fld dword[bagi_nilai]   ;mengambil nilai di bagi_nilai = 2
	fdiv					;fungsi untuk membagi hasil pengurangan selang dengan 2
	fstp qword[bagiselang]	;hasilnya akan disimpan di [bagiselang]
	
	fld qword[bagiselang]	;mengambil nilai di [bagiselang]
	fld dword[nilai]		;mengambil nilai = 100
	fdiv					;fungsi untuk membagi nilai pembagian selang dengan 100
							;pembagian ini dilakukan karena masih dalam bentuk persen
	fstp qword[alfa]		;hasil disimpan di [alfa]
	
	fld dword[bnilai] 		;mengambil nilai di [bnilai]
	fsqrt					;fungsi untuk mengakarkan nilai di [bnilai]
	fstp qword[akar_n]		;hasil disimpan di [akar_n]
	
	fld dword[sbaku] 		;mengambil nilai simpangan baku di [sbaku]
	fld qword[akar_n]		;mengambil nilai akar n di [akar_n]
	fdiv					;fungsi untuk membagi simpangan baku dengan akar n
	fstp qword[bagi_akarn]	;hasilnya disimpan di [bagi_akarn]

	push dword[alfa+4] 
	push dword[alfa]
    push tabelz
    call printf ;fungsi untuk mencetak nilai dari tabelz
				;dan mengambil nilai di [alfa]
				;yang hasilnya akan dicetak di tabelt
    add esp, 12	;push sebanyak 3 kali jadi (3*4=12)
    
    push tabel_z
    push format_flt
    call scanf	;fungsi untuk menginputkan nilai dari tabelz yang telah ditentukan
    add esp, 8	;push sebanyak 2 (4*2=8)

	fld qword[bagi_akarn] ;mengambil nilai di [bagi_akarn]
						  ;merupakan hasil bagi sbaku dengan akar n
	fld dword[tabel_z]    ;mengambil nilai di [tabel_z]
	fmul				  ;fungsi untuk mengalikan [bagi_akarn] dengan [tabel_z]
	fstp qword[hasilakhir2] ;hasilnya akan disimpan di [hasilakhir2]

	;hasil akhir sebelah kanan jika rata2 ditambahkan
	fld dword[rata2]	   ;mengambil nilai di [rata2]
	fld qword[hasilakhir2] ;mengambil nilai di [hasilakhir2]
	fadd				   ;fungsi untuk menambahkan rata-rata dengan hasil dari perhitungan yang disimpan di [hasilakhir2]
	fstp qword[hasilakhir_kanan] ;hasilnya disimpan di [hasilakhir_kanan]
	
	push dword[hasilakhir_kanan+4]
	push dword[hasilakhir_kanan]
	
	fld dword[rata2]		;mengambil nilai di [rata2]
	fld qword[hasilakhir2]	;mengambil nilai di [hasilakhir2]
	fsub					;fungsi untuk mengurangkan rata-rata dengan hasil dari perhitungan yang disimpan di [hasilakhir2]
	fstp qword[hasilakhir_kiri] ;hasilnya disimpan di [hasilakhir_kiri]

	push dword[hasilakhir_kiri+4]
	push dword[hasilakhir_kiri]
	
	fld dword[selang]
	fstp qword[selang1]
	push dword[selang1+4]
	push dword[selang1]

	push hasil_akhir1
	call printf		;fungsi untuk mencetak kesimpulan dari sejumlah perhitungan
	add esp, 28		;push sebanyak 7 (7*4=28)	
	ret
