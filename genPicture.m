function [ pic, vp, car_coord ] = genPicture( picElements, xshift )
%GENCARPICTURE Generate a car scenario
    % Input
    % picElements : [road car]
    % xshift : shift of the car on the x-axis (0 left, 0.5 center, 1 right)
    %
    % Output
    % vp : vanishing point
    % car_coord : inizial car coordinates
    % pic : the picture
    
    %set(0,'DefaultFigureVisible','off')

    road = picElements(1);
    car = picElements(2);

    % Background/road picture
    % vp : vanishing point
    % car_pose : inital pose of the car
    switch road
        case 1  % Desert 
            road_file = 'desert.jpg';
            vp = [800 540];
            x = 600*xshift + 200;
            car_pos = [x x+650 600 1000];
        case 2 % Countryside
            road_file = 'countryside.jpg';
            vp = [810 540];
            car_pos = [800 1400 600 1000];
        case 3  % City
            road_file = 'city.jpg';
            vp = [810 675];
            car_pos = [450 1100 700 1100];
        case 4  % Crop desert
            road_file = 'cropped_desert.jpg';
            vp = [75 120];
            car_pos = [100 800 150 700];
        otherwise
            error('Unknown road picture')
    end
    back = imread(road_file);  
    image(back);
    set(gca,'YDir','reverse');
    hold on
    
    % Car picture
    switch car
        case 1  % BMW
            car_file = 'bmw_rear.png';        
        case 2  % Tesla
            car_file = 'tesla_rear.png';
        case 3  % Suzuki
            car_file = 'suzuki_rear.png';    
        otherwise
            error('Unknown car picture')
    end
    [car,~,trans] = imread(car_file);
    pic = image(car_pos(1:2),car_pos(3:4),car);
    set(pic,'AlphaData',trans);  
    
    car_coord = [car_pos(1) car_pos(3) ; car_pos(2) car_pos(3); car_pos(2) car_pos(4); car_pos(1) car_pos(4)];            
    
end

