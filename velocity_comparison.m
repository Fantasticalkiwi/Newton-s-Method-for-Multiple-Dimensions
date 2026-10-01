function velocity_comparison()
    % initialize parameters: number of iterations, strandbeest linkages,
    % angles to test over, input parameters, empty lists for storing data
    num = 500;
    leg_params = define_leg_parameters();
    theta = linspace(0, 2*pi, num);
    dtheta_dt = -2;
    
    vertex_coords_guess = [...
    [   0;   50];... %vertex 1 guess
    [ -50;    0];... %vertex 2 guess
    [ -50;   50];... %vertex 3 guess 
    [-100;    0];... %vertex 4 guess
    [-100;  -50];... %vertex 5 guess
    [ -50;  -50];... %vertex 6 guess
    [ -50; -100]...  %vertex 7 guess
    ];     

    x = zeros(num,1); 
    y = zeros(num,1);
    xe = zeros(num,1);
    ye = zeros(num,1);
    
    % loop through iterations
    for i = 1:num
        % calculate vertex coordinates
        vertex_coords = compute_coords(vertex_coords_guess, ...
            leg_params, theta(i));

        % use coordinates to calculate vertex velocities
        dVdtheta_explicit = compute_velocities_explicit(vertex_coords, ...
            leg_params,theta(i),dtheta_dt);

        dVdtheta = compute_velocities(vertex_coords, ...
            leg_params, theta(i));

        % index the leg tip velocities from each calculation method
        x(i) = dVdtheta(13);
        y(i) = dVdtheta(14);
        xe(i) = dVdtheta_explicit(13);
        ye(i) = dVdtheta_explicit(14);
    end

    % plot lines for each method, comparing x-component and theta
    clf
    fig1 = figure(1);
    hold on
    plot(theta,x,linewidth=3,color=[0,.4,.8],displayname='Algebraic Solution')
    plot(theta,xe,'--',linewidth=3,color=[.3,.8,1],displayname='Finite Difference Solution')
    
    % axis labels, title, legend settings
    xlabel("$X$ Position (-)", Interpreter="latex");
    ylabel("$Y$ Position (-)", Interpreter="latex");
    title("Strandbeest Leg Tip Velocity: Calculation Comparison ($X$-component)", Interpreter="latex")
    legend(interpreter="latex", location="southwest")

    % style settings for resolution, tick mark font, legend, font size, and
    % axis boundaries
    set(fig1,'units','pixels','position',[0 0 1440 1080])
    set(gca,'TickLabelInterpreter','latex')
    fontsize(scale=2.5)
    axis([theta(1),theta(end),-50,30])

    % do the same for the y-component
    fig2 = figure(2);
    hold on
    plot(theta,y,linewidth=3,color=[0,.8,.4],displayname='Algebraic Solution')
    plot(theta,ye,'--',linewidth=3,color=[.3,1,.8],displayname='Finite Difference Solution')
    
    xlabel("$X$ Position (-)", Interpreter="latex");
    ylabel("$Y$ Position (-)", Interpreter="latex");
    title("Strandbeest Leg Tip Velocity: Calculation Comparison ($Y$-component)", Interpreter="latex")
    legend(interpreter="latex",location="southwest")

    set(fig2,'units','pixels','position',[0 0 1440 1080])
    set(gca,'TickLabelInterpreter','latex')
    fontsize(scale=2.5)
    axis([theta(1),theta(end),-30,35])

end