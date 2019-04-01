Function UserExit(sType, sWhen, sDetail, bSkip) 
  UserExit = Success 
End Function

Function OSDComputerName()	
	Dim pscommand
	Dim cmd

	pscommand = "E:\TestingDS\Scripts\OSDComputerName.ps1"

	cmd = "powershell.exe -noprofile -executionpolicy bypass -command " & pscommand

	Set shell = CreateObject("WScript.Shell")

	Set executor = shell.Exec(cmd)

	executor.StdIn.Close

	OSDComputerName = executor.StdOut.ReadAll
End Function

MsgBox OSDComputerName
