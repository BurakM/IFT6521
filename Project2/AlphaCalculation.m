function [alpha,Z]=AlphaCalculation(d,L,phi,sigma,P,r)

% Discretization of Z space
Z=(d-3*L*sigma):0.1:(d+3*L*sigma);
% For some odd reason, fucking Matlab was being a bitch about vector Z.
% There were weird rounding errors that would introduce 10^-16 bullshit
% that made me spend about a day fucking around with the code to find.
% Sorry for the language.
Z=round(Z,1);

% Calculation of distribution mean
mu=zeros(length(Z),L);
m=length(Z);n=L;
for j=1:n
    for i=1:m
        mu(i,j)=(P+phi-P*phi)*Z(i);
    end
end

% Initialization of Alpha matrix
alpha=zeros(length(Z),L);
for i=1:m
    alpha(i,L)=(d-Z(i));
end

% Calculation of alpha
for j=(n-1):-1:1
    for i=1:m
        total=0;
        for k=1:m
            % This simply does the expectancy
            total=total+normpdf(Z(k),mu(i,j),sigma)*((d-Z(k))*((d-Z(k))>alpha(k,j+1))+(alpha(k,j+1))*((d-Z(k))<=alpha(k,j+1)));
        end
        % (1+r) term is the interest. The other absolute value is
        % introduced simply because of how the probability density function
        % is discretisized in Matlab. Makes sure that the alpha value is
        % corretly normalized basically.
        alpha(i,j)=total/(1+r)*abs(Z(2)-Z(1));
    end
end

end
