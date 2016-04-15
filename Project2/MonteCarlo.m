function [averageprofit]=MonteCarlo(d,L,phi,sigma,P,r,alpha,Z,numberofiter)

% Monte-Carlo Simulation

% Counting total profit
totalprofit=0;

% Iterations of the same test
for i=1:numberofiter
    
    % Initialize problem
    Zt=d;counter=0;alphatemp=inf;
    
    % Checks if stop conditions are fulfilled
    while (d-Zt)<alphatemp && counter<L
        % Calculates next value
        Zt=normrnd((P+phi-P*phi)*Zt,sigma);
        counter=counter+1;
        % Rounds to find the equivalent value in discreet space
        Zt=round(Zt,1);
        n= find(Zt==Z);
        % Finds barrier to respect for next iteration
        alphatemp=alpha(n,counter);
    end % Sums up profits
    totalprofit=(d-Zt)*((1+r)^(L-counter))+totalprofit;
end
averageprofit=totalprofit/numberofiter;

end

