clear all;clc;close all;
%% plot data points
t = [1.0,3.0,5.0,7.0,9.0,11.0,13.0,15.0,17.0];
x3 = [0.1168,0.3085,0.4041,0.792,0.9742,0.88,1.409,1.695,1.373];
y3 = [0.01081,-0.0594,0.02837,0.1055,-0.164,0.0009737,0.2359,-0.2279,-0.09356];

figure
subplot(1,2,1);
plot(t,x3,'ko','markerfacecolor','k');
grid on
title('(t,x) Data Points ')
xlabel('t')
ylabel('x')
subplot(1,2,2);
plot(t,y3,'ko','markerfacecolor','k');
grid on
title('(t,y) Data Points')
xlabel('t')
ylabel('y')

%% plot x as a function of t
t_plot = 0:0.25:18;
figure
plot(t,x3,'ko','linewidth',2,'markerfacecolor','k');
hold on
%%subplot(3,1,1);
plot(t_plot,polyval(polyfit(t,x3,1),t_plot),'b','linewidth',2);
plot(t_plot,polyval(polyfit(t,x3,2),t_plot),'g','linewidth',2);
plot(t_plot,polyval(polyfit(t,x3,3),t_plot),'r','linewidth',2);
hold off
xlabel('t')
ylabel('x')
l = legend("Data", "Linear","Quadratic","Cubic");
set(gca,'fontsize',16)
set(l,'location','best','fontsize',18)


%% plot y as a function of t
% Fourier fit
[xData, yData] = prepareCurveData( t, y3 );

% Set up fittype and options.
ft = fittype( 'fourier3' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0 0 0 0 0 0 0 0.392699081698724];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure
% Fourier fit
h = plot( fitresult,'b', xData, yData, 'ko');
hold on 
set(h,'LineWidth',2);
h(1).MarkerSize = 7;
h(1).MarkerFaceColor = 'k';
% Sum of sine fit
plot(t_plot, 0.175*sin(0.9693*t_plot+1.966),'g','linewidth',2);
% Plot tcost fit
plot(t_plot, 0.02.*t_plot.*cos(t_plot),'r','linewidth',2);
legend('Data', 'Fourier','Sum of Sine','tcos(t)','Location', 'best');
% Label axes
xlabel('t');
ylabel('y');
grid on
hold off

%% Test Data
figure
x = 0.09402*t_plot + 0.03746;
y = 0.02*t_plot.*cos(t_plot) ;
plot(x,y,'k','linewidth',2);
hold on
test_t3 = [2.0,4.0,6.0,8.0,10.0,12.0,14.0,16.0];
test_x3 = [0.2364,0.3395,0.5665,0.9583,0.8912,1.071,1.677,1.508];
test_y3 = [-0.01665,-0.05229,0.1152,-0.02328,-0.1678,0.2025,0.03829,-0.3065];
plot(x3,y3,'ko','markerfacecolor','k')
plot(test_x3,test_y3,'ro','markerfacecolor','r')
xlabel('t');
ylabel('(x,y)');
legend('Best Fit Line','Train Data','Test Data');
hold off
grid on
print -depsc epsFig;