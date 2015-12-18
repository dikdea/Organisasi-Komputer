%include	'rataan.asm'
%include	'input_rata.asm'
%include	'ragamdiketahui.asm'
%include	'ragamdiketahui2.asm'
%include	'simpangandiketahui.asm'
%include	'simdiketahui.asm'
%include	'simpangandiketahui2.asm'
%include	'simdiketahui2.asm'
%include	'hitungsb.asm'
%include	'hitungsb2.asm'

extern printf
extern scanf

section .data 
	judul			db		'',10
	    			db		'*******************************************************	', 10
	    			db		'*              MENGHITUNG RATAAN POPULASI             *', 10
	    			db      '*                          PADA                       *', 10
	    			db      '*                  KASUS SATU POPULASI                *', 10
	    			db      '*-----------------------------------------------------*', 10
	    			db      '*                                                     *', 10
	    			db      '*                             Dea Ayu A.P   G64154051 *', 10
	    			db      '*                             Krisnawati S. G64154048 *', 10
        			db		'*******************************************************', 10
    masuk_pilihrata db      'Apakah perlu menghitung rataan dari sejumlah nilai ? (1/0) : ', 0
    masuk_pilihragam db		'Apakah ragam populasi diketahui ? (1/0)   : ', 0
    masuk_sbaku		db		'Masukkan nilai simpangan baku             : ', 0
    masuk_data      db      'Masukkan banyaknya nilai                  : ', 0
    masuk_nilai     db      'Masukkan nilainya                         : ', 0
    masuk_rata      db      'Masukkan nilai rata-ratanya               : ', 0
    masuk_ragam     db      'Masukkan nilai ragamnya                   : ', 0
    masuk_bnilai    db      'Masukkan banyaknya nilai (n)              : ', 0
    masuk_selang    db      'Masukkan selang kepercayaan (%)           : ', 0
    hasil_akhir1	db		'**Jadi kita percaya %.0f(%) pada selang %.3f sampai %.3f**', 10, 10, 0
    tabelz			db		'Inputkan nilai dari tabel z(%.3f)        : ', 0
    tabelt			db		'Inputkan nilai dari tabel t %.3f(%.0f)    : ', 0
    hasil_rata      db      'Rata-ratanya adalah                       : %.3f', 10, 0
    salah_pilih		db		'Inputan Anda Salah', 10, 10, 0
	forout_sb		db		'Hasil simpangan bakunya adalah            : %f', 10, 0
    forout_ragam	db		'Hasil ragamnya adalah		          : %f', 10, 0
    format_int      db      '%d', 0
    format_flt      db      '%f', 0
    nilai			dd		100.00
    bagi_nilai		dd		2.00
    kurangsatu		dd		1.00
    tigapuluh		dd		30.00
    
section .bss
    pilih      		 resd 3
    pilih_ragam 	 resd 3
    temp        	 resd 1024
    temp1       	 resd 1024  
    temp2       	 resd 1024  ; 
    banyakmin		 resd 1024  ;
    data        	 resd 1024
    jumlah      	 resd 1
    ragam       	 resd 1
    sbaku			 resd 1
    bnilai      	 resd 1
    selang      	 resq 1
    kurang_satu		 resq 3
    kurangselang 	 resq 1
    bagiselang 	 	 resq 1
    alfa		 	 resq 1
    akar_n			 resq 1
    bagi_akarn		 resq 1
    tabel_z			 resq 1
    tabel_t		     resq 1
    hasilakhir2	     resq 1
    selang1		     resq 1
    hasilakhir_kiri  resq 1
    hasilakhir_kanan resq 1
    rata2       	 resq 1
    rata1		     resq 1
    banyak           resd 1
    data2		     resq 2
    hasil_print	     resq 1
    jumlah_sb		 resq 1
    jumlah_ragam	 resq 1
    
section .text
    global main

main:  
	;fungsi ini untuk menampilkan judul projek dengan menggunakan fungsi printf
	push judul	
	call printf
	add esp, 4 ; karena push hanya sekali (1*4=4)
	
	;push judul1	
	;call printf	
	;add esp, 4
	
	;push judul2
	;call printf
	;add esp, 4
	
	;push judul3
	;call printf	
	;add esp, 4
	
	;fungsi ini untuk menghitung rata-rata
	;pilihan inputan ialah (1/0) <- ya atau tidak
	call rataan
    je diketahui_rata ;jika inputan sama dengan 0 (rataan tidak perlu dihitung)
					  ;maka loncat (jump) ke diketahui_rata
    
    mov eax, [pilih]
    mov ebx, 1
    cmp ebx, eax 	  
    je inputan_rata	  ;jika inputan sama dengan 1 (rataan perlu dihitung)
					  ;maka loncat (jump) ke inputan_lainnya
					  ;untuk menginputkan berapa banyak data yang ingin diratakan
					  ;dari sejumlah nilai
					  
    push salah_pilih
    call printf
    add esp, 4
    jmp exit		;jika inputan selain (1/0) maka program akan berhenti
					;dan menampilkan pesan salah pilih
	
