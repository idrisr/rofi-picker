name:
{ makeDesktopItem }:

makeDesktopItem {
  name = name;
  exec = name; # better to get executable name out of package
  desktopName = name;
  genericName = "Library Browser";
  categories = [ "Utility" ];
  icon = "sage-notebook";
}
