{ rofi, writeShellApplication, zathura }:

writeShellApplication {
  name = "rofilauncher";
  runtimeInputs = [ rofi zathura ];
  text = builtins.readFile ./filelist.sh;
}
