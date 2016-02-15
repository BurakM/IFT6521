function [totdistance, path, solution]= dijkstra(startnode, endnode, IncidenceMatrix, LengthsMatrix)
% Indexing problem
[indexi,indexj,value] = find(IncidenceMatrix);

% Initialize problem
currentnode=startnode;

% Distance Matrix (d in class notes)
dist=ones(size(IncidenceMatrix,1),1)*inf;
dist(startnode)=0;

% Label if node has been visited
T=zeros(size(IncidenceMatrix,1),1);

% Previous node matrix (v in class notes)
previousnode=zeros(size(IncidenceMatrix,1),1);flag=0;

% Main loop - exists if currentnode is the target node or if algo can't
% find any new nodes to visit (no solution to problem)
while currentnode~=endnode && flag==0;
    % Search for edges that we can test (avoids looping through junk)
    listtotest=find(indexi==currentnode);
    % Loops through the edges that are testable
    for i=1:length(listtotest)
        % Verifies if node has been visited before
        if  T(indexj(listtotest(i)))==0
            % Assigns new D_i value to node (update etiquette)
            if (LengthsMatrix(currentnode,indexj(listtotest(i)))+dist(currentnode))<dist(indexj(listtotest(i)))
                dist(indexj(listtotest(i)))=LengthsMatrix(currentnode,indexj(listtotest(i)))+dist(currentnode);
                % Assigns node's optimal previous node (v_i in class notes)
                previousnode(indexj(listtotest(i)))=currentnode;
            end
        end
    end
    % Removes node from unvisited list
    T(currentnode)=1;
    
    % Picks new node to visit
    [totdistance,nextnode]=min(dist+T*realmax);
    % Exit condition (if there is no new node to vist and the endnote hasn't
    % been visited - no solution)
    if min(dist+T*realmax)>=realmax
        flag=1;
    end
    currentnode=nextnode;
end

% There is a solution
if flag==0;
    % Establishing path
    path=currentnode;
    while previousnode(currentnode)~=0
        path=[previousnode(currentnode), path];
        currentnode=previousnode(currentnode);
    end
    
    % Validation of the path (goes from initial to final node
    validationdist=0;
    for i=1:(length(path)-1)
        validationdist=validationdist+LengthsMatrix(path(i),path(i+1));
        if IncidenceMatrix(path(i),path(i+1))==0
            error('The path vector doesn''t work')
        end
        
    end
    
    % Validating that the total distance calculated matches d_t
    if validationdist~=totdistance
        error('Mismatch between validation distance and total distance')
    end
    
    % Validates that the path starts and ends at the right spot
    if path(1)~=startnode || path(length(path))~=endnode
        error('Path doesn''t go from start node to end node')
    end
    
    solution=true;
    
else
    % No solution
    clear path totdistance
    totdistance=0;
    path=[];
    solution=false;
end
