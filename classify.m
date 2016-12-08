function [ res ] = classify( imgPath, options )
%CLASSIFY check if there's one of the specified obects in the given picture
    %
    % Input
    % imgPath : picture to classify
    % options : options.CNN = {tensorflow,caffe}
    % options : options.num_classes, number of classes to return
    %
    % Output
    % res : cell{class,score}
    %
    
    switch options.CNN
        case 'tensorflow'
            res = tensor(imgPath);
        case 'caffe'
            res = caffe(imgPath);            
        otherwise
            error('Unknown neural network')
    end
end

