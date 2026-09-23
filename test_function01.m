%the function name and input/output variable names
%are just what I chose, you can use whatever names you'd like
function [f_val,J] = test_function01(x)
%your code here
f_val = zeros(3,1);
x1 = x(1);
x2 = x(2);
x3 = x(3);
f_val(1) = x1^2+x2^2-6-x3^5;
f_val(2) = x1*x3+x2-12;
f_val(3) = sin(x1+x2+x3);
J = [2*x1 2*x2 -5*x3^4; x3 1 0; cos(x1+x2+x3) cos(x1+x2+x3) cos(x1+x2+x3)];

end