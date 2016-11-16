countstay =0;
countswitch = 0;
n = 10000;
for i = 1:n
    [door,door] = sort(rand(3,1));
    [guess,guess] = sort(rand(3,1));
    stayswitch = rand();
    if guess(1) == door(1);
        if stayswitch < .5;
            countstay = countstay + 1;
        end
    end
    if guess(1) ~= door(1);
            if stayswitch > .5;
                countswitch = countswitch + 1;
            end
    end
end
winbystay = countstay/n *100
winbyswitch = countswitch/n*100
totalwinspercent = winbystay+winbyswitch


