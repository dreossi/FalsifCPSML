%% AEBS constants 

z_p0 = 150; % initial distance between two vehicles
speed_p0 = 20; 
speed_s0 = 10;
a_max = 2;        % max deceleration  
f_mu = 1;         % some fiction coeff. not really useful
T_h_delay = 0.1;  % human time reaction
T_s_delay = 0.01; % system time reaction 

TTC_inv_safe = 0.2;     
TTC_inv_warning = 0.5;

x_safe = 1;
x_warning = 0;

warn_brake =  100;    % warning braking 
panic_brake = 1000;   % emergency braking value  

nn_enabled    = 0; % set to 1 to have NN in the loop 
visu_enabled  = 0;  % set to 1 to get inimitable outrun animation
brightness_u0 = 0;
x_p_shift_u0  = 0;
miss_u0 = -1;

thresh = 0.01;

x_p0 = 10;

frame_number = 0;

