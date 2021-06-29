TITLE SAVING CALCULATION SYSTEM
.686
.MODEL flat, stdcall
.STACK
INCLUDE Irvine32.inc
.data

ArraySize EQU 6
InputArray DWORD 20000,20500,30500,40000,40200,40700
ExpenseArray DWORD 7700,10680,22200,22000,23000,24380
ArrayI DWORD 6 DUP(?)
Sum DWORD 0
Text BYTE " month saving = RM ",0
Text2 BYTE "The total savings = RM ",0
Line BYTE "----------------------------------------------",0,0
.code
main PROC
    call Clrscr
	call Input
	call ShowPerSaving
    call MakeLine
    call SumArray
    call MakeLine
main ENDP

;-----------------------------------------------------
;Subtracting InputArray with ExpenseArray
;Stores it into ArrayI
;-----------------------------------------------------
Input PROC
mov ecx, LENGTHOF InputArray
mov esi, 0
L1:
    mov eax,InputArray[esi*4]
    sub eax,ExpenseArray[esi*4]
    mov ArrayI[esi*4], eax
    inc esi
loop L1
ret
Input ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SumArray PROC
mov ecx, LENGTHOF ArrayI
mov esi,0
mov eax,0
L2:
    add eax, ArrayI[esi*4]
    inc esi
loop L2

mov Sum, eax
lea edx,Text2
	call Crlf
	call WriteString
	mov eax,Sum
	call writedec

ret
SumArray ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ShowPerSaving PROC
mov ecx, LENGTHOF ArrayI
mov esi,0
mov ebx,0
L3:
    call Crlf
    inc ebx
    mov eax,ebx
    call WriteDec
    lea edx,Text
    call WriteString

    mov eax, ArrayI[esi*4]
    call WriteDec
    inc esi
loop L3
ret
ShowPerSaving ENDP

MakeLine PROC
    call Crlf
    lea edx, Line
    call WriteString
    ret
MakeLine ENDP

exit
END main
