%Updates the plot objects that visualize the leg linkage
%for the current leg configuration
%INPUTS:
%complete_vertex_coords: a column vector containing the (x,y) coordinates of every vertex
%leg_drawing: a struct containing all the plotting objects for the linkage
%       leg_drawing.linkages is a cell array, where each element corresponds
%       to a plot of a single link (excluding the crank)
%       leg_drawing.crank is a plot of the crank link
%       leg_drawing.vertices is a cell array, where each element corresponds
%       to a plot of one of the vertices in the linkage
function update_leg_drawing(complete_vertex_coords, leg_drawing, leg_params)
    % store connections as separate vectors, indexable with one value
    connections_1 = leg_params.link_to_vertex_list(:,1);
    connections_2 = leg_params.link_to_vertex_list(:,2);

    % convert vertex_coords vector into an easier-to-handle matrix
    vertices = column_to_matrix(complete_vertex_coords);

    %iterate through each link, and update corresponding link plot
    %linkage_index is the label of the current link
    for linkage_index = 1:leg_params.num_linkages

        % % method that does not use column_to_matrix     
        % x1 = complete_vertex_coords(A*2-1);
        % y1 = complete_vertex_coords(A*2);
        % x2 = complete_vertex_coords(B*2-1);
        % y2 = complete_vertex_coords(B*2);
        
        A = connections_1(linkage_index);
        B = connections_2(linkage_index);

        x1 = vertices(A, 1);
        x2 = vertices(B, 1);
        y1 = vertices(A, 2);
        y2 = vertices(B, 2);

        %line_x and line_y should both be two element arrays containing
        %the x and y coordinates of the line segment describing the current link
        line_x = [x1 x2];
        line_y = [y1 y2];
        set(leg_drawing.linkages{linkage_index},'xdata',line_x,'ydata',line_y); 
    end

    %iterate through each vertex, and update corresponding vertex plot
    for vertex_index = 1:leg_params.num_vertices

        %vertex_index is the label of the current vertex
        %dot_x and dot_y should both be scalars
        %specifically the x and y coordinates of the corresponding vertex
        
        dot_x = complete_vertex_coords(vertex_index*2-1);
        dot_y = complete_vertex_coords(vertex_index*2);
        set(leg_drawing.vertices{vertex_index},'xdata',dot_x,'ydata',dot_y); 
    end

    x1 = complete_vertex_coords(1);
    y1 = complete_vertex_coords(2);
    v0 = leg_params.vertex_pos0;
    x0 = v0(1);
    y0 = v0(2);
    %crank_x and crank_y should both be two element arrays
    %containing the x and y coordinates of the line segment describing the crank
    crank_x = [x0 x1];
    crank_y = [y0 y1];
    
    set(leg_drawing.crank,'xdata',crank_x,'ydata',crank_y);
end