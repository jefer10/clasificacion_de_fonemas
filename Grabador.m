close all, clear all
vocal = input('Presione 1->a 2->e 3->i 4->o 5->u?')
vocales = ['a';'e';'i';'o';'u'];  
r = audiorecorder (8000,16,1);
inicio = input(['Presione algo para iniciar con la vocal ' vocales(vocal)]);
LPC_C = zeros(12,25);

for i=1:25
    record(r);
    vacio = input('Presione algo ');
    stop(r);
    LPC_C(:,i) = LPCx(getaudiodata(r).*hamming(length(getaudiodata(r))));
end
switch vocal
   case 1      
    save A.mat LPC_C;%Crea el archivo de la base de datos
   case 2      
    save E.mat LPC_C;%Crea el archivo de la base de datos
   case 3      
    save I.mat LPC_C;%Crea el archivo de la base de datos
   case 4      
    save O.mat LPC_C;%Crea el archivo de la base de datos
   case 5      
    save U.mat LPC_C;%Crea el archivo de la base de datos
end
