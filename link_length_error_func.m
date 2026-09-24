%Error function that encodes the link length constraints
%INPUTS:
%vertex_coords: a column vector containing the (x,y) coordinates of every vertex
% in the linkage. There are two ways that I would recommend stacking
% the coordinates. You could alternate between x and y coordinates:
% i.e. vertex_coords = [x1;y1;x2;y2;...;xn;y_n], or alternatively
% you could do all the x's first followed by all of the y's
% i.e. vertex_coords = [x1;x2;...xn;y1;y2;...;yn]. You could also do
% something else entirely, the choice is up to you.
%leg_params: a struct containing the parameters that describe the linkage
% importantly, leg_params.link_lengths is a list of linakge lengths
% and leg_params.link_to_vertex_list is a two column matrix where
% leg_params.link_to_vertex_list(i,1) and
% leg_params.link_to_vertex_list(i,2) are the pair of vertices connected
% by the ith link in the mechanism
%OUTPUTS:
%length_errors: a column vector describing the current distance error of the ith
% link specifically, length_errors(i) = (xb-xa)ˆ2 + (yb-ya)ˆ2 - d_iˆ2
% where (xa,ya) and (xb,yb) are the coordinates of the vertices that
% are connected by the ith link, and d_i is the length of the ith link
function length_errors = link_length_error_func(vertex_coords, leg_params)
%your code here
length_errors = zeros(length(leg_params.link_to_vertex_list(:,1),1))
for i = 1:length(length_errors)
    v1 = leg_params.link_to_vertex_list(i,1);
    v2 = leg_params.link_to_vertex_list(i,2);
    x1 = vertex_coords(v1*2-1);
    y1 = vertex_coords(v1*2);

    x2= vertex_coords(v2*2-1);
    y2 = vertex_coords(v2*2);
    length_errors(i) = (x2 - x1)^2 + (y2 - y1)^2 - leg_params.link_lengths(i)^2;
end


end