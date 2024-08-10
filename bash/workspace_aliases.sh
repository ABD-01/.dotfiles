alias falcon='cd D:/PROJECTS/falcon/'
alias ddl='cd D:/PROJECTS/atcu-ddl/'
alias tcuev='cd D:/PROJECTS/atcu-ev/'
alias ucan='cd D:/PROJECTS/can-utility/'

MCUBUILD()
{
  WORKSPACE_PATH=D:/PROJECTS/falcon/ATCU_Workspace
  IDE_PATH=C:/nxp/MCUXpressoIDE_11.4.1_6260/ide/mcuxpressoide.exe
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
