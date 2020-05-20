clear all;clc;close all;
%% Plot data points
x4 = [1.86,1.165,1.483,1.921,1.429,1.057,1.925,1.658,1.133,1.533];
y4 = [1.558,1.916,1.633,1.283,1.365,1.092,1.373,1.347,1.705,1.649];
z4 = [1.026,1.446,1.239,1.954,1.908,1.862,1.092,1.977,1.412,1.458];
w4 = [2.475,4.045,3.324,1.745,2.779,2.654,2.709,1.369,3.878,2.865];

x_plot = 1:0.001:2;
figure
subplot(3,1,1);
plot(x4,w4,'ko','markerfacecolor','k');
hold on
plot(x_plot,polyval(polyfit(x4,w4,3),x_plot),'b','linewidth',2);
hold off
legend('Data Points', 'Degree 3 Polynomial');
xlabel('x')
ylabel('w')

subplot(3,1,2);
plot(y4,w4,'ko','markerfacecolor','k');
hold on
plot(x_plot,polyval(polyfit(y4,w4,2),x_plot),'b','linewidth',2);
hold off
legend('Data Points', 'Degree 2 Polynomial');
xlabel('y')
ylabel('w')

subplot(3,1,3);
plot(z4,w4,'ko','markerfacecolor','k');
hold on
plot(x_plot,polyval(polyfit(z4,w4,2),x_plot),'b','linewidth',2);
hold off
legend('Data Points', 'Degree 2 Polynomial');
xlabel('z')
ylabel('w')

print -depsc epsFig;
%% Model fit
% split training data into training set and testing set
error = zeros(4,10);

for i = 1:10
    x4_train = x4;
    x4_train(i) = [];
    y4_train = y4;
    y4_train(i) = [];
    z4_train = z4;
    z4_train(i) = [];
    w4_train = w4;
    w4_train(i) = [];
    
    T = table(transpose(x4_train),transpose(y4_train),transpose(z4_train),transpose(w4_train));
    % fit linear model
    mdl1 = fitlm(T);
    mdl2 = fitlm(T,'Var4~ Var1 + Var1^2 + Var1^3 + Var2 + Var3');
    mdl3 = fitlm(T,'Var4~ Var1 + Var2 + Var2^2 + Var3');
    mdl4 = fitlm(T,'Var4~ Var1 + Var2 + Var3 + Var3^2');
    %evaluate y value at test points and compute error
    T_test = table(x4(i),y4(i),z4(i));
    ypred1 = predict(mdl1,T_test);
    ypred2 = predict(mdl2,T_test);
    ypred3 = predict(mdl3,T_test);
    ypred4 = predict(mdl4,T_test);
    error(1,i) = (ypred1 - w4(i)).^2;
    error(2,i) = (ypred2 - w4(i)).^2;
    error(3,i) = (ypred3 - w4(i)).^2;
    error(4,i) = (ypred4 - w4(i)).^2;
end
% get row with smallest average squared error between predicted and actual
% w value
min_avg_error = sum(error,2)/10;

% fit final linear model
T = table(transpose(x4),transpose(y4),transpose(z4),transpose(w4));
mdl_final = fitlm(T,'Var4~ Var1 + Var2 + Var3');
mdl_final.RMSE

%% Test Data
x4_test = [1.899,1.248,1.03,1.072,1.874];
y4_test = [1.041,1.212,1.001,1.139,1.212];
z4_test = [1.526,1.294,1.972,1.181,1.303];
w4_test = [2.154,4.014,2.244,3.474,2.298];
T_testdata = table(transpose(x4_test),transpose(y4_test),transpose(z4_test),transpose(z4_test));
mdl_final_test = fitlm(T_testdata,'Var4~ Var1 + Var2 + Var3');
mdl_final_test.RMSE