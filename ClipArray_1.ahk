/*
Created by Epishade
Credit to AfterLemon for his In-Line Send Sleep Function
*/

/*
Modificado por Pedro Augusto pedroabs1@gmail.com/
*/

#NoEnv
#SingleInstance Force
SendMode Input

Global Array := []
Global NumClips = 0 ;numero de Clips
Global clipAtual = 0 ; Clip atual
Global UltClip = 0 ; Ultimo Clip

Global DelimitByCell = 1
Global InterpretAsCode = 1
Global TrimEnds = 1

tooltip, Shift + F1 = Copies the current selection and stores in array`r`nShift + F2 = Decreases the current location in the array to be pasted`r`nShift + F3 = Pastes the current entry in the array and increments array by 1`r`nShift + F4 = Increases the current location in the array to be pasted`r`nShift + F5 = Opens the Gui to make any settings changes, 1500, 900
SetTimer, RemoveToolTip, 3000

; I_Icon =  ;matrix_icon_137416.ico
; IfExist, %I_Icon%
Menu, Tray, Icon, %A_ScriptDir%\lib\icones\matrix_icon_137416-white.ico

; Gui:
; Gui, Font, s10
; Gui, Add, CheckBox, vDelimitByCell %DelimitByCell%, Delimit selection by tabs/newlines/cells? ;Checked ; para marcar
; Gui, Add, CheckBox, vInterpretAsCode Checked%InterpretAsCode%, Some lines such as abc{1000}{tab} etc will be interpretted as code. Allow?
; Gui, Add, CheckBox, vTrimEnds %TrimEnds%, Trim spaces from the ends? ;Checked ; para marcar
; Gui, Font, s15
; Gui, Add, Button, w100 vButtonSave Default, Save
; Gui, Add, Button, x125 y76 w100 vButtonHelp, Help
; Gui, Add, Button, x238 y76 w100 vButtonReset, Reset
; Gui, Show, , New GUI Window
; Return

; ButtonSave:
; Gui, submit
; Return

; ButtonHelp:
; MsgBox,
; (
; This script is used to copy and store multiple entries of information in a virtual clipboard to be manipulated and sequentially pasted as needed.

; Shift + F1 = Copies the current selection and stores in array.
; Shift + F2 = Decreases the current location in the array to be pasted.
; Shift + F3 = Pastes the current entry in the array and increments array by 1.
; Shift + F4 = Increases the current location in the array to be pasted.
; Shift + F5 = Opens the Gui to make any settings changes.

; Delimit selection by tabs/newlines/cells allows the user to select multiple entries to be copied, each of which will be placed independently in the copy array.

; Interpretting lines as code allows the user to write code into the copied selection, which will be executed when that selection is sent using F3.
; This is useful for sending code to tab a certain amount of times or sleep for a little bit upon sending the array entry. Sleep is denotated by a number within curly braces. Example: Copying an entry with abc{1000}{tab} will, when pasted, result in "abc" being sent followed by a sleep of 1 second, and then a tab keypress.

; Trim spaces from the ends removes any spaces from the ends of copied entries.
; )
; Sleep 2000
; Return

; ButtonReset:
; Reload
; Return

; GuiClose:
; ExitApp
; Return

+F1:: ;copia
;^c:: 
Clipboard := ""
Send ^c
ClipWait, 1
tooltip, % "Copiado:  " Clipboard
;IniWrite, %Clipboard%, Settings.ini, Main,%clipAtual% ;escreve os valores armazenados
SetTimer, RemoveToolTip, 1000
Gosub ClipboardFormat
Return

;^,::
+F2:: ;valor anterior
clipAtual -= 1
NumClips := clipAtual
;IniRead, Array[clipAtual], Settings.ini, Main, clipAtual ;le os valores armazenados
;tooltip, % Array[clipAtual]
;SetTimer, RemoveToolTip, 1000
Gosub WatchToolTip
Return

;^v::
+F3:: ;cola
NumClips := clipAtual
EntryCount := clipAtual
;IniRead, Clipboard, Settings.ini, Main, %clipAtual% ;le os valores armazenados
;Array[clipAtual] := Clipboard

If (InterpretAsCode = 0)     ; Uses SendRaw.
{
	SendRaw % Array[clipAtual]
}
else ;If (InterpretAsCode = 1)     ; Uses Send function.
{
	Send(Array[clipAtual])
}
clipAtual += 1
Senditem := 0
Gosub WatchToolTip
Return

::]6::
Item := Array[clipAtual+1] ; = 1
Goto, Senditem
Return
::]7::
Item := Array[clipAtual+2] ; = 2
Goto, Senditem
Return
::]8::
Item := Array[clipAtual+3] ; = 3
Goto, Senditem
Return
::]9::
Item := Array[clipAtual+4] ; = 4
Goto, Senditem
Return
::]0::
Item := Array[clipAtual+5] ; = 5
Goto, Senditem
Return

::]5::
Item := Array[clipAtual-1] ; = 1
Goto, Senditem
Return
::]4::
Item := Array[clipAtual-2] ; = 2
Goto, Senditem
Return
::]3::
Item := Array[clipAtual-3] ; = 3
Goto, Senditem
Return
::}2::
Item := Array[clipAtual-4] ; = 4
Goto, Senditem
Return
::}1::
Item := Array[clipAtual-5] ; = 5
Goto, Senditem
Return

