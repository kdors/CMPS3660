clear all;clc;close all;
%% Get data points
y1 = datetime(2020,03,09,8,0,0);
y2 = datetime(2020,03,30,8,0,0);
y = y1:y2;
x1 = [1,5,10,15,26,53,75,94,136,196,249,326,418,451,567,675,827,997,1170,1298,1350,1480];
dummy_points = 1:22;

% figure
% plot(y,x1,'ko','markerfacecolor','k');
% xlabel('Day')
% ylabel('Number of Cases')
% grid on

%figure
x_plot = 0:0.5:35;
% plot(x_plot,polyval(polyfit(dummy_points,x1,2),x_plot),'linewidth',2);
% hold on 
% plot(x_plot,polyval(polyfit(dummy_points,x1,3),x_plot),'linewidth',2);
% plot(x_plot,polyval(polyfit(dummy_points,x1,4),x_plot),'linewidth',2);
% plot(x_plot,49.99.*exp(0.159.*x_plot),'linewidth',2);
% plot(x_plot,1678.*exp(-((x_plot-25.58)./10.39).^2),'linewidth',2);
% plot(dummy_points,x1,'ko','markerfacecolor','k');
% hold off
% l = legend("Polynomial Degree 2", "Polynomial Degree 3", "Polynomial Degree 4", "Exponential","Gaussian","Data Points")
% xlabel('Day');
% ylabel('Number of Cases');
% grid on


%% plot test data
z1 = datetime(2020,03,31,8,0,0);
z2 = datetime(2020,4,13,8,0,0);
z = z1:z2;

x2 = [1834,2270,3148,3476,3966,4066,4565,4942,5070,5242,5416,5535,5600,5651];
x = cat(2,x1,x2);
dummy_points_test = 1:36;
figure
plot(dummy_points_test,x,'ro','markerfacecolor','r');
hold on 
plot(x_plot,polyval(polyfit(dummy_points,x1,2),x_plot),'linewidth',2);
hold on 
plot(x_plot,polyval(polyfit(dummy_points,x1,3),x_plot),'linewidth',2);
plot(x_plot,polyval(polyfit(dummy_points,x1,4),x_plot),'linewidth',2);
plot(x_plot,49.99.*exp(0.159.*x_plot),'linewidth',2);
plot(x_plot,1678.*exp(-((x_plot-25.58)./10.39).^2),'linewidth',2);
plot(dummy_points,x1,'ko','markerfacecolor','k');
xlabel('Day')
ylabel('Number of Cases')
l = legend("Test Data", "Polynomial Degree 2", "Polynomial Degree 3", "Polynomial Degree 4", "Exponential","Gaussian","Data Points");
grid on
hold off
print -depsc epsFig;