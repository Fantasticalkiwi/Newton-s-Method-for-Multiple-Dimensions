X = [3; 3; 3]
[F,J] = test_function01(X)
for i = 1:5000
[F,J] = test_function01(X);
X = X - J\F;
end

X
[F,J] = test_function01(X)


if [0 1 1 1]
    disp('true')
else
    disp('WRONG')
end