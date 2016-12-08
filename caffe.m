function [ res ] = caffe( img )
%CAFFE Classifies a picture using Caffe with Alexnet
    % Picture must be png
    %
    % Input
    % imgPath : path to picture
    %
    % Output
    % res : cell{class,score}
    %

    KBESTCLASSES = 15;  
    
    % Load NN model
    net = alexnet;
    sz = net.Layers(1).InputSize;
    labels = net.Layers(25).ClassNames;
    
    % Shrink picture (required by Caffe)
    % I = imread(imgPath);
    I = imresize(img,[sz(1) sz(2)]);
    
    % Run neural network
    classification = predict(net,I);
    [scores,indices] = sort(classification,'descend');
        
    for j=1:KBESTCLASSES
        res{j,1} = labels{indices(j)};
        res{j,2} = scores(j);
    end
end

