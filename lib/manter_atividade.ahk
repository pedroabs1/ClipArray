#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force

Loop
	{
		If A_TimeIdle > 30000
			{
				Random, Xi, 0, 1920
				Random, Yi, 0, 1080
				
				MouseMove, % Xi, % Yi, 70
			}
	}
				
	return