%implement root finder using the Newton Method
%INPUTS:
%fun: the mathetmatical function we want to solve
%x0: the initial guess
%max_iter: limit of max iterations
% dxtol: termination threshold (stop when interval abs(dx) < dxtol)
% ftol: termination threshold (stop when abs(f)<ftol
% terminate when abs(-dx) > dxmax, where dxmax is a very large number
%OUTPUTS:
%x: approximate root of function
%flag: 1 is success, 0 is failure
function [x,flag] = newton_solver2(fun,X0,max_iter,ftol,dxtol,dx_max)
    for i = 1:max_iter
        [F,J] = fun(X0);
        
        if abs(f) < ftol
            %fprintf('ftol\n');
            x = X0;
            %flag = 1;
            return
        end

        dx = -F*(J\F);
        
        if abs(dx) > dx_max
            %dx = sign(dx)*dx_max;
            %flag = 0; 
            x = X0;
            return
        end

        X1=X0+dx;

        if abs(dx) <= dxtol
            %fprintf('dxtol\n');
            x = X1;
            %flag = 1;
            return
        end

        X0 = X1;
        hold on
    end
    x = X0
    %flag = 0;
    %fprintf('max_iter\n')
end