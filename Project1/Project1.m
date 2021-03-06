% Burak Morali
% IFT6521 - Project 1
% Dynamic Programming

clc;clear;close all

% Load data
IncidenceMatrix = spconvert(load('Incidence.txt'));
LengthsMatrix = spconvert(load('Lengths.txt'));

numberofiterations=16;
results=zeros(4,numberofiterations);

for i=1:numberofiterations
    % Selection of random start and end nodes
    startnode=ceil(size(IncidenceMatrix,1)*rand());
    endnode=ceil(size(IncidenceMatrix,1)*rand());
    
    % Dijkstra Method
    tic
    [distance, pathdij, solution]=dijkstra(startnode, endnode, IncidenceMatrix, LengthsMatrix);
    results(1,i)=toc;
    
    if solution ==true
        fprintf('Dijkstra : from %d to %d, %d steps, total distance %f, %f seconds\n',startnode,endnode,length(pathdij),distance,toc)
    else
        fprintf('Dijkstra : from %d to %d, there is no solution\n',startnode,endnode)
    end
    
    % FIFO Method
    tic
    [distance, pathfifo, solution]=fifo(startnode, endnode, IncidenceMatrix, LengthsMatrix);
    results(2,i)=toc;
    
    if solution ==true
        fprintf('FIFO : from %d to %d, %d steps, total distance %f, %f seconds\n',startnode,endnode,length(pathfifo),distance,toc)
    else
        fprintf('FIFO : from %d to %d, there is no solution\n',startnode,endnode)
    end
    
    % LIFO Method
    tic
    [distance, pathlifo, solution]=lifo(startnode, endnode, IncidenceMatrix, LengthsMatrix);
    results(3,i)=toc;
    
    if solution ==true
        fprintf('LIFO : from %d to %d, %d steps, total distance %f, %f seconds\n',startnode,endnode,length(pathlifo),distance,toc)
    else
        fprintf('LIFO : from %d to %d, there is no solution\n',startnode,endnode)
    end
    
    if isequal(pathdij,pathfifo)==1 && isequal(pathdij,pathlifo)==1
        fprintf('Dijkstra, FIFO and LIFO have matching paths from %d to %d,\n',startnode,endnode)
        results(4,i)=1;
    else
        fprintf('Dijkstra, FIFO and LIFO have DIFFERENT paths from %d to %d,\n',startnode,endnode)
        results(4,i)=0;
    end
end