Senditem:
If (InterpretAsCode = 0)     ; Uses SendRaw.
{
	SendRaw % Item
}
else ;If (InterpretAsCode = 1)     ; Uses Send function.
{
	Send(Item)
}
Gosub WatchToolTip
Return


;//todo remover item por numero digitado

;//todo colar item por numero digitado

;//todo remover item atual


;^.::
+F4:: ;proximo valor
clipAtual += 1
NumClips := clipAtual
;IniRead, Array[clipAtual], Settings.ini, Main, clipAtual ;le os valores armazenados
;tooltip, % Array[clipAtual]
;SetTimer, RemoveToolTip, 1000
Gosub WatchToolTip
Return

+F5::
tooltip, % "Removido:  " Array[clipAtual]
;sleep 1000
Array[clipAtual] := ""
NumClips -= 1
;tooltip, % Array[clipAtual]
Gosub WatchToolTip
Return

; +F6::
; GUI Destroy
; Gosub GUI
; Return

+F6::
gosub WatchTooltip
Return

WatchTooltip:
Item := Array[clipAtual]
NextItem:= Array[clipAtual+1] ; = 2
NextItem2:= Array[clipAtual+2] ; = 2
NextItem3 := Array[clipAtual+3] ; = 3
NextItem4 := Array[clipAtual+4] ; = 4
NextItem5 := Array[clipAtual+5] ; = 5

PreviousItem := Array[clipAtual-1]
PreviousItem2:= Array[clipAtual-2] ; = 2
PreviousItem3 := Array[clipAtual-3] ; = 3
PreviousItem4 := Array[clipAtual-4] ; = 4
PreviousItem5 := Array[clipAtual-5] ; = 5
EntryCount := clipAtual

ToolTip, ClipArray!`r`n--------------------`r`nAnterior 5: %PreviousItem5%`r`nAnterior 4: %PreviousItem4%`r`nAnterior 3: %PreviousItem3%`r`nAnterior 2: %PreviousItem2%`r`nAnterior: %PreviousItem%`r`n--------------------`r`nItem %EntryCount%: %Item%`r`n--------------------`r`nProximo: %NextItem%`r`nProximo 2: %NextItem2%`r`nProximo 3: %NextItem3%`r`nProximo 4: %NextItem4%`r`nProximo 5: %NextItem5%

SetTimer, RemoveToolTip, 2000
Return

ClipboardFormat:

If (DelimitByCell = 0)
{
	UltClip += 1
	NumClips += 1
	Clipboard := StrReplace(Clipboard,"`r`n","`n")     ; Fixes double-newline issue.
	Array[UltClip] := ClipboardTrim(Clipboard) ;era NumClips
}
If (DelimitByCell = 1)
{
	Clipboard := StrReplace(Clipboard,"`r`n","¶")     ; Replaces newlines (vertical cells) with ¶ symbol.
	Clipboard := StrReplace(Clipboard,"`t","¶")     ; Replaces tabs (horizontal cells) with ¶ symbol.
	If (SubStr(Clipboard,0) = "¶")     ; Removes the last ¶ symbol from the string, if it exists, meaning selection was copied from excel.
	{
		Clipboard := Substr(Clipboard, 1, StrLen(Clipboard) - 1)
	}
	Loop, Parse, Clipboard, "¶"
	{
		UltClip += 1
		NumClips += 1
		Array[UltClip] := ClipboardTrim(A_LoopField) ;era NumClips
	}
}
Return

ClipboardTrim(StringToTrim)
{
If (TrimEnds = 1)
{
	StringToTrim := Trim(StringToTrim)
}
Return StringToTrim
}

Send(String, Raw:="", RawKeys:="")     ; Function to allow In-Line Send Sleep using curly brackets
{
D:="{",E="}",S:=String D,i=0,T=1,R=(Raw?1:(SubStr(S,1,5)="{RAW}"?1:0)),M="+,!,#,^",K=RawKeys
While i:=InStr(S,D,V,i+1){
Send,% (R?"{RAW}":"") SubStr(S,T,InStr(S,D,V,i)-T)
B:=SubStr(S,InStr(S,D,V,i)+1,InStr(S,E,V,i)-StrLen(S)-1),A=SubStr(B,1,-1)
If InStr(S,D,V,i+1)
If(B&1=""){
If(A&1!="")
Sleep,% A*1000
else{
L:=(!R?(InStr(S,E,V,i)-StrLen(B)-2>4?4:InStr(S,E,V,i)-StrLen(B)-2):0)
Loop,%L%{
C:=SubStr(SubStr(S,InStr(S,D,V,i)-L,L),A_Index,1)
If C in %M%
{ C:=SubStr(S,InStr(S,D,V,i)-(L+1-A_Index),L+1-A_Index)
break
}else C:=""
}Send,% (K?"{RAW}":"") C "{" B "}"
}}else Sleep,%B%
T:=InStr(S,E,V,i+1)+1
}}

RemoveToolTip:  
    SetTimer, RemoveToolTip, Off    
    ToolTip    
return