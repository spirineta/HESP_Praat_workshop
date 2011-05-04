# This script opens all Sounds to be annotated with a TextGrid.
# Copyright 1.22.2009 Charles Chang

# select all of the objects in the list
select all

# get the count of Sound objects
numSelected = numberOfSelected("Sound")

# create a TextGrid for each Sound and open the Sound with its TextGrid
for i to numSelected
    
    name$ = selected$("Sound", i)
    select Sound 'name$'
    To TextGrid... "votlag pitchonset"
    select Sound 'name$'
    plus TextGrid 'name$'
    Edit
    select all

endfor