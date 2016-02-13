function [totdistance, path, solution]= dijkstra(startnode, endnode, IncidenceMatrix, LengthsMatrix)
% Initialize problem
currentnode=startnode;

% Distance Matrix (d in class notes)
dist=ones(size(IncidenceMatrix,1),1)*inf;
dist(startnode)=0;

% Label if node has been visited
T=zeros(size(IncidenceMatrix,1),1);

% Previous node matrix (v in class notes)
previousnode=zeros(size(IncidenceMatrix,1),1);flag=0;

% Main loop
while currentnode~=endnode && flag==0;
    for i=1:size(IncidenceMatrix,1)
        if IncidenceMatrix(currentnode,i)==1 && T(i)==0
            if (LengthsMatrix(currentnode,i)+dist(currentnode))<dist(i)
                dist(i)=LengthsMatrix(currentnode,i)+dist(currentnode);
                previousnode(i)=currentnode;
            end
        end
    end
    T(currentnode)=1;
    [totdistance,nextnode]=min(dist+T*realmax);
    if min(dist+T*realmax)>=realmax
        flag=1;
    end
    currentnode=nextnode;
end

% Establishing path
path=currentnode;
while previousnode(currentnode)~=0
    path=[previousnode(currentnode), path];
    currentnode=previousnode(currentnode);
end

% Validation
validationdist=0;
for i=1:(length(path)-1)
    validationdist=validationdist+LengthsMatrix(path(i),path(i+1));
    if IncidenceMatrix(path(i),path(i+1))==0
        error('The path vector doesn''t work')
    end
    
end
if validationdist~=totdistance
    error('Mismatch between validation distance and total distance')
end
if path(1)~=startnode || path(length(path))~=endnode
    error('Path doesn''t go from start node to end node')
end

% No solution
if flag==1;
    clear path totdistance
    totdistance=0;
    path=[];
    solution=false;
    else
      solution=true;
end

end