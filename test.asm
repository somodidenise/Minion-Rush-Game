.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern malloc: proc
extern memset: proc
extern printf: proc
extern rand: proc

includelib canvas.lib
extern BeginDrawing: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date

window_title DB "Minion Rush",0

area_width EQU 400
area_height EQU 600
area DD 0

arg1 EQU 8
arg2 EQU 12
arg3 EQU 16
arg4 EQU 20

counter DD 0
switch DD 0
scor DD 0

symbol_width EQU 10
symbol_height EQU 20

random_block DD 241, 81, 161, 241, 321, 1, 81, 161, 241
random_number DD 0
random_number1 DD 0
random_number2 DD 0
random_number3 DD 0
nr1 DD 0
nr2 DD 775543

; in block are marginile 19, 7
minion_width EQU 40
minion_height EQU 45
pos_minionx DD 179
current_block_minion DD 161

; in block are marginile 17, 14
onebanana_width EQU 45
onebanana_height EQU 30
pos_onebananax DD 0
pos_onebananay DD 14
x1 DD 0
y1 DD 1

; in block are marginile 17, 12
brick_width EQU 45
brick_height EQU 35
pos_brickx DD 0
pos_bricky DD 12
x DD 0
y DD 1
pos_brickx3 DD 0
pos_bricky3 DD 12
x3 DD 0
y3 DD 1

; in block are marginile 17, 7
bananas_width EQU 45
bananas_height EQU 45
pos_bananasx DD 0
pos_bananasy DD 7
x2 DD 0
y2 DD 1

button_x EQU 177
button_y EQU 247
button_size EQU 45

include digits.inc
include letters.inc
include Minion.inc
include onebanana.inc
include brick.inc
include bananas.inc
include greenblock.inc

.code

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; macro care genereaza un numar random
generate_number macro x  
   mov eax, nr1
   mul nr2
   inc nr2
   mov nr1, eax
   xor edx, edx
   mov ecx, 10
   div ecx
   mov x, edx
endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; functie care afiseaza minionu
minion_func proc
	push ebp
	mov ebp, esp
	pusha

draw_picture:
	lea esi, minion
	mov ecx, minion_height
bucla_picture_linii:
	mov edi, [ebp+arg1] ; pointer la matricea de pixeli
	mov eax, [ebp+arg3] ; pointer la coord y
	add eax, minion_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg2] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, minion_width
bucla_picture_coloane:
	mov edx, dword ptr [esi]
	mov dword ptr [edi], edx
	add esi, 4
	add edi, 4
	loop bucla_picture_coloane
	pop ecx
	loop bucla_picture_linii
	
	popa
	mov esp, ebp
	pop ebp
	ret	
minion_func endp

make_minion macro drawArea, x, y
	push y
	push x
	push drawArea
	call minion_func
	add esp, 12
endm 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; functie care afiseaza caramida
brick_func proc
	push ebp
	mov ebp, esp
	pusha

draw_picture:
	lea esi, brick
	mov ecx, brick_height
bucla_picture_linii:
	mov edi, [ebp+arg1] ; pointer la matricea de pixeli
	mov eax, [ebp+arg3] ; pointer la coord y
	add eax, brick_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg2] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, brick_width
bucla_picture_coloane:
	mov edx, dword ptr [esi]
	mov dword ptr [edi], edx
	add esi, 4
	add edi, 4
	loop bucla_picture_coloane
	pop ecx
	loop bucla_picture_linii
	
	popa
	mov esp, ebp
	pop ebp
	ret	
brick_func endp

make_brick macro drawArea, x, y
	push y
	push x
	push drawArea
	call brick_func
	add esp, 12
endm 
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; functie care afiseaza o banana
onebanana_func proc
	push ebp
	mov ebp, esp
	pusha

draw_picture:
	lea esi, onebanana
	mov ecx, onebanana_height
bucla_picture_linii:
	mov edi, [ebp+arg1] ; pointer la matricea de pixeli
	mov eax, [ebp+arg3] ; pointer la coord y
	add eax, onebanana_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg2] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, onebanana_width
