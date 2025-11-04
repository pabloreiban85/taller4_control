R = 100;      %  R_Ohmios
L = 0.1;      % L_Henrios
Cap = 1e-6;   % C_Faradios

A = [0 1; -1/(L*Cap) -R/L];  % Matriz A
B = [0; 1/L];                % Matriz B
C = [1 0];                   % Matriz C
%C = [0 1; 1 0];             % Matriz D para tener corriente y voltaje
D = 0;                   % Matriz D

% ----- Definición de señal arbitraria  -----
N = 4;                         % número de tramos
tspan = linspace(0, 0.05, N+1); % dividimos 0.05 s en N tramos iguales
u = [0 10 20 30];                  % señal arbitraria (N niveles)

x0 = [0 0];                    % condiciones iniciales

% ----- Simulación por tramos -----
t_total = [];
X_total = [];

%------%--------%---------%

for k = 2:length(tspan)
    % integra el sistema en el tramo [tspan(k-1), tspan(k)] con entrada u(k-1)
    [tk, Xk] = ode45(@(t,x) modelRLC(t, x, A, B, u(k-1)), [tspan(k-1), tspan(k)], x0);

    % guardar resultados
    t_total = [t_total; tk];
    X_total = [X_total; Xk];

    % actualizar condición inicial para siguiente tramo
    x0 = Xk(end,:);
end

%------------------salida------------------------
y = (C * X_total.').';   % y = C*x + D*u, vectorizado
% ----- Graficar -----


plot(t_total, y, 'LineWidth', 2);
grid on;
xlabel('Tiempo [s]');
ylabel('V_c [V]');
title('Respuesta del sistema a una señal arbitraria');

% ---------- Función del modelo en espacio de estados  ----------
function dx = modelRLC(t, x, A, B, u)
    dx = A * x + B * u;   % ecuación de estado
end
