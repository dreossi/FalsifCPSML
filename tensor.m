function [ res ] = tensor( imgPath )
%TENSOR Classifies a picture using Tensorflow
    % Picture must be jpg
    %
    % Input
    % imgPath : path to picture
    %
    % Output
    % res : cell{class,score}
    %
    
    tensorEnv = 'source ~/tensorflowGPU/bin/activate;';
    tensorClass = 'python ~/tensorflowGPU/lib/python2.7/site-packages/tensorflow/models/image/imagenet/classify_image.py';
    command = [tensorEnv tensorClass '  --image_file ' imgPath];
    
    [status,commandOut] = system(command);
    
    if status > 0
        error('TensorFlow call failed')
    end
   
    
    % Parse the result
    outLines = strsplit(commandOut,'\n'); % get lines
    
    % Get rid of warning messages
    i = size(outLines,2)-1;
    classLines = {};
    line = outLines{i};
    while line(1) ~= 'W'
        classLines{end+1} = line;
        i = i-1;
        line = outLines{i};
    end
    classLines = fliplr(classLines);
    
    classi = 1;
    
    for i=1:length(classLines)
        line = classLines{i};
        
        % Extract the score
        score = line(end-17:end);
        score = score(end-7:end-1);
        line = line(1:end-17);
        classes = strsplit(line,',');
        
        % Remove white spaces
        for j=1:length(classes)
            class = classes{j};
            if class(1) == ' '
                class = class(2:end);
            end
            if class(end) == ' '
                class = class(1:end-1);
            end
            res{classi,1} = class;
            res{classi,2} = str2double(score);
            classi = classi + 1;
        end        
    end
end

