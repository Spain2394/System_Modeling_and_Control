function stp = step(t,tdelay)
    fprintf('tdelay', tdelay);

    if t > tdelay
        stp = 1
    else
        stp = 0
    end

end

