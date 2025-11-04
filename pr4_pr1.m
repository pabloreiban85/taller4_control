clc; clear;
R = 100;      % Resistencia
L = 0.1;      % Inductancia
Cap = 1e-6;   % Capacitancia

A = [0 1; -1/(L*Cap) -R/L];  % Matriz A
B = [0; 1/L];                % Matriz B
C = [1 0];                   % Matriz C
%C = [0 1; 1 0];             % Matriz C para tener corriente
D = 0;                       % Matriz D

sys = ss(A,B,C,D);           % Espacio de Estados

subplot(2,1,1);
step(sys);                   % Respuesta al escalon unitario
xlabel('Time [s]'); ylabel('Voltaje Capacitor [V]');
subplot(2,1,2);
impulse(sys);                % Respuesta al impulso
xlabel('Time [s]'); ylabel('Voltaje [V]');

 
 
 
 