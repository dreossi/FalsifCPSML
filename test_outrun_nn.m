init_pics;
B.SetTime(0:.1:15);
STL_ReadFile('AEBS_specs.stl');

%% nominal traj (gets to cruise at 40 mph, obstacle at 150m)  
B.SetParam({'z_p0'}, 150); % obstacle at 150m, not moving
B.SetParam({'speed_s0', 'throttle_u0'}, [40, 11]); 

B.SetParam('visu_enabled', 0);
B.SetParam('nn_enabled', 0);

B.Sim();
B.PlotSignals({'speed_s_mph','speed_p_mph', 'p_long', 'throttle_AEBS', 'brake_AEBS', 'miss'});

% ok, didn't crash
B.CheckSpec(dont_crash) 

%% Varying initial speed of ego car and position of obstacle - no miss
Bmulti = B.copy();
Bmulti.SetParam({'miss_base_value', 'miss_pulse_amp'}, [0 0]);
Bmulti.Sys.Parallel = 1;
Bmulti.SetParamRanges({'z_p0', 'speed_s0'}, [0 60; 0 40]);
Bmulti.GridSample(40);
Bmulti.Sim();
Bmulti.PlotRobustMap(dont_crash)


%% Varying initial speed of ego car and position of obstacle - always miss
Bmulti_m = B.copy();
Bmulti_m.SetParam('miss_base_value', 1);
Bmulti_m.Sys.Parallel = 1;
Bmulti_m.SetParamRanges({'z_p0', 'speed_s0'}, [0 60; 0 40]);
Bmulti_m.GridSample(40);
Bmulti_m.Sim();
Bmulti_m.PlotRobustMap(dont_crash)
