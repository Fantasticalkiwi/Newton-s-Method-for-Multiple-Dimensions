%Short example demonstrating how to create a MATLAB animation
%In this case, a square moving along an elliptical path
%This version also store the animation in a vide.
function high_quality_video_example()
    %define location and filename where video will be stored
    %written a bit weird to make it fit when viewed in assignment
    %you will need to change the path and file name for your own purposes
    mypath1 = 'C:\Users\kyue\OneDrive - Olin College of Engineering\Documents\MATLAB\Numerical Methods\Newton-s-Method-for-Multiple-Dimensions';
    fname='strandbeest_animation.avi';
    input_fname = [mypath1,fname];
    
    %create a videowriter, which will write frames to the animation file
    writerObj = VideoWriter(input_fname);
    
    %must call open before writing any frames
    open(writerObj);
    
    % initialize the current figure and save as object
    clf
    fig1 = figure(1);

    % forces the video to be high-quality
    set(fig1,'units','pixels','position',[0 0 1440 1080])

    % set up the plot
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
    leg_params = define_leg_parameters();
    xfoot = [];
    yfoot = [];

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

        %capture a frame (what is currently plotted)
        current_frame = getframe(fig1);
        
        %write the frame to the video
        writeVideo(writerObj,current_frame);

    end
    
    %must call close after all frames are written to save the video
    close(writerObj);
end
