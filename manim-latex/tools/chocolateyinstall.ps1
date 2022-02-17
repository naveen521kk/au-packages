$ErrorActionPreference = 'Stop'
#tlmgr is package manager included in TinyTeX
Start-ChocolateyProcessAsAdmin `
  -Statements "tlmgr update --self" `
  -Elevated
Start-ChocolateyProcessAsAdmin `
  -Statements "tlmgr install amsmath fontspec latex-bin tipa xcolor xetex xkeyval standalone everysel ctex frcursive preview doublestroke ms setspace rsfs relsize ragged2e fundus-calligra microtype wasysym physics dvisvgm jknapltx wasy cm-super babel-english gnu-freefont mathastext cbfonts-fd" `
  -Elevated

