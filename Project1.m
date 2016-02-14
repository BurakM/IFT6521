% Burak Morali
% IFT6521 - Project 1
% Dynamic Programming

clc;clear;close all

% Load data
IncidenceMatrix = spconvert(load('Incidence.txt'));
LengthsMatrix = spconvert(load('Lengths.txt'));

parfor i=1:5
    % Selection of random start and end nodes
    startnode=ceil(size(IncidenceMatrix,1)*rand());
    endnode=ceil(size(IncidenceMatrix,1)*rand());
    
    % Dijkstra Method
    tic
    [distance, path, solution]=dijkstra(startnode, endnode, IncidenceMatrix, LengthsMatrix);
    if solution ==true
        fprintf('Dijkstra : from %d to %d, %d steps, total distance %f, %f seconds\n',startnode,endnode,length(path),distance,toc)
    else
        fprintf('Dijkstra : from %d to %d, there is no solution\n',startnode,endnode)
    end
    
    % FIFO Method
    tic
    [distance, path, solution]=fifo(startnode, endnode, IncidenceMatrix, LengthsMatrix);
    if solution ==true
        fprintf('FIFO : from %d to %d, %d steps, total distance %f, %f seconds\n',startnode,endnode,length(path),distance,toc)
    else
        fprintf('FIFO : from %d to %d, there is no solution\n',startnode,endnode)
    end
    
    % LIFO Method
    tic
    [distance, path, solution]=lifo(startnode, endnode, IncidenceMatrix, LengthsMatrix);
    if solution ==true
        fprintf('LIFO : from %d to %d, %d steps, total distance %f, %f seconds\n',startnode,endnode,length(path),distance,toc)
    else
        fprintf('LIFO : from %d to %d, there is no solution\n',startnode,endnode)
    end
end
