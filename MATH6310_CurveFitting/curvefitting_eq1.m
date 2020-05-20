clear all;clc;close all;
%% data points 
x1 = [0.4313, 7.223, 1.088, 9.032, 3.848, 6.835, 2.588, 2.13, 6.601, 8.981];
y1 = [0.7732, 92.35, 3.455, 136.5, 31.48, 88.1, 15.93, 11.77, 78.3, 130.5];
n_data = length(x1);
scatter(x1,y1,"filled")

%% construct polynomial, piecewise linear, and cubic spline functions using interp1
pn = @(x)polyval(polyfit(x1,y1,2),x);    % polynomial interpolation function
pl_interp = @(x)interp1(x1,y1,x);               % piecewise linear interpolation function
pcS_interp = @(x)interp1(x1,y1,x,'spline');     % cubic spline interpolation function

%% plot polynomial, piecewise linear, and cubic spline interpolations given x and y data above
x_plot = min(x1):0.01:max(x1);
figure;
plot(x1,y1,'ko','displayname','Data','linewidth',2,'markersize',7)
hold on
plot(x_plot, pn(x_plot),'Color','#0072BD','displayname','polynomial degree 2','linewidth',2)
plot(x_plot,pl_interp(x_plot),'displayname','piecewise linear','linewidth',2)
plot(x_plot,pcS_interp(x_plot),'displayname','cubic spline','linewidth',2)
hold off
l=legend;
set(gca,'fontsize',16)
set(l,'location','best','fontsize',18)

%% calculate error on polynomial interpolations
error_array = zeros(1,9);
for i=1:9
    pn_error = @(x)polyval(polyfit(x1,y1,i),x);
    error = sum((pn_error(x1) - y1).^2)/10;
    error_array(i) = error;
end
% plot best fit line and confidence interval
[p, S] = polyfit(x1,y1,2);
[y_plot, delta] = polyval(p, x_plot, S);
figure;
plot(x1,y1,'ko','displayname','Data','linewidth',2,'markersize',7)
hold on
plot(x_plot, y_plot,'b', 'linewidth',2);
plot(x_plot, y_plot - 2*delta,'k--', 'linewidth',2);
plot(x_plot, y_plot + 2*delta,'k--', 'linewidth',2);
hold off
l = legend('Data Points', 'Fitted Polynomial','95% Prediction Interval');
grid on;
xlabel('X');
ylabel('Y');
set(l,'location','best','fontsize',18)


%% Test Data
test_x = [5.023,1.684,8.65,3.278,5.077];
test_y = [49.67,8.059,124.8,23.33,53.54];

figure;
plot(test_x,test_y,'bo','linewidth',2);
hold on
plot(x1,y1,'ko','linewidth',2);
plot(x_plot, y_plot,'k', 'linewidth',2);
legend("Test Data Points","Train Data Points","Best Fit Polynomial Degree 2");
xlabel('X')
ylabel('Y')
grid on 

err = 0;
for i=1:5
    err = err + (test_y(i) - pn(test_x(i))).^2;
end
err = err/5;
err
%print -depsc epsFig;