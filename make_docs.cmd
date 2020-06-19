@ECHO OFF

pandoc --highlight-style=tango -t html --standalone --toc -c buttondown.css -o html/EmulationStation.html LKESG/EmulationStation.md
pandoc --highlight-style=tango -t html --standalone --toc -c buttondown.css -o html/Gamepad-configuration.html LKESG/Gamepad-configuration.md
pandoc --highlight-style=tango -t html --standalone --toc -c buttondown.css -o html/Kodi.html LKESG/Kodi.md

pandoc --highlight-style=tango -t html --standalone --toc -c buttondown.css -o html/Linux-advanced-configuration.html LKESG/Linux-advanced-configuration.md
pandoc --highlight-style=tango -t html --standalone --toc -c buttondown.css -o html/Linux-basic-commands-and-procedures.html LKESG/Linux-basic-commands-and-procedures.md
pandoc --highlight-style=tango -t html --standalone --toc -c buttondown.css -o html/Linux-installation-and-configuration.html LKESG/Linux-installation-and-configuration.md

pandoc --highlight-style=tango -t html --standalone --toc -c buttondown.css -o html/MAME.html LKESG/MAME.md
pandoc --highlight-style=tango -t html --standalone --toc -c buttondown.css -o html/Mednafen.html LKESG/Mednafen.md
pandoc --highlight-style=tango -t html --standalone --toc -c buttondown.css -o html/Random-notes.html LKESG/Random-notes.md
pandoc --highlight-style=tango -t html --standalone --toc -c buttondown.css -o html/References.html LKESG/References.md
pandoc --highlight-style=tango -t html --standalone --toc -c buttondown.css -o html/Retroarch.html LKESG/Retroarch.md