bucla_picture_coloane:
	mov edx, dword ptr [esi]
	mov dword ptr [edi], edx
	add esi, 4
	add edi, 4
	loop bucla_picture_coloane
	pop ecx
	loop bucla_picture_linii
	
	popa
	mov esp, ebp
	pop ebp
	ret	
onebanana_func endp

make_onebanana macro drawArea, x, y
	push y
	push x
	push drawArea
	call onebanana_func
	add esp, 12
endm 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; functie care afiseaza banane
bananas_func proc
	push ebp
	mov ebp, esp
	pusha

draw_picture:
	lea esi, bananas
	mov ecx, bananas_height
bucla_picture_linii:
	mov edi, [ebp+arg1] ; pointer la matricea de pixeli
	mov eax, [ebp+arg3] ; pointer la coord y
	add eax, bananas_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg2] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, bananas_width
bucla_picture_coloane:
	mov edx, dword ptr [esi]
	mov dword ptr [edi], edx
	add esi, 4
	add edi, 4
	loop bucla_picture_coloane
	pop ecx
	loop bucla_picture_linii
	
	popa
	mov esp, ebp
	pop ebp
	ret	
bananas_func endp

make_bananas macro drawArea, x, y
	push y
	push x
	push drawArea
	call bananas_func
	add esp, 12
endm 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; bloc verde
block_func proc
	push ebp
	mov ebp, esp
	pusha

draw_picture:
	lea esi, block
	mov ecx, 59
bucla_picture_linii:
	mov edi, [ebp+arg1] ; pointer la matricea de pixeli
	mov eax, [ebp+arg3] ; pointer la coord y
	add eax, 59
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg2] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, 79
bucla_picture_coloane:
	mov edx, dword ptr [esi]
	mov dword ptr [edi], edx
	add esi, 4
	add edi, 4
	loop bucla_picture_coloane
	pop ecx
	loop bucla_picture_linii
	
	popa
	mov esp, ebp
	pop ebp
	ret	
block_func endp

make_green_block macro drawArea, x, y
	push y
	push x
	push drawArea
	call block_func
	add esp, 12
endm 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	text	
make_text proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	cmp eax, 'A'
	jl make_digit
	cmp eax, 'Z'
	jg make_digit
	sub eax, 'A'
	lea esi, letters
	jmp draw_text
make_digit:
	cmp eax, '0'
	jl make_space
	cmp eax, '9'
	jg make_space
	sub eax, '0'
	lea esi, digits
	jmp draw_text
make_space:	
	mov eax, 26 ; de la 0 pana la 25 sunt litere, 26 e space
	lea esi, letters
	
draw_text:
	mov ebx, symbol_width
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	mov dword ptr [edi], 0
	jmp simbol_pixel_next
simbol_pixel_alb:
	mov dword ptr [edi], 0FFFFFFh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_text endp

make_text_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text
	add esp, 16
endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; linii
line_horizontal macro x, y, len, color
local bucla_line
	mov eax, y
	mov ebx, area_width
	mul ebx
	add eax, x
	shl eax, 2
	add eax, area
	mov ecx, len
bucla_line:
	mov dword ptr[eax], color
	add eax, 4
	loop bucla_line
endm

line_vertical macro x, y, len, color
local bucla_line
	mov eax, y
	mov ebx, area_width
	mul ebx
	add eax, x
	shl eax, 2
	add eax, area
	mov ecx, len
bucla_line:
	mov dword ptr[eax], color
	add eax, area_width * 4
	loop bucla_line
endm

; functia de desenare - se apeleaza la fiecare click
; sau la fiecare interval de 200ms in care nu s-a dat click
; arg1 - evt (0 - initializare, 1 - click, 2 - s-a scurs intervalul fara click, 3 - s-a apasat o tasta)
; arg2 - x (in cazul apasarii unei taste, x contine codul ascii al tastei care a fost apasata)
; arg3 - y

draw proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1]
	cmp eax, 1
	jz evt_click
	mov ebx, switch
	cmp ebx, 1
	jnz fereastra
	cmp eax, 3
	jz evt_keyboard
	cmp eax, 2
	jz evt_timer
	
;;;;;;;;;;;;;;;;;;; mai jos e codul pentru interfata
fereastra:
	mov ebx, area
	mov eax, area_height
new_line:
	mov ecx, area_width
