program parcial;

const TOP = 100;

Type
    TV1 = array[1..TOP] of byte;
    TVdem = array[1..TOP] of real;
    TVW = array[1..TOP] of word;
    st16 = string[16];

function Buscar(Vli:TV1; n,licen:byte):byte;
var
   i:byte;
begin
     i:=1;
     while (i < n) and (licen > Vli[i]) do
           i:= i+1;

     if licen = Vli[i] then
        Buscar:=i
     else
        Buscar:=0;
end;

procedure InsertaOrd(Var Vli:TV1; var Vcant:TVw; var Vtot,Vdem:TVdem; var n:byte; licen:byte; dem:shortint; costo:real);
var
   i:byte;
begin
     i:=n;
     while (i > 0) and (licen < Vli[i]) do
           begin
                Vli[i+1]:=Vli[i]; Vcant[i+1]:=Vcant[i];
                Vtot[i+1]:=Vtot[i]; Vdem[i+1]:= Vdem[i];
                i:= i-1;
           end;
     Vli[i+1]:=licen; Vtot[i+1]:=costo;
     Vcant[i+1]:=1; Vdem[i+1]:=dem;
     n:=n+1;
end;

Procedure CalcularPromedio(var Vdem:TVdem; Vcant:TVw; n:byte);  //Convenia mas hacer esto en procedimiento leer
var
   i:byte;
begin
     for i:=1 to n do
         Vdem[i]:= Vdem[i]/Vcant[i];
end;

procedure Leer(Var Vli:TV1 ; var Vcant:TVw; var Vtot,Vdem:Tvdem; var n,cantCancel:Byte);
var
   arch:text; dem:shortint; car:char;
   fecha:st16; licen,pos:byte; costo:real;
begin
     Assign(arch,'viajes.txt'); reset(arch);
     cantCancel:=0; n:=0;

     while not eof(arch) do
           begin
                read(Arch,licen,car,fecha,dem);
                if dem = -1 then                        //La mejor forma de hacer esta parte es asi, ya que sino pregunto dos veces por dem = -1
                   begin
                        readln(arch);
                        if copy(Fecha,1,4) = '2024' then
                           cantCancel:= cantCancel+1;
                   end
                else
                   begin
                        readln(arch,costo);
                        pos:= buscar(vli,n,licen);
                        if pos = 0 then
                           InsertaOrd(vli,vcant,vtot,vdem,n,licen,dem,costo)
                        else
                            begin
                                 Vcant[pos]:= Vcant[pos]+1;
                                 Vtot[pos]:= Vtot[pos]+costo;
                                 Vdem[pos]:=Vdem[pos]+dem;
                            end;
                   end;
           end;
     CalcularPromedio(Vdem,Vcant,n); close(arch);
     writeln(' La cantidad de viajes cancelados en el 2024 fue de: ',cantCancel);
end;

procedure InciA(Vli:TV1; Vdem:TVdem; n:byte);
var
   Vaux:TV1; Maxdem:real;
   i,Naux:byte;
begin
     Naux:=0; Maxdem:=0;
     for i:=1 to n do
         begin
              if Vdem[i] > Maxdem then
                 begin
                      Maxdem:=Vdem[i];
                      Naux:=1;
                      Vaux[Naux]:=Vli[i];
                 end
              else if Vdem[i] = Maxdem then
                   begin
                        Naux:=Naux+1;
                        Vaux[Naux]:= Vli[i];
                   end;
         end;

     for i:=1 to Naux do
         write(Vaux[i],' ');
end;

Procedure InciB(Vli:TV1; Vcant: TVw; Vtot:Tvdem; n:byte);
var
   L,pos:byte;
begin
     writeln('Ingrese la unidad de licencia');readln(L);
     pos:= Buscar(Vli,n,L);
     if pos = 0 then
        writeln('La unidad ingresada no existe')
     else
         writeln('La recaudacion promedio es: ',(Vtot[pos]/Vcant[pos]):8:2);
end;


var
   Vli:Tv1; Vcant:TVw; Vdem,Vtot:TVdem;
   n,cantCancel:Byte;                          i:byte;
begin
     writeln('Lectura:');
     Leer(Vli,Vcant,Vtot,Vdem,n,cantCancel);
     writeln('Inciso A:');
     InciA(Vli,Vdem,n);
     writeln();
     for i:=1 to n do
         write(Vli[i],' ');
     writeln('Inciso B:');
     InciB(Vli,Vcant,Vtot,n);
     readln;
end.                            // 1:12 min - 1.16 min
