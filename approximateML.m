function [ A, boolScore, realScore ] = approximateML( nSamps, options )
%APPROXIMATE Approximate CNN on contrained input space
    % Input 
    %
    % nSamps : number of samples
    % options : (CNN) classifier
    %           (samplingMethod) sampling method
    %
    % Output
    % A : sampling points
    % boolScore : boolean classification (car, not car)
    % realScore : label score
    
    % Generate inital picture
    road = 1;   % 1: Desert, 2: country, 3: city
    car = 1;    % 1: BMW, 2: Tesla, 3: Suzuki
    
    % Initialize sampling points
    switch options.samplingMethod
        case 'halton'
            p = haltonset(3);
            A = net(p,nSamps);
        case 'lattice'
            A = lattice(3,nSamps);
        case 'random'
            A = rand(nSamps,3);
        otherwise
            error('Unkwnonw sampling method\n');
    end
   
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
    
    
    boolScore = zeros(1,nSamps);
    realScore = zeros(1,nSamps);
    for i=1:nSamps
        i
        samp = A(i,:);        
        figure(1)
        % Generate picture with shift on x-axis
        [ pic, vp, pos_car ] = genPicture([road car],samp(1));
        % Shift car on z-axis
        moveImg(pic,pos_car,vp,samp(2));  
        f = getframe;
        % Adjust picture brightness
        f = imadjust(f.cdata, [0 1], [samp(3)*0.8 1]);
        
        switch options.CNN
            case 'caffe'
                fig2class = f;
            case 'tensorflow'
                figure(2)
                imshow(f)
                export_fig(fig2class);
        end
        
        class = classify(fig2class,options);
        boolScore(i) = checkClass(class,keyClass);
        realScore(i) = get_score(class,keyClass);
    end
end