line:
	mov dword ptr[ebx], 80DC17h
	add ebx, 4
   loop line
	dec eax
	jnz new_line
	;linii
	line_vertical 80, 0, 600, 0 
	line_vertical 160, 0, 600, 0 
	line_vertical 240, 0, 600, 0 
	line_vertical 320, 0, 600, 0 
	;buton
	line_horizontal button_x, button_y, button_size, 0
	line_horizontal button_x, button_y + button_size, button_size, 0
	line_vertical button_x, button_y, button_size, 0
	line_vertical button_x + button_size, button_y, button_size, 0
	;minion
	make_minion area, pos_minionx , 547
	;;;daca s-a pierdut nu mai afisam textul start
	mov eax, switch
	cmp eax, 2
	jge sfarsit
afisare_litere:
	;scriem un mesaj
	make_text_macro 'S', area, 174, 259
	make_text_macro 'T', area, 184, 259
	make_text_macro 'A', area, 194, 259
	make_text_macro 'R', area, 204, 259
	make_text_macro 'T', area, 214, 259	
	jmp afisare_scor
sfarsit:
	;se afiseaza game over si se creste switch pentru ca textul sa apara timp de 7*200ms, iar apoi programul se incheie
	make_green_block area, 161 , 241
	make_text_macro 'G', area, 184, 239
	make_text_macro 'A', area, 194, 239
	make_text_macro 'M', area, 204, 239
	make_text_macro 'E', area, 214, 239
	make_text_macro 'O', area, 184, 259
	make_text_macro 'V', area, 194, 259
	make_text_macro 'E', area, 204, 259
	make_text_macro 'R', area, 214, 259
	inc switch
	mov eax, switch
	cmp eax, 12
	jle afisare 
	jmp endgame
	afisare:
	jmp afisare_scor
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; codul pentru cand se apasa click
evt_click:
	mov eax, [ebp + arg2]
	cmp eax, button_x
	jl afisare_scor
	cmp eax, button_x + button_size
	jg afisare_scor
	mov eax, [ebp + arg3]
	cmp eax, button_y
	jl afisare_scor
	cmp eax, button_y + button_size
	jg afisare_scor
	make_green_block area, 161 , 241
	mov switch, 1
	jmp afisare_scor

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; codul pentru cand se apasa o tasta
evt_keyboard:
	mov eax, [ebp + arg2]
	cmp eax, 37        ;left arrow
	jnz continue
	make_green_block area, current_block_minion, 541
	sub current_block_minion, 80
	sub pos_minionx, 80
	make_minion area, pos_minionx, 547
	jmp afisare_scor
  continue:
    cmp eax, 39        ;right arrow
	jnz afisare_scor
	make_green_block area, current_block_minion, 541
	add current_block_minion, 80
	add pos_minionx, 80
	make_minion area, pos_minionx, 547
	jmp afisare_scor

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; codul pentru cand nu se apasa nimic
evt_timer:
	;counter se genereaza random si in functie de valoare se afiseaza ceva diferit
	mov eax, counter
	cmp eax, 2
	jle caramizi2
	cmp eax, 8
	jz obanana
	cmp eax, 5
	jle caramizi
	jmp banane
	
	
	caramizi:
	mov eax, pos_bricky
	cmp eax, 12
	jz nou  ;se incepe cu caramida de sus
	cmp eax, 552  
	jnz bucla 
	;caramida a ajuns in ultima linie
	make_green_block area, x, y 
	;verificam daca caramida s-a lovit de minion
	mov eax, current_block_minion
	mov ebx, x
	cmp eax, ebx
	jz gameover
	generate_number counter
	;se reseteaza pozitia initiala pentru prima linie
	mov pos_bricky, 12
	jmp caramizi2
	nou:
	;se genereaza un nr random intre 0-9 care reprezinta pozitia din care vom lua un nr din vector, acesta reprezentand coloana pe care se va afisa caramida
	;x si y reprezinta coordonatele blocului curent, iar pos_brickx si pos_bricky reprezinta coordonatele caramizii in blocul curent
	generate_number random_number
	mov ecx, random_number
	mov ebx, [random_block + ecx*4]
	mov x, ebx
	add ebx, 16
	mov pos_brickx, ebx
	mov pos_bricky, 12
	mov y, 1
	make_brick area, pos_brickx, pos_bricky
	add pos_bricky, 60
	jmp caramizi2
    bucla:
	make_brick area, pos_brickx	, pos_bricky
	make_green_block area, x, y
	add y, 60
	add pos_bricky, 60
	jmp caramizi2
	
	
	caramizi2:
	mov eax, pos_bricky3
	cmp eax, 12
	jz nou3
	cmp eax, 552  
	jnz bucla3 
	make_green_block area, x3, y3
	mov eax, current_block_minion
	mov ebx, x3
	cmp eax, ebx
	jz gameover
	generate_number counter
	mov pos_bricky3, 12
	jmp afisare_scor
	nou3:
	generate_number random_number3
	mov ecx, random_number3
	mov ebx, [random_block + ecx*4]
	mov x3, ebx
	add ebx, 16
	mov pos_brickx3, ebx
	mov pos_bricky3, 12
	mov y3, 1
	make_brick area, pos_brickx3, pos_bricky3
	add pos_bricky3, 60
	jmp afisare_scor
    bucla3:
	make_brick area, pos_brickx3, pos_bricky3
	make_green_block area, x3, y3
	add y3, 60
	add pos_bricky3, 60
	jmp afisare_scor

	
	obanana:
	mov eax, pos_onebananay
	cmp eax, 14
	jz nou1
	cmp eax, 554
	jnz bucla1 
	make_green_block area, x1, y1
	mov eax, current_block_minion
	mov ebx, x1
	cmp eax, ebx
	jz unpunct
	generate_number counter
	mov pos_onebananay, 14
	jmp afisare_scor
	nou1:
	generate_number random_number1
	mov ecx, random_number1
	mov ebx, [random_block + ecx*4]
	mov x1, ebx
	add ebx, 16
	mov pos_onebananax, ebx
	mov pos_onebananay, 14
	mov y1, 1
	make_onebanana area, pos_onebananax, pos_onebananay
	add pos_onebananay, 60
	jmp afisare_scor
    bucla1:
	make_onebanana area, pos_onebananax, pos_onebananay
	make_green_block area, x1, y1
	add y1, 60
	add pos_onebananay, 60
	jmp afisare_scor
	
	banane:
	mov eax, pos_bananasy
	cmp eax, 7
	jz nou2
	cmp eax, 547
	jnz bucla2
	make_green_block area, x2, y2
	mov eax, current_block_minion
	mov ebx, x2
	cmp eax, ebx
	jz douapuncte
	generate_number counter
	mov nr1, 35
	mov pos_bananasy, 7
	jmp afisare_scor
	nou2:
	generate_number random_number2
	mov ecx, random_number2
	mov ebx, [random_block + ecx*4]
	mov x2, ebx
	add ebx, 16
	mov pos_bananasx, ebx
	mov pos_bananasy, 7
	mov y2, 1
	make_bananas area, pos_bananasx, pos_bananasy
	add pos_bananasy, 60
	jmp afisare_scor
    bucla2:
	make_bananas area, pos_bananasx, pos_bananasy
	make_green_block area, x2, y2
	add y2, 60
	add pos_bananasy, 60
	jmp afisare_scor
	
gameover:
	inc switch
	jmp afisare_scor
	
unpunct:
	add scor, 1
	mov x1, 0
	jmp afisare_scor
	
douapuncte:
	add scor, 2
	mov x2, 0
	
afisare_scor:
	mov ebx, 10
	mov eax, scor
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 30, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 20, 10
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 10, 10
	
final_draw:
	popa
	mov esp, ebp
	pop ebp
	ret
draw endp
	
start:
	mov nr1, eax
	;alocam memorie pentru zona de desenat
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	call malloc
	add esp, 4
	mov area, eax
	;apelam functia de desenare a ferestrei
	; typedef void (*DrawFunc)(int evt, int x, int y);
	; void __cdecl BeginDrawing(const char *title, int width, int height, unsigned int *area, DrawFunc draw);
	push offset draw
	push area
	push area_height
	push area_width
	push offset window_title
	call BeginDrawing
	add esp, 20
	
	;terminarea programului
	endgame:
	push 0
	call exit
end start
