%Error function that encodes the fixed vertex constraints
%INPUTS:
%vertex_coords: a column vector containing the (x,y) coordinates of every vertex
% same input as link_length_error_func
%leg_params: a struct containing the parameters that describe the linkage
% importantly, leg_params.crank_length is the length of the crank
% and leg_params.vertex_pos0 and leg_params.vertex_pos2 are the
% fixed positions of the crank rotation center and vertex 2.
%theta: the current angle of the crank
%OUTPUTS:
%coord_errors: a column vector of height four corresponding to the differences
% between the current values of (x1,y1),(x2,y2) and
% the fixed values that they should be
function coord_errors = fixed_coord_error_func(vertex_coords, leg_params, theta)
%your code here
%length of crank shaft
leg_params.crank_length = 15.0;
%fixed position coords of vertex 0
[x0_fixed, y0_fixed] = leg_params.vertex_pos0;
%fixed position coords of vertex 2
[x2_fixed, y2_fixed] = leg_params.vertex_pos2;
x0_current = vertex_coords(1,1) - 15*cos(theta);
y0_current = vertex_coords(1,2) - 15*sin(theta);
[x2_current, y2_current] = vertex_coords(2);

coord_errors = [x0_current - x0_fixed; y0_current - y0_fixed; x2_current - x2_fixed; y2_current - y2_fixed];
end