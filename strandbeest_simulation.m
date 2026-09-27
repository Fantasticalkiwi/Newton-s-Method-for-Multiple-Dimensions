%runs strandbeest simulation
function strandbeest_simulation()
    clf
    figure(1)
    hold on;   %set up the plotting axis
    axis([-115,65,-115,65])
    axis equal;
    leg_params = define_leg_parameters();

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

    leg_drawing = initialize_leg_drawing(leg_params);

    % %your code here
    % %this code will likely involve a loop, where you call
    % %compute_coords at each iteration
    % %you likely will also need to call update_leg_drawing each iteration
    frames = 1:100000;
    for t = frames

        theta = pi/120*t; % loop through using frames

        % can output exit flag (for testing)
        vertex_coords_root = compute_coords(vertex_coords_guess, leg_params, theta);

        % this function is just a template right now
        update_leg_drawing(vertex_coords_root, leg_drawing, leg_params);
        drawnow;
    end
end