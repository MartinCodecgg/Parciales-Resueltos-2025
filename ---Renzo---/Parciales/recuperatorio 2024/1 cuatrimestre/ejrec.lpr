program ejrec;
const
m=100;
type
  st10=string[10];
  st6=string[6];
  tvb=Array[1..m] of byte;
  tvr=Array[1..m] of real;
  tvs=Array[1..m] of st10;
procedure armar(var int:tvs;var genero,tema,tema2:tvb;var total,total2:tvr;var n:byte);
var
  arch:Text;
  id:st10;
  gen:byte;
  v,car:char;
begin
     assign(Arch,'interprete.txt');
     reset(Arch);
     while not eof(arch) do
      begin
           readln(Arch,id,gen,v,car);
           if car='S' then
             begin
                   n:=n+1;
                   int[n]:=id;
                   genero[n]:=gen;
                   tema[n]:=0;
                   tema2[n]:=0;
                   total[n]:=0;
                   total2[n]:=0;
             end;
      end;
      close(Arch);
end;
function busqueda(int:tvs;id:st10;n:byte):byte;
var
  i:byte;
begin
     i:=1;
     while (i<=n) and (int[i]<>id) do
      i:=i+1;
     busqueda:=i;
end;
procedure armar2(int:tvs;var tema,tema2:tvb;var total,total2:tvr;n:byte);
var
  id:st10;
  mus:st6;
  tiempo:real;
  dis:char;
  i,j:byte;
begin
     for i:=1 to n do
     begin
          writeln('ingrese el id del ',i,' interprete');
          readln(id);
          j:=busqueda(int,id,n);
          if j<=n then
            begin
             repeat
                  writeln('ingrese el tema');
                  readln(mus);
                  if mus<>'ZZZ' then
                    begin
                          writeln('ingrese la duracion y si esta disponible ');
                          readln(tiempo,dis);
                          dis:=upcase(dis);
                          if dis='S' Then
                            begin
                                  tema[j]:=tema[j]+1;
                                  total[j]:=total[j]+tiempo;
                            end
                          else
                              begin
                                  tema2[j]:=tema2[j]+1;
                                  total2[j]:=total2[j]+tiempo;
                            end
                    end;
             until mus='ZZZ';
          end;
     end;
end;
function nom23(int:tvs;genero,tema,tema2:tvb;n:byte):st10;
var
  i,max:byte;
  nom:st10;
begin
     max:=0;
     for i:=1 to n do
        if (genero[i] in[2..3]) and (tema2[i]=0) and (tema[i]>max) then
           begin
                 max:=tema[i];
                 nom:=int[i];
           end;
     if max=0 then
        nom23:=''
     else
       nom23:=nom;
end;
function duracionmedia(total:Tvr;n:byte):real;
var
  i:byte;
  ac:real;
begin
     ac:=0;
     for i:=1 to n do
       ac:=ac+total[i];
     ac:=ac/n;
     duracionmedia:=Ac;
end;
procedure armarv(var int2:tvs;int:tvs;total:tvr;var m:byte;n:byte);
var
  i:byte;
  ac:real;
begin
     ac:=duracionmedia(total,n);
     for i:=1 to n do
          if total[i]>ac then
             begin
                  m:=m+1;
                  int2[m]:=int[i];
             end;
end;
procedure mostrar(int2:tvs;m:byte);
var
  i:byte;
begin
     for i:=1 to m do
     writeln(int2[i]);
end;

procedure agregar(int:tvs;var total:tvr;var tema:tvb;l:st10;t:st6;d:real;n:byte);
var
  i:byte;
begin
     i:=busqueda(int,l,n);
     if i<=n then
        begin
               tema[i]:=tema[i]+1;
             total[i]:=total[i]+d;
        end;
end;
var
  int,int2:tvs;
  tema,tema2,genero:tvb;
  total,total2:tvr;
  n , k:byte;
  l,aux:st10;
  d:real;
  t:st6;

begin
  n:=0;
  k:=0;
  writeln('ingrese nombre , tema, y duracion ');
  readln(l);
  readln(t,d);
  armar(int,genero,tema,tema2,total,total2,n);
  armar2(int,tema,tema2,total,total2,n);
  aux:=nom23(int,genero,tema,tema2,n);
  if aux='' then
      writeln('no exsiste ninguno ')
  else
    writeln(aux);
  armarv(int2,int,total,k,n);
  mostrar(int2,k);
  agregar(int,total,tema,l,t,d,n);
  readln;
end.

