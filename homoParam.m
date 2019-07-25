function [ phi_m , e ] = homoParam( imagePoints , worldPoints )
    
    x = [imagePoints(:,:) ones(size(imagePoints,1),1)];
    w = [worldPoints(:,:) ones(size(imagePoints,1),1)];

    A = [];
    for i = 1:size(x,1)
        A = [A ; [zeros(1,3) -w(i,:) x(i,2)*w(i,:) ; w(i,:) zeros(1,3) -x(i,1)*w(i,:)]];
    end
    [U,S,V] = svd(A);
    phi = V(:,end);
    phi_m = reshape(phi,3,3).';
    x_ = phi_m * w.';
    x_ = x_ ./ repmat(x_(3,:),[3,1]);
    x_ = x_.';
    
    e = pointError(x,x_);
    
    %% Optimize by function
    f = @homoObj;
    fun = @(x)f( imagePoints , worldPoints , x);
    options = optimoptions(@fminunc,'Algorithm','quasi-newton');
    [arg,fval,exitflag,output] = fminunc(fun,phi_m,options);
    phi_m = arg;
    x_ = phi_m * w.';
    x_ = x_ ./ repmat(x_(3,:),[3,1]);
    x_ = x_.';
    
    e = pointError(x,x_);

    %% Optimize by taylor expansion
%     lambda = 1;
%     K = 50;
%     for j = 1:K
% 
%         J = {};
%         A = zeros(9,9);
%         b = zeros(9,1);
%         e = x - x_;
%         for i = 1:size(x,1)
%             J{i} = [w(i,:) zeros(1,3) -x(i,1)*w(i,:) ; zeros(1,3) w(i,:) -x(i,2)*w(i,:) ] / (phi_m(3,:) * w(i,:).');
%             A = A + J{i}.'*J{i};
%             b = b + J{i}.'*e(1,1:end-1).';
%         end
%         delta_phi = pinv(A)*b;
% %         delta_phi = inv(A+lambda*diag(diag(A)))*b;
%         delta_phi = reshape(delta_phi,3,3).';
%         phi_m = phi_m + delta_phi;
%         x_ = phi_m * w.';
%         x_ = x_ ./ repmat(x_(3,:),[3,1]);
%         x_ = x_.';
% %         fprintf('%f',pointError(x,x_));
%     end
%     e = pointError(x,x_);

end

