%Computes the theta derivatives of each vertex coordinate for the Jansen linkage
%INPUTS:
% vertex_coords: a column vector containing the (x,y) coordinates of every vertex
% leg_params: a struct containing the parameters that describe the linkages
% theta: the current crank angle
% dtheta_dt: rate of crank angle change with respect to time
%OUTPUTS:
%   dVdtheta: a column vector containing the theta derivates of each vertex coord
function dVdtheta = compute_velocities_explicit(vertex_coords, leg_params, theta, dtheta_dt)
    % set delta as a small value
    delta = 10e-5;
    
    % compute vertices at a finite difference away in angle
    vertex_coords_2 = compute_coords(vertex_coords,leg_params,theta+delta);

    % convert the column vector to an easier-to-handle matrix
    vertices_1 = column_to_matrix(vertex_coords);
    vertices_2 = column_to_matrix(vertex_coords_2);

    % store the matrices in four separate column vectors:
    % two for vertices at theta
    x1 = vertices_1(:,1);
    y1 = vertices_1(:,2);
    % two for vertices at theta+delta
    x2 = vertices_2(:,1);
    y2 = vertices_2(:,2);
    
    % solve for finite differences
    dx_dtheta = (x1-x2) ./ (2*delta);
    dy_dtheta = (y1-y2) ./ (2*delta);

    % calculate the velocity of leg tip with respect to time
    dxdt = dx_dtheta.*dtheta_dt;
    dydt = dy_dtheta.*dtheta_dt;

    % put the values together in a matrix, then output as a column vector
    % in the form [x1;y1;x2;y2;...xn;yn] to match compute_velocities.m
    dVdtheta = matrix_to_column([dxdt, dydt]);
end