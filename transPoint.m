function [ x ] = transPoint( w , phi )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
    w = [w ones(size(w,1),1)];
    x = phi * w.';
    x = x ./ repmat(x(3,:),[3,1]);
    x = x.';

end

