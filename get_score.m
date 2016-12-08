function [ max_score ] = get_score( classification, key_labels )
%GET_SCORE Get the max score in the classification associated with given
    %key_labels
    %
    % Input 
    % classification : {label,score} sorted ascending score
    % key_labels : {label} to look for
    %
    % Output
    % max_score : of key_labels in classification
 
    max_score = 0;
    for i=1:length(classification)
        for j=1:length(key_labels)
            if strcmp(classification{i,1},key_labels{j})
                max_score = max_score+classification{i,2};
            end
        end
    end
end

