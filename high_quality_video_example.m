%Short example demonstrating how to create a MATLAB animation
%In this case, a square moving along an elliptical path
%This version also store the animation in a vide.
function high_quality_video_example()
    %define location and filename where video will be stored
    %written a bit weird to make it fit when viewed in assignment
    %you will need to change the path and file name for your own purposes
    mypath1 = 'C:\Users\kyue\OneDrive - Olin College of Engineering\Documents\MATLAB\Numerical Methods\Newton-s-Method-for-Multiple-Dimensions'
    fname='strandbeest_animation.avi';
    input_fname = [mypath1,fname];
    
    %create a videowriter, which will write frames to the animation file
    writerObj = VideoWriter(input_fname);
    
    %must call open before writing any frames
    open(writerObj);
    
    
    clf
    fig1 = figure(1)
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
    
    frames = 1:100000;
    for t = frames

        theta = pi/120*t% loop through using frames

        % can output exit flag (for testing)
        vertex_coords_root = compute_coords(vertex_coords_guess, leg_params, theta);

        % this function is just a template right now
        update_leg_drawing(vertex_coords_root, leg_drawing, leg_params);
        drawnow;
        %capture a frame (what is currently plotted)
        current_frame = getframe(fig1);
        
        %write the frame to the video
        writeVideo(writerObj,current_frame);
    end
    
    %must call close after all frames are written to save the video
    close(writerObj);
end
