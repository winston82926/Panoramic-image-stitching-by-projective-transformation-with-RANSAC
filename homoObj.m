function [ f ] = homoObj( imagePoints , worldPoints , phi )
    
    x = [imagePoints(:,:) ones(size(imagePoints,1),1)];
    w = [worldPoints(:,:) ones(size(imagePoints,1),1)];
    x_ = phi * w.';
    x_ = x_ ./ repmat(x_(3,:),[3,1]);
    x_ = x_.';
    f = pointError(x,x_);

end

