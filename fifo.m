function [totdistance, path, solution]= fifo(startnode, endnode, IncidenceMatrix, LengthsMatrix)
% Indexing problem
[indexi,indexj,value] = find(IncidenceMatrix);

% Distance Matrix (d in class notes)
dist=ones(size(IncidenceMatrix,1),1)*inf;
dist(startnode)=0;

% Open nodes
O=startnode;

% Previous node matrix (v in class notes)
previousnode=zeros(size(IncidenceMatrix,1),1);

% Upper bound on the length of shortest path
U=inf;

% Main loop
while isempty(O)~=1
    % Picks first open node from list and removes it from the list
    currentnode=O(1);
    O(1)=[];
    
    % Search for edges that we can test (avoids looping through junk)
    listtotest=find(indexi==currentnode);
    % Loops through the edges that are testable
    for i=1:length(listtotest);
        % Assigns new D_i value to node (update etiquette)
        if (LengthsMatrix(currentnode,indexj(listtotest(i)))+dist(currentnode))<min(dist(indexj(listtotest(i))),U)
            dist(indexj(listtotest(i)))=LengthsMatrix(currentnode,indexj(listtotest(i)))+dist(currentnode);
            % Assigns node's optimal previous node (v_i in class notes)
            previousnode(indexj(listtotest(i)))=currentnode;
            % Updates U if tested node is end node, otherwise adds
            % nodes to visit to O list
            if indexj(listtotest(i))==endnode
                U=min(U,dist(indexj(listtotest(i))));
            else
                O=[O,indexj(listtotest(i))];
            end
        end
        
    end
end

% If there is a solution
if U<realmax;
    % Establishing path
    currentnode=endnode;
    path=currentnode;
    while previousnode(currentnode)~=0
        path=[previousnode(currentnode), path];
        currentnode=previousnode(currentnode);
    end
    
    % Validation of the path (goes from initial to final node
    validationdist=0;
    for currentnode=1:(length(path)-1)
        validationdist=validationdist+LengthsMatrix(path(currentnode),path(currentnode+1));
        if IncidenceMatrix(path(currentnode),path(currentnode+1))==0
            error('The path vector doesn''t work')
        end
        
    end
    
    % Validating that the total distance calculated matches d_t
    if validationdist~=U
        error('Mismatch between validation distance and total distance')
    end
    if path(1)~=startnode || path(length(path))~=endnode
        error('Path doesn''t go from start node to end node')
    end
    
    solution=true;
    totdistance=U;
    
else
    % No solution
    clear path totdistance
    totdistance=0;
    path=[];
    solution=false;
end

end

