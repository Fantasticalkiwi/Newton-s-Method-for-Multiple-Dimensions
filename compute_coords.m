%Computes the vertex coordinates that describe a legal linkage configuration
%INPUTS:
%   vertex_coords_guess: a column vector containing the (x,y) coordinates of every vertex
%   these coords are just a GUESS! It's used to seed Newton's method
%   leg_params: a struct containing the parameters that describe the linkage
%   theta: the desired angle of the crank
%OUTPUTS:
%   vertex_coords_root: a column vector containing the (x,y) coordinates of every vertex
%   these coords satisfy all the kinematic constraints!
function [vertex_coords_root, exit_flag] = compute_coords(vertex_coords_guess, leg_params, theta)

    % set up linkage_error_func to take leg_params and theta in a wrapper
    linkage_error_wrap = @(v) linkage_error_func(v, leg_params,theta);

    % pass that wrapper to newtonsolver2
    [vertex_coords_root, exit_flag] = newton_solver2(linkage_error_wrap, vertex_coords_guess);
end