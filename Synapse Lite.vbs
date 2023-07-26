Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "cmd /c SynapseLite.bat", 0, False
Set WshShell = Nothing