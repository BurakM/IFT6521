function [totdistance, path, solution]= lifo(startnode, endnode, IncidenceMatrix, LengthsMatrix)

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
    i=O(length(O));
    O(length(O))=[];
    % for + if loop that looks for nodes to test
    for j=1:size(IncidenceMatrix,1)
        if IncidenceMatrix(i,j)==1
            % Assigns new D_i value to node (update etiquette)
            if (LengthsMatrix(i,j)+dist(i))<min(dist(j),U)
                dist(j)=LengthsMatrix(i,j)+dist(i);
                % Assigns node's optimal previous node (v_i in class notes)
                previousnode(j)=i;
                % Updates U if tested node is end node, otherwise adds
                % nodes to visit to O list
                if j==endnode
                    U=min(U,dist(j));
                else
                    O=[O,j];
                end
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
    for i=1:(length(path)-1)
        validationdist=validationdist+LengthsMatrix(path(i),path(i+1));
        if IncidenceMatrix(path(i),path(i+1))==0
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