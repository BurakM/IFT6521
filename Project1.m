% Burak Morali
% IFT6521 - Project 1
% Dynamic Programming

clc;clear;close all

% Load data
IncidenceMatrix = spconvert(load('Incidence.txt'));
LengthsMatrix = spconvert(load('Lengths.txt'));

for i=1:5
    % Selection of random start and end nodes
    startnode=ceil(size(IncidenceMatrix,1)*rand());
    endnode=ceil(size(IncidenceMatrix,1)*rand());
    
    %Dijkstra Method
    [distance, path, solution]=dijkstra(startnode, endnode, IncidenceMatrix, LengthsMatrix);
    if solution ==true
        fprintf('With Dijkstra, we get from %d to %d, in %d steps for a total distance %f\n',startnode,endnode,length(path),distance)
    else
        fprintf('With Dijkstra, from %d to %d, there is no solution\n',startnode,endnode)
    end
end


