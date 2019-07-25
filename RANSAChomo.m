function [ phi , pointErr ] = RANSAChomo( sourcePoints , tagetPoints , N , tao)
    
    s = [sourcePoints(:,:) ones(size(sourcePoints,1),1)];
    t = [tagetPoints(:,:) ones(size(sourcePoints,1),1)];
    
    % Initial best inlier set to empty
    B = [];
    
    for i = 1:N
        % Randomly choose 4 matched point pairs
        R = uint8(rand(4,1)*(size(s,1)-1))+1;
        
        % Compute homography
        [phi,pointErr] = homoParam(tagetPoints(R,:),sourcePoints(R,:));
        
        % Initial set of inliers to empty
        S = [];
        
        % Compute squared distance
        d = t - transPoint(sourcePoints,phi);
        e = sum(d.*d,2);
        
        % If small enough then add to inliers
        S = find(e<tao);
        
        % If best agreement so far then store
        if(size(S,1)>size(B,1))
            B=S;
        end
    end
    % Compute homography from all inliers
    [phi,pointErr] = homoParam(tagetPoints(B,:),sourcePoints(B,:));
end

