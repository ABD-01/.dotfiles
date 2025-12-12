alias p='cd D:/PROJECTS/'

alias falcon='cd D:/PROJECTS/falcon/'
alias eth='cd D:/PROJECTS/tcu4g_ethernet/'
alias ddl='cd D:/PROJECTS/atcu-ddl/'
alias tcuev='cd D:/PROJECTS/atcu-ev/'
alias ucan='cd D:/PROJECTS/can-utility/'
alias rp='cd D:/Renesas_PROJECTS'
alias smp='cd D:/PROJECTS/sampark'
alias a2t='cd D:/PROJECTS/a2t-scv-base'

alias npp='C:/Program\ Files/Notepad++/notepad++.exe'

MCUBUILD()
{
  WORKSPACE_PATH=D:/PROJECTS/atcu-ev/ATCU_Workspace
  IDE_PATH=C:/nxp/MCUXpressoIDE_11.4.0_6224/ide/mcuxpressoide.exe
  unzip -o -qq $WORKSPACE_PATH/ATCU/project_settings.zip -d $WORKSPACE_PATH/ATCU
  $IDE_PATH \
    -nosplash \
    -consoleLog \
    -application org.eclipse.cdt.managedbuilder.core.headlessbuild \
    -data $WORKSPACE_PATH \
    -cleanBuild ATCU/Debug_APP
    # -noExit \
  echo "Done"
}

CLEANDEBUG()
{
  WORKSPACE_PATH=D:/PROJECTS/falcon/ATCU_Workspace
  rm -rf $WORKSPACE_PATH/ATCU/Debug_APP/
}
alias make='/c/CSDTK4/make64/make.exe'
alias ucrt='/c/msys64/msys2_shell.cmd -here -no-start -defterm -ucrt64 -use-full-path'
alias vact='source ~/.virtualenvs/ATCU_Workspace-VdKM886n/Scripts/activate'
