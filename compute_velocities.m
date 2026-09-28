%Computes the theta derivatives of each vertex coordinate for the Jansen linkage
%INPUTS:
%  vertex_coords: a column vector containing the (x,y) coordinates of every vertex
%               these are assumed to be legal values that are roots of the error funcs!
%   leg_params: a struct containing the parameters that describe the linkage
%   theta: the current angle of the crank
%OUTPUTS:
%   dVdtheta: a column vector containing the theta derivates of each vertex coord
function dVdtheta = compute_velocities(vertex_coords, leg_params, theta)
    
    link_length_wrap = @(v) link_length_error_func(v, leg_params);
    
    J = approximate_jacobian(link_length_wrap, vertex_coords);

    M = [eye(4) zeros(4, 10); J];
    
    dxdtheta = -leg_params.crank_length*sin(theta);
    dydtheta = leg_params.crank_length*cos(theta);
    B = zeros(14,1);
    B(1) = dxdtheta;
    B(2) = dydtheta;
    dVdtheta = M\B;
     
end