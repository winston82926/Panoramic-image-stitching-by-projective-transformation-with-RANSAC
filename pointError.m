function [ e ] = pointError( imagePoint , transPoint )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    e = sum(sum(((imagePoint - transPoint).^2))) / size(imagePoint,1);

end

