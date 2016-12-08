function [ acc, err ] = MLeval( n, S, options )
%MLEVAL evaluation of the approximation
    %
    % Input
    % n : number of tests
    % S : CNN approximation
    % options : CNN options
    %
    % Output
    % acc : accuracy rate
    % err : error rate
    
    % Generate inital picture
    road = 1;   % 1: Desert, 2: country, 3: city
    car = 1;    % 1: BMW, 2: Tesla, 3: Suzuki
   
    % Initialize key labels
    switch options.CNN
        case 'caffe'
            keyClass{1,1} = 'minivan';
            keyClass{1,2} = 0;
            keyClass{2,1} = 'trailer truck';
            keyClass{2,2} = 0;
            keyClass{3,1} = 'moving van';
            keyClass{3,2} = 0;
            keyClass{4,1} = 'jeep';
            keyClass{4,2} = 0;
            keyClass{5,1} = 'recreational vehicle';
            keyClass{5,2} = 0;
        case 'tensorflow'
            keyClass{1,1} = 'racer';
            keyClass{1,2} = 0;
            keyClass{2,1} = 'race car';
            keyClass{2,2} = 0;
            keyClass{3,1} = 'racing car';
            keyClass{3,2} = 0;
            keyClass{4,1} = 'sport car';
            keyClass{4,2} = 0;
            keyClass{5,1} = 'sports car';
            keyClass{5,2} = 0;
            fig2class = 'tmp_pic.jpg';
        otherwise
            error('Unknown CNN\n');
    end
    
    
    tp = 0; % true positives
    tn = 0; % true negatives
    fp = 0; % false positives
    fn = 0; % false negatives   
    
    for i=1:n
        i
        test = rand(1,3);      
        figure(1)
        % Generate picture with shift on x-axis
        [ pic, vp, pos_car ] = genPicture([road car],0.5);
        % Shift car on z-axis
        moveImg(pic,pos_car,vp,0.2);  
        f = getframe;
        % Adjust picture brightness
        f = imadjust(f.cdata, [0 1], [0.2*0.8 1]);
        
        switch options.CNN
            case 'caffe'
                fig2class = f;
            case 'tensorflow'
                figure(2)
                imshow(f)
                export_fig(fig2class);
        end
        
        class = classify(fig2class,options);
        yCNN = checkClass(class,keyClass);
        yS = (S(test(1),test(2),test(3)) ~= 0);
        
        if yCNN && yS
            tp = tp + 1;
        end
        if ~yCNN && yS
            fp = fp + 1;
        end
        if yCNN && ~yS
            fn = fn + 1;
        end
        if ~yCNN && ~yS
            tn = tn + 1;
        end        
    end
    
    acc = (tp + tn)/n;
    err = (fp + fn)/n;

end

