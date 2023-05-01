def rev:
    if length == 0 then
        []
    else
        (.[1:] | rev) + [.[0]]  
    end
;

.value | split("") | rev | add // ""
