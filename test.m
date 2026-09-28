X = [3; 3; 3];
% [F,J] = test_function01(X)
% for i = 1:5000
% [F,J] = test_function01(X);
% X = X - J\F;
% end
% 
% X
% [F,J] = test_function01(X)
% 
% 
% if [0 1 1 1]
%     disp('true')
% else
%     disp('WRONG')
% end

% list = [1; 2;
%     3; 4]

%[ans, flag] = newton_solver2(@test_function01, X)

leg_params = define_leg_parameters();

vertex_coords = [...
    [   0;   50];... %vertex 1 guess
    [ -50;    0];... %vertex 2 guess
    [ -50;   50];... %vertex 3 guess 
    [-100;    0];... %vertex 4 guess
    [-100;  -50];... %vertex 5 guess
    [ -50;  -50];... %vertex 6 guess
    [ -50; -100]...  %vertex 7 guess
    ];   
theta = pi/4;
%vertex_coords = compute_coords(vertex_coords_guess, leg_params, theta);
dVdtheta = compute_velocities(vertex_coords, leg_params, theta)