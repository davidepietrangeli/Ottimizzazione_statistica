clear all
close all
clc

%Vettori delle coordinate degli aeroporti
C1 = [-51 -51 -38 -47 -41 -24 -55 -43 33 -35 26 -28];
C2 = [0 -8 9 -8 -12 -54 -37 -132 -151 -139 -28 -77];

%Vincoli di disuguaglianza: 
% 1. Ciascun centro 'i' può servire al più 60 aviogetti 
% 2. Vincoli di big M

A = [zeros(1,5), ones(1,12), zeros(1,58);
    zeros(1,17), ones(1,12), zeros(1,46);
    zeros(1,29), ones(1,12), zeros(1,34);
    zeros(1,41), ones(1,12), zeros(1,22);
    zeros(1,53), ones(1,12), zeros(1,10);
    -60, zeros(1,69), 1 0 0 0 0;
    0 -60 zeros(1,69), 1 0 0 0;
    0 0 -60 zeros(1,69), 1 0 0;
    0 0 0 -60 zeros(1,69), 1 0;
    0 0 0 0 -60 zeros(1,69), 1];  

b = [60;60;60;60;60;-40;-40;-40;-40;-40];

%Vincoli di uguaglianza:
%1. Ciascun aeroporto necessita manutenzione ad un numero di aviogetti
%prestabilito

Aeq =[zeros(1,5),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1, zeros(1,11),zeros(1,10);
    zeros(1,6),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1, zeros(1,10),zeros(1,10);
    zeros(1,7),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1, zeros(1,9),zeros(1,10);
    zeros(1,8),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1, zeros(1,8),zeros(1,10);
    zeros(1,9),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1, zeros(1,7),zeros(1,10);
    zeros(1,10),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1, zeros(1,6),zeros(1,10);
    zeros(1,11),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1, zeros(1,5),zeros(1,10);
    zeros(1,12),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1, zeros(1,4),zeros(1,10);
    zeros(1,13),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1, zeros(1,3),zeros(1,10);
    zeros(1,14),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1, zeros(1,2),zeros(1,10);
    zeros(1,15),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1, zeros(1,1),zeros(1,10);
    zeros(1,16),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1,zeros(1,11),1,zeros(1,10)];

beq = [30;35;12;18;13;8;15;7;32;40;11;20];

lb = [zeros(1,65), -90 -90 -90 -90 -90 -160 -160 -160 -160 -160];
ub = [ones(1,5), ones(1,60).*40, 90 90 90 90 90 20 20 20 20 20];

options = optimoptions('surrogateopt','MaxFunctionEvaluations',5000);
[x,fval] = surrogateopt(@(X) Fun_obj_pietrangeli(X,C1,C2),lb,ub,[1:65],A,b,Aeq,beq,options)