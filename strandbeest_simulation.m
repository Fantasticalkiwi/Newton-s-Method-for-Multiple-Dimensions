%runs strandbeest simulation
% INPUT: Boolean determining whether a video should be generated. Input
%   true to make the video.
% OUTPUT: None
function strandbeest_simulation(vidflag)
    if vidflag
        %define location and filename where video will be stored
        %written a bit weird to make it fit when viewed in assignment
        %you will need to change the path and file name for your own purposes
        mypath1 = 'C:\Users\jshen\OneDrive - Olin College of Engineering\2026-27\MechEMath\Newton-s-Method-for-Multiple-Dimensions\';
        fname='strandimation2thesequel.avi';
        input_fname = [mypath1,fname];
        
        %create a videowriter, which will write frames to the animation file
        writerObj = VideoWriter(input_fname);
        
        %must call open before writing any frames
        open(writerObj);
    end
    
    % initialize the current figure and save as object
    clf
    fig1 = figure(1);

    %set up the plotting axis
    hold on;
    axis([-115,65,-115,65])
    axis equal;
    xlabel("$X$ Position (-)", Interpreter="latex");
    ylabel("$Y$ Position (-)", Interpreter="latex");
    title("Strandbeest Simulation", Interpreter="latex")
    set(gca,'TickLabelInterpreter','latex')
    fontsize(scale=2)
    % forces the video to be high-quality
    set(fig1,'units','pixels','position',[0 0 1440 1080])

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
    foot_path = plot([0,0],[0,0],color='r',linewidth=1.25);
    leg_drawing = initialize_leg_drawing(leg_params);
    xfoot = [];
    yfoot = [];
    foot_velocity = quiver([],[],[],[],color=[0,.75,0],linewidth=1.75,MaxHeadSize=0.3);

    % loop through multiple cycles of theta, updating leg segments and
    % velocity plot at every frame
    frames = 900;
    scale = 30;
    c = hsv(frames/scale);
    cloop = repmat(c, [scale,1]);
    for t = 1:frames

        % loop through using frames
        theta = pi/100*t; 

        % calculate the vertex coordinates & velocities
        vertex_coords_root = compute_coords(vertex_coords_guess, leg_params, theta);
        dVdtheta = compute_velocities(vertex_coords_root, leg_params, theta);
        
        % use the new coordinates to update the legs
        update_leg_drawing(vertex_coords_root, leg_drawing, leg_params);

        % store the foot vertex
        foot = leg_drawing.vertices{7,1};
        if theta < 2.5*pi
            xfoot(end+1) = foot.XData;
            yfoot(end+1) = foot.YData;
        end

        % set up plots
        % lock the axes in place
        axis equal;
        axis([-115,65,-115,65])
        
        % plot foot overlay
        set(foot_path,'xdata',xfoot,'ydata',yfoot,'color',cloop(t,:))

        % plot fixed points in another color
        plot(0,0, 'b.', MarkerSize=30)
        plot(-38,-7.8, 'b.', MarkerSize=30)

        % plot velocity overlay
        set(foot_velocity,'xdata',foot.XData,'ydata',foot.YData, ...
            'udata', dVdtheta(13), 'vdata', dVdtheta(14));

        drawnow;

        if vidflag
            %capture a frame (what is currently plotted)
            current_frame = getframe(fig1);
            %write the frame to the video
            writeVideo(writerObj,current_frame);
            if t == frames
                %must call close after all frames are written to save the video
                close(writerObj);
                length(xfoot)
            end
        end
    end
end