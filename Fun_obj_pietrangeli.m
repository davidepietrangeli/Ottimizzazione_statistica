%Creo la funzione obiettivo del mio problema
%Il vettore di variabili X è posto uguale ad [Yi,Sij,Xi1,Xi2] ed è quindi un
%vettore di dimensione 1x75 grazie alla trasformazione delle Sij in variabili
%a singolo indice secondo la regola canonica (S1-1 S1-2 ... S1-12 S2-1
%S2-2 ...)

function f = fobj(X,C1,C2)
f = 0;

%Costo di costruzione
for i=1:5 
    f = f + 150000000 + 150000000*(X(i));
end

%Costo atteso di servizio
vect_s = 5;
for i=1:5 %numero di centri
    for j=1:12 % numero di aeroporti
        vect_s=vect_s+1; %indice necessario per la trasformazione delle Sij in variabili a singolo indice
        f = f + 50*X(vect_s)*2*6731*asin(sqrt((sind((X(i+65)-C1(j))/2))^2+cosd(X(i+65))*cosd(C1(j))*(sind(X(i+70)-C2(j))/2)^2));
    end
end
end