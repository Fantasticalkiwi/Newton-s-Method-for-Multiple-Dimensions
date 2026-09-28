%runs strandbeest simulation
function strandbeest_simulation()

    %set up the plotting axis
    clf
    figure(1)
    hold on;
    axis([-115,65,-115,65])
    axis equal;
    xlabel("X Position (-)", Interpreter="latex");
    ylabel("Y Position (-)", Interpreter="latex");
    title("Strandbeest Simulation", Interpreter="latex")

    %column vector of initial guesses
    %for each vertex location.
    %in form: [x1;y1;x2;y2;...;xn;yn]
    vertex_coords_guess = [...
    [   0;   50];... %vertex 1 guess
    [ -50;    0];... %vertex 2 guess
    [ -50;   50];... %vertex 3 guess 
    [-100;    0];... %vertex 4 guess
    [-100;  -50];... %vertex 5 guess
    [ -50;  -50];... %vertex 6 guess
    [ -50; -100]...  %vertex 7 guess
    ];   

    % initialize parameters
    leg_params = define_leg_parameters();
    leg_drawing = initialize_leg_drawing(leg_params);
    xfoot = [];
    yfoot = [];

    %this code will likely involve a loop, where you call
    %compute_coords at each iteration
    %you likely will also need to call update_leg_drawing each iteration
    frames = 1:500;
    for t = frames

        % loop through using frames
        theta = pi/100*t; 

        % calculate the vertex coordinates
        vertex_coords_root = compute_coords(vertex_coords_guess, leg_params, theta);

        % use the new coordinates to update the legs
        update_leg_drawing(vertex_coords_root, leg_drawing, leg_params);

        % lock the axes in place
        axis([-115,65,-115,65])

        % store the foot vertex and plot as an overlay
        foot = leg_drawing.vertices{7,1};
        xfoot(end+1) = foot.XData;
        yfoot(end+1) = foot.YData;
        plot(xfoot,yfoot)
        plot(0,0, 'b.', MarkerSize=30)
        plot(-38,-7.8, 'b.', MarkerSize=30)

        drawnow;
    end
end