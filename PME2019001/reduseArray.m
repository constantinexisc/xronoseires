function [outputArray,rows,coloums] = reduseArray(Array)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [r,c] = size(Array);

    for i = 1 : r
        if( Array(i) == 0)
            outputArray = Array(1:i-1,1:c);
            [rows,coloums] = size(outputArray);
            break;
        end
    end

end

