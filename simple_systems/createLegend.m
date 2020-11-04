function lgnd = createLegend(string, something)
    %  Input: something - columnb vector in the form [expression1;expression2...]
    %         string - str a name for all of the cells
    % TODO add a unique string for each cell specified by a string column vector
    % of the same length as 'something'.
    % Output: a formatted legend you can use as an argument for legend()
    fprintf('Hello')
    lgnd = 0
    [pn, values] = size(something)
    if pn > 0
    %  construct your legend cell struct
        lgnd = cell(pn,1) % _ _ _ _ _ (pnx1)
        tmp1 = ''
        for p=1:pn
            % iterate through all the values and turn them into a single string
            for i=1:values
                tmp1 = strcat(tmp1, num2str(something(p,i)));
                if i == values
                    fprintf("P_%i: %s\n", p, tmp1)
                else
                    tmp1 = strcat(tmp1,', ')
                end
            end
            lgnd{p} = strcat(string,tmp1)
            tmp1 = ''
        end
    else
       fprintf('No data, make sure your input is not empty') 
    end
end


% NOTES: 
% When the strucutre is one dimensional you done have to define
% the axis that your talkin about.
% fprintf returns the number of bytes, while sprintf returns the actual string