inputan_rata:

	call input_rata		;terdapat proses untuk menghitung rataan dari sejumlah nilai
						;fungsi input_rata terdapat pada input_rata.asm
    jmp inputan_lainnya ;setelah selesai maka loncat (jump) ke fungsi selanjutnya
						;karena tidak perlu menginputkan rataan lagi pada instruksi yang dibawah
	
diketahui_rata:
    
    push masuk_rata		;rataan sudah diketahui
    call printf
    add esp, 4
    
    push rata2 ;langsung menginputkan nilai rata-ratanya
    push format_flt
    call scanf
    add esp, 8
    
kodingan:

	push masuk_pilihragam
    call printf				;fungsi ini untuk memunculkan pesan diketahui ragam atau tidak
    add esp, 4
    
    push pilih_ragam
    push format_int
    call scanf			;fungsi untuk memilih ragam (1/0) <- diketahi atau tidak
    add esp, 8
    
    mov eax, [pilih_ragam]
    mov ebx, 0
    cmp ebx, eax
	je simp_baku			;jika inputan sama dengan 0 (tidak diketahui ragam)
							;maka loncat (jump) ke simpangan baku (simp_baku)
	
	mov eax, [pilih_ragam]
    mov ebx, 1
    cmp ebx, eax
	je input_ragam			;jika inputan sama dengan 1 (diketahui ragam)
							;maka loncat (jump) ke input_ragam
							;untuk menginputkan nilai ragamnya
	
	push salah_pilih
    call printf			
    add esp, 4
    jmp exit		;jika inputan selain (1/0) maka program akan berhenti
					;dan menampilkan pesan salah pilih
    
input_ragam:

    push masuk_ragam
    call printf	;fungsi untuk memunculkan pesan memasukkan nilai ragam
    add esp, 4
    
    push ragam
    push format_flt ;fungsi untuk menginputkan nilai ragam
    call scanf
    add esp, 8
    jmp no_simpbaku	;fungsi untuk loncat ke no_simpbaku
					;karena nilai simpangan baku tidak diketahui
    
simp_baku:  
	push masuk_sbaku
	call printf		;fungsi untuk memunculkan pesan memasukkan simpangan_baku
	add esp, 4
	
	push sbaku
	push format_flt
	call scanf		;fungsi untuk menginputkan nilai simpangan baku
	add esp, 8
	
    push masuk_bnilai
    call printf		;fungsi untuk memunculkan pesan memasukkan banyaknya nilai (n)
    add esp, 4
    
    push bnilai
    push format_flt	;fungsi untuk menginputkan banyaknya nilai (n)
    call scanf
    add esp, 8
    
    push masuk_selang
    call printf ;fungsi untuk memunculkan pesan memasukkan nilai selang kepercayaan (%)
    add esp, 4
    
    push selang
    push format_flt	;fungsi untuk menginputkan nilai selang kepercayaan (%)
    call scanf
    add esp, 8
    
    fld dword[bnilai]
    fld dword[tigapuluh]
    fcomip			;fungsi untuk membandingkan (compare) banyaknya nilai (n) dengan 30
    jb simpanganbsr	;jika n > 30 maka loncat (jump) ke simpanganbsr
					;jika n <= 30 maka lanjut ke instruksi selanjutnya ke simpangankcl
   
simpangankcl:
	call simpangandiketahui2 ;fungsi ini dipanggil ketika n <= 30
							 ;cek di simpangandiketahui2.asm
	jmp exit				 ;jika proses sudah selesai maka keluar dari program

simpanganbsr:
	call simdiketahui2		 ;fungsi ini dipanggil ketika n  30
							 ;cek di simdiketahui2.asm
    jmp exit				 ;jika proses sudah selesai maka keluar dari program
    
