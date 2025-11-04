clc; clear;
global R L Cap u


R = 100;      % Resistencia 
L = 0.1;      % Inductancia 
Cap = 1e-6;   % Capacitancia 

A = [0 1; -1/(L*Cap) -R/L]; % Matriz de Estado
B = [0; 1/L];               % Matriz de Entrada
C = [1 0];                   % Matriz C
%C = [0 1; 1 0];             % Matriz C para tener corriente
D = 0;                       % Matriz D


ts = 0.015;   % Tiempo de simulacion
tspan = [0 ts];
u = 1;        % Voltaje de entrada (escalón)
x0 = [0; 0];  % Condiciones iniciales

[t, X] = ode45(@(t,x) modelRLC(t, x, A, B, u), tspan, x0);

y = C * X.' + D * u;  % Voltaje sobre el capacitor

plot(t,y, 'LineWidth',2); grid on;
xlabel('Time [s]');
ylabel('Voltaje Capacitor [V]');

% ---------- FUNCION DEL MODELO ----------
function dx = modelRLC(ts, X, A, B, u)
 dx = A * X + B * u; % Ecuación de Estado
 end
