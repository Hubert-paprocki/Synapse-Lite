Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "cmd /c SynapseLite.bat", 0, True
Set WshShell = Nothing