no_simpbaku:

    push masuk_bnilai
    call printf		;fungsi untuk memunculkan pesan memasukkan banyaknya nilai (n)
    add esp, 4
    
    push bnilai
    push format_flt	;fungsi untuk menginputkan banyaknya nilai (n)
    call scanf
    add esp, 8
    
    push masuk_selang
    call printf ;fungsi untuk memunculkan pesan memasukkan nilai selang kepercayaan (%)
    add esp, 4
    
    push selang
    push format_flt	;fungsi untuk menginputkan nilai selang kepercayaan (%)
    call scanf
    add esp, 8

	call ragamdiketahui ;fungsi untuk menghitung nilai ragam
		
	jmp exit			;jika perhitungan sudah selesai dan output sudah keluar
						;maka proses akan berhenti

inputan_lainnya:
	push masuk_pilihragam
    call printf			;fungsi untuk memunculkan pesan memasukkan ragam (diketahui atau tidak)
    add esp, 4
    
    push pilih_ragam
    push format_int
    call scanf			;memilih apakah ragam diketahui atau tidak (1/0)
    add esp, 8
    
    mov eax, [pilih_ragam]
    mov ebx, 0
    cmp ebx, eax
	je simpangan_baku	;jika ragam tidak diketahui (0) maka loncat (jump) ke simpangan_baku
	
	mov eax, [pilih_ragam]
    mov ebx, 1
    cmp ebx, eax
	je inputan_ragam	;jika ragam diketahui (1) maka loncat (jump) ke inputan_ragam
	
	push salah_pilih
    call printf			
    add esp, 4
    jmp exit		;jika inputan selain (1/0) maka program akan berhenti
					;dan menampilkan pesan salah pilih
	
;inputan_ragam:

    ;push masuk_ragam
    ;call printf	;fungsi untuk memunculkan pesan memasukkan nilai ragam
    ;add esp, 4
    
    ;push ragam
    ;push format_flt 
    ;call scanf	;fungsi untuk menginputkan nilai ragam
    ;add esp, 8
    ;====kodingan tambahan
 ;   call hitungsb2
    ;====
  ;  jmp no_simpanganbaku ;loncat ke no_simpanganbaku karena nilai dari simpangan baku tidak diketahui
    
simpangan_baku: 
	;push masuk_sbaku
	;call printf	;fungsi untuk memunculkan pesan memasukkan nilai simpangan baku
	;add esp, 4
	
	;push sbaku
	;push format_flt
	;call scanf	;fungsi untuk memasukkan nilai dari simpangan baku
	;add esp, 8
	
	;====kodingan tambahan
    call hitungsb
    ;====
    push masuk_bnilai
    call printf	;fungsi untuk memunculkan pesan memasukkan banyaknya nilai (n)
    add esp, 4
    
    push bnilai
    push format_flt	
    call scanf	;fungsi untuk menginputkan banyaknya nilai (n)
    add esp, 8

    push masuk_selang
    call printf ;fungsi untuk memunculkan pesan memasukkan selang kepercayaan
    add esp, 4
    
    push selang
    push format_flt	
    call scanf	;fungsi untuk menginputkan nilai selang kepercayaan (%)
    add esp, 8
    
    fld dword[bnilai]
    fld dword[tigapuluh]
    fcomip	;fungsi untuk membandingkan (compare) bnilai dengan 30
    jb simpanganbesar ;jika nilai > 30 maka loncat (jump) ke simpanganbesar
					  ;jika nilai <= 30 maka lanjut ke instruksi selanjutnya
					  ;yaitu ke simpangankecil
   
simpangankecil:
	call simpangandiketahui ;fungsi untuk menghitung simpangan baku, n <= 30
	jmp exit				;jika perhitungan selesai maka akan keluar dari program

simpanganbesar:
	call simdiketahui		;fungsi untuk menghitung simpangan baku, n > 30
	jmp exit				;jika perhitungan selesai maka akan keluar dari program

inputan_ragam:
	
	call hitungsb2

    push masuk_bnilai
    call printf	;fungsi untuk memunculkan pesan memasukkan banyaknya nilai
    add esp, 4
    
    push bnilai
    push format_flt	;fungsi untuk menginputkan banyaknya nilai (n)
    call scanf
    add esp, 8

    push masuk_selang
    call printf ;fungsi untuk memunculkan pesan memasukkan selang kepercayaan (%)
    add esp, 4
    
    push selang
    push format_flt	;fungsi untuk menginputkan nilai selang kepercayaan (%)
    call scanf
    add esp, 8

	call ragamdiketahui2 ;fungsi untuk menghitung nilai dari ragam
	
    jmp exit	;jika perhitungan selesai maka akan keluar dari program

exit:
