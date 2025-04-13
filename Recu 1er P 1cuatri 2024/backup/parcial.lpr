program parcial;

Const TOP = 100;

Type
    st6 = string[6]; st10 = string[10];
    TVst10 = array[1..TOP] of st10;
    TVst6 = array[1..TOP] of st6;
    TVgen = array[1..TOP] of byte;
    TVs = array[1..TOP] of word;

Function BuscarInter(inter:st10; Vidi:TVst10; n:byte):byte;
var
   i:byte;
begin
     i:=1;
     while (i < n) and (inter <> Vidi[i]) do
           i:= i+1;
     if Vidi[i] = inter then
           BuscarInter:= i
     Else
         BuscarInter:=0;
end;

Function contar(inter:st10; Vidi2:TVst10; n2:byte):byte;
var
   i,cont:byte;
begin
     cont:=0;
     for i:=1 to n2 do
         if inter = Vidi2[2] then
            cont:= cont+1;
     contar:=cont;
end;

Procedure LeerInterprete(Var Vidi:TVst10; var Vgen:TVgen; var n:byte);
var
   arch:text; inter:st10; gen:byte; firmo:char;
begin
     assign(arch,'Interpretes.txt');reset(arch);
     n:=0;
     while not eof(arch) do
           begin
                readln(arch,inter,gen,firmo); firmo:=upcase(firmo);
                if firmo = 'S' then
                   begin
                        n:= n+1;
                        Vidi[n]:=inter; Vgen[n]:=gen;
                   end;
           end;
     close(arch);
end;

Procedure LeerTema(Var Vt:TVst6; Var Vs:TVs; Var n2:byte; Vidi:Tvst10; Var Vidi2:TVst10; n:byte; var Nodis:byte);
var
   dur:word; dis:char; inter:st10; id:st6;
   k,i,pos:byte;
begin
     Writeln('Ingrese k'); readln(k); n2:=0; Nodis:=0;

     for i:=1 to K do
         begin
              writeln('Ingrese interprete'); readln(inter);
              pos:=BuscarInter(inter,Vidi,n);
              if pos <> 0 then
                 begin
                      writeln('Ingrese id del tema, duracion y disponibilidad');
                      readln(Id,dur,dis); dis:=upcase(dis);
                      while Id <> 'zzz' do
                            begin
                                 if dis <> 'N' then
                                    begin
                                         Vt[n2]:=Id; vs[n2]:=dur;
                                         Vidi2[n2]:=inter;
                                    end
                                 else
                                     Nodis:=Nodis + 1;
                            end;
                 end;
          end;
end;

Function InciA(Vidi,Vidi2:TVst10; Vgen:TVgen; n,n2:byte):st10;
var
   i:byte; cant:byte;
   max:byte; interMax:st10;
begin
     max:=0;

     for i:=1 to n do
         begin
              if Vgen[i] in [2,3] then
                 begin
                      cant:=contar(Vidi[i],Vidi2,n2);
                      if cant > Max then
                         begin
                              Max:=cant;
                              interMax:=Vidi[i];
                         end;
                 end;
         end;
     if Max = 0 then
        InciA:='0'
     else
         InciA:=InterMax;
end;

Procedure Mostrar(Vb:TVst10; nb:byte);
var
   i:byte;
begin
     for i:=1 to nb do
         writeln(Vb[i],' ');
end;

Procedure generar(VIdi2:Tvst10; var Vb:TVst10; n2:byte; Vidi:TVst10; nb,n:byte; Vs:TVs);
var
   i,j:byte;      total:word;
   media:real;
begin
     media:=0; nb:=0;
     for i:=1 to n2 do
         media:=Vs[i] + media;
     media:=media/n2;

     for i:=1 to n do
         begin
              total:=0;
              for j:=1 to n2 do
                  begin
                       if Vidi[i] = Vidi2[j] then
                          total:= total + Vs[j];
                  end;
              if total > media then
                 begin
                      nb:= nb+1;
                      Vb[nb]:= Vidi[i];
                 end;
         end;
     Mostrar(Vb,nb);
end;

procedure InciC(Vidi,Vidi2:TVst10; Vt:TVst6; Vs:TVs; Var n,n2:byte);
var
    L:st10; T:st6; D:word;     pos:byte;
begin
     writeln('Ingrese los datos');readln(L,T,D);
     pos:= BuscarInter(L,Vidi,n);
     if pos <> 0 then
        begin
             n:=n+1; n2:=n2+1;
             Vidi[n]:=L; Vidi2[n2]:=L;
             Vt[n2]:=T; Vs[n2]:=D;
        end;
end;



var
   Vidi,Vidi2,Vb:TVst10; Vt:TVst6; Vgen:TVgen; aux:st10; Vs:TVs; n,n2,nb,Nodis:byte;
begin
     LeerInterprete(Vidi,Vgen,n);
     LeerTema(Vt,Vs,n2,Vidi,Vidi2,n,Nodis);
     aux:= InciA(Vidi,Vidi2,Vgen,n,n2);
     if aux = '0' then
        writeln('Existe')
     else
         Writeln('El que tiene mas condiciones es: ',aux);
     generar(Vidi2,Vb,n2,Vidi,nb,n,vs);
     readln;
end.
