##  This script goes through all the sound files in some
##  directory specified by the user and and scales
##  each file in amplitude so that all of them have
##  the same peak amplitude.  The script as written
##  looks for .aiff files as input and outputs .wav
##  files, but you can easily change this by modifying
##  the lines that (1) set extension$ to ".aiff" and
##  (2) start off "Write to WAV file...".

directory$ = "c:\Stimuli\Syllables\"
outdir$ = "c:\Stimuli\Syllables\Scratch\"
extension$ = ".wav"

Create Strings as file list... list 'directory$'*'extension$'
number_files = Get number of strings

for a from 1 to number_files
     select Strings list
     current_file$ = Get string... 'a'
     Read from file... 'directory$''current_file$'
     object_name$ = selected$("Sound")
     Scale... 0.99996948
     Write to WAV file... 'outdir$''object_name$'.wav
     Remove
endfor
select all
Remove
clearinfo
print All files processed!

##  Katherine Crosswhite
##  University of Rochester