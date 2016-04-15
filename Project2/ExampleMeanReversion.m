

figure(1)
xmean=90:0.05:110;
ymean=xmean*0.8;

plot(xmean,ymean)
hold on
title('Example of mean reversion (statistical arbitrage)')
xlabel('Product X (in $)')
ylabel('Product Y (in $)')

xrand=rand(length(xmean),1)*20+90;
yrand=xrand*0.8+normrnd(0,1,length(xmean),1);
plot(xrand,yrand,'.')
legend('Linear regression','Actual prices')