%Error function that encodes the fixed vertex constraints
%INPUTS:
%   vertex_coords: a column vector containing the (x,y) coordinates of every vertex
%   same input as link_length_error_func
%   leg_params: a struct containing the parameters that describe the linkage
%   importantly, leg_params.crank_length is the length of the crank
%   and leg_params.vertex_pos0 and leg_params.vertex_pos2 are the
%   fixed positions of the crank rotation center and vertex 2.
%   theta: the current angle of the crank
%OUTPUTS:
%   coord_errors: a column vector of height four corresponding to the differences
%   between the current values of (x1,y1),(x2,y2) and
%   the fixed values that they should be
function coord_errors = fixed_coord_error_func(vertex_coords, leg_params, theta)
    % unpack leg_params: 
    % crank length, fixed vertex positions
    crank_length = leg_params.crank_length;
    [x0_fixed, y0_fixed] = leg_params.vertex_pos0;
    [x2_fixed, y2_fixed] = leg_params.vertex_pos2;

    % hard-calc'd position coords of vertex 1, via theta and vertex 0
    x1_fixed = x0_fixed + crank_length*cos(theta);
    y1_fixed = y0_fixed + crank_length*sin(theta);
    
    % current position coords
    x1_current = vertex_coords(1,1);
    y1_current = vertex_coords(1,2);
    [x2_current, y2_current] = vertex_coords(2);
    
    coord_errors = [x1_current-x1_fixed; y1_current-y1_fixed; 
        x2_current-x2_fixed; y2_current-y2_fixed];
end