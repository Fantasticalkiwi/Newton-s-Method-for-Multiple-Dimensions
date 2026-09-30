%Computes the theta derivatives of each vertex coordinate for the Jansen linkage
%INPUTS:
%  vertex_coords: a column vector containing the (x,y) coordinates of every vertex
%               these are assumed to be legal values that are roots of the error funcs!
%   leg_params: a struct containing the parameters that describe the linkage
%   dthetadt: rate of crank angle change with respect to time
%OUTPUTS:
%   dVdtheta: a column vector containing the theta derivates of each vertex coord
function dVdtheta = compute_velocities_explicit(vertex_coords, leg_params, theta, dthetadt)
    delta_theta = 10e-5;
    vertex_coords1 = compute_coords(theta+delta_theta,params); 
    vertex_coords2 = compute_coords(theta-delta_theta,params);
    coords1 = column_to_matrix(vertex_coords1);
    coords2 = column_to_matrix(vertex_coords2);
    
    %finite differences
    dxdtheta = (coords1(7,1) - coords2(7,1))/(2*delta_theta);
    dydtheta = (coords1(7,2) - coords2(7,2))/(2*delta_theta);

    %velocity of leg tip with respect to time
    dxdt = dxdtheta*dthetadt;
    dydt = dydtheta*dthetadt;
     
end