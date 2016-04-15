% Burak Morali - 20041108
% Dynamic Programming - IFT6521
% Project 2 - Optimal Stopping Time

% The code for the computation of alpha may take a bit of time. Do not
% panic

clear;clc;close all

% Constants used
d=2.5;
L=10;
phi=0.9;
sigma=1;
P=0.05;
r=0.5/100;

% Here we calculate the optimal stopping times for 
[alpha,Z]=AlphaCalculation(d,L,phi,sigma,P,r);

% Validation using optimal alpha
averageprofitopt=MonteCarlo(d,L,phi,sigma,P,r,alpha,Z,10000);

% Validation using the initial alpha barriers throughout the problem
alphausinginitialvector=repmat(alpha(:,1),1,L);
averageprofitinitial=MonteCarlo(d,L,phi,sigma,P,r,alphausinginitialvector,Z,10000);

% Validation using the final alpha barriers throughout the problem
alphausingfinalvector=repmat(alpha(:,L),1,L);
averageprofitfinal=MonteCarlo(d,L,phi,sigma,P,r,alphausingfinalvector,Z,10000);

% Figures and stuff
figure(1)
for i=1:L
plot(Z,alpha(:,i))
hold on
xlabel('Z_t')
ylabel('\alpha_t')
title('Optimal Stopping time - Z_t vs. \alpha_t')
end
if L==10
   legend('Iteration 1','Iteration 2','Iteration 3','Iteration 4','Iteration 5','Iteration 6','Iteration 7','Iteration 8','Iteration 9','Iteration 10') 
end
