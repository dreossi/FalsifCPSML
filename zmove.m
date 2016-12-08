function [ mov_img ] = zmove( img, vp, move )
%ZMOVE move figure on z-axis
    % img: corners of the picture
    % vp: vanishing point
    % move: [0,1] how much to move wrt to img (0) and vp (1)
    
    % Slopes and offsets of perspective lines
    ms = zeros(1,4);    
    bs = zeros(1,4);    
    
    % Compute perspective lines
    for i=1:4
        [m,b] = line2pts(img(i,:),vp);
        ms(i) = m;
        bs(i) = b;
    end
    
    % Compute moved coordinates shrinking them wrt to the perspective
    mov_p1 = [(move*(vp(1)-img(1,1)) + img(1,1)) (move*(vp(2)-img(1,2)) + img(1,2))];    
    mov_p2 = [ (bs(2)-mov_p1(2))/(-ms(2)) mov_p1(2)];  
    mov_p3 = [ mov_p2(1) ms(3)*mov_p2(1)+bs(3)];
    mov_p4 = [ mov_p1(1) ms(4)*mov_p1(1)+bs(4)];
    
    % Shifted coordinates
    mov_img = [mov_p1 ; mov_p2 ; mov_p3 ; mov_p4];
end

