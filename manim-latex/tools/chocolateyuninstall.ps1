$ErrorActionPreference = 'Stop';
Start-ChocolateyProcessAsAdmin `
  -Statements "tlmgr remove standalone preview doublestroke ms setspace rsfs relsize ragged2e fundus-calligra microtype wasysym physics dvisvgm jknapltx wasy cm-super babel-english" `
  -Elevated