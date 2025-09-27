if (!A_IsAdmin) {
  cmd := DllCall("GetCommandLine", "str")
  if (!RegExMatch(cmd, " /restart(?!\S)")) {
    try {
      if (A_IsCompiled) {
        Run('*RunAs "' A_ScriptFullPath '" /restart')
      } else {
        Run('*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"')
      }
    } catch {
      MsgBox("自动获取管理员权限失败，请右键脚本选择以管理员身份运行", "错误", "Iconx 0x40000")
    }
  } else {
    MsgBox("自动获取管理员权限失败，请右键脚本选择以管理员身份运行", "错误", "Iconx 0x40000")
  }
  ExitApp()
}