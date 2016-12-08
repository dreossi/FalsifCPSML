init_pics;
B.SetParam({'z_p0', 'speed_s0'}, [40 25]);
B.SetTime(0:.1:6);

%% With perfect info, the car doesn't crash
Bbest = B.copy();
Bbest.SetParam({'miss_base_value', 'miss_pulse_amp'}, [0 0]);
Bbest.Sim()
Bbest.CheckSpec(dont_crash)


%% With no info (for further than 30m), car crashes 
Bworst = B.copy();
Bworst.SetParam('miss_base_value',1);
Bworst.Sim()
Bworst.CheckSpec(dont_crash)

%% with NN in the loop - good
BNN = B.copy();
BNN.SetParam({'visu_enabled','nn_enabled'}, [1 1]);
BNN.SetParam({'x_p_shift_u0'}, 1);
BNN.Sim()
BNN.CheckSpec(dont_crash)

%% with NN in the loop - bad
BNN_bad = B.copy();
BNN_bad.SetParam({'visu_enabled','nn_enabled'}, [1 1]);
BNN_bad.SetParam({'x_p_shift_u0'}, 0.5);
BNN_bad.Sim()
BNN_bad.CheckSpec(dont_crash)


%% 
%Bbx0 = B.copy();
%Bbx0.SetTime([0 .11]);
%Bbx0.SetParam({'visu_enabled', 'nn_enabled'}, [1 1]);
%Bbx0.Sys.Parallel=1;
%Bbx0.SetParamRanges({'brightness_u0', 'x_p_shift_u0'}, [0 1; 0 1]);
%Bbx0.GridSample(3);
%Bbx0.Sim();
%Bbx0.PlotRobustMap(score_ok)

