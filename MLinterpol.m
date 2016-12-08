function [ S ] = MLinterpol( A,c )
%MLINTERPOL Interpolation of ML component
    %
    % Input
    % A : sample points
    % c : scores
    %
    % Output
    % S : interpolation function

    S = scatteredInterpolant(A(:,1),A(:,2),A(:,3),c');
end

