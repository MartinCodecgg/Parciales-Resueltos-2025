  program ej1b;
  type
         tv=array[1..100] of byte;
         tvr=array[1..100] of real;
  function busqueda(nl:tv;num:integer;n:byte):byte;
  var
    i:byte;
  begin
        i:=1;
        while (i<=n) and (num<>nl[i]) do
             i:=i+1;
        busqueda:=i;
  end;
  procedure ordenar(var nl,viajes,cancelado:tv;var demora,total:tvr;num:integer;var n:byte);
  var
     p:byte;
  begin
        p:=n;
        while (num>nl[n]) and (p>0) do
        begin
              nl[p+1]:=nl[p];
              viajes[p+1]:=viajes[p];
              demora[p+1]:=demora[p];
              total[p+1]:=total[p];
              cancelado[p+1]:=cancelado[p];
              p:=p-1;
        end;
        p:=p+1;
        nl[p]:=num;
        viajes[p]:=1;
        demora[p]:=0;
        total[p]:=0;
        cancelado[p]:=0;
         n:=n+1;
  end;
  procedure promedio(var demora:tvr;viajes:tv;n:byte);
  var
     i:byte;
  begin
        for i:=1 to n do
         demora[i]:=demora[i]/viajes[i];
  end;
  procedure mostrar(maxnl:tv;j:byte);
  var
     i:byte;
  begin
        writeln('los que tienen el mayor promedio de demora son');
        for i:=1 to j do
         writeln(i,' ',maxnl[i]);
  end;
  procedure rev(nl,viajes:tv;total:tvr;n:byte);
  var
     i:byte;
     valor:real;
     l:integer;
  begin
        writeln('ingrese l');
        readln(l);
        i:=busqueda(nl,l,n);
        if i>n then
            writeln('no exsiste esa patente')
        else
           begin
                  valor:=total[i]/viajes[i];
                  writeln('el promedio es de ',valor:0:0,'$');
           end;
  end;
  procedure leer(var nl,viajes,cancelado:tv;var demora,total:tvr;var n:byte);
  var
     num,dem:integer;
     t:real;
     i:byte;
     arch:Text;
     v:string[1];
     ano:string[4];
     cont:byte;
     fecha:string[10];
  begin
        cont:=0;
        assign(Arch,'viajes.txt');
        reset(arch);
        while not eof(Arch) do
        begin
              read(arch, num,v,ano,fecha,dem);
              i:=busqueda(nl,num,n);
              if i>n then
                    ordenar(nl,viajes,cancelado,demora,total,num,n);
              if dem<>-1 then
                  begin
                         read(arch,t);
                         viajes[i]:=viajes[i]+1;
                         demora[i]:=demora[i]+1;
                         total[i]:=total[i]+t;
                  end
              else
              begin
                   cancelado[i]:=cancelado[i]+1;
                   if ano='2024' then
                       cont:=cont+1;
              end;
              readln(arch);
        end;
        writeln(cont,' cancelados');
        promedio(demora, viajes, n);
        close(arch);
  end;
  procedure mayd(var maxnl:tv;nl:tv;demora:tvr;var j:byte;n:byte);
  var
     max:real;
     i:byte;
  begin
        max:=-1;
        for i:=1 to n do
         begin
               if demora[i]>max then
                   begin
                          max:=demora[i];
                          j:=1;
                          maxnl[j]:=nl[i];
                   end
               else
                   if demora[i]=max then
                       begin
                              j:=j+1;
                              maxnl[j]:=nl[i];
                       end;
         end;
  end;

  var
     nl,maxnl,viajes,cancelado:tv;
     demora,total:tvr;
     i,n,j:byte;

  begin
      n:=0;
      j:=0;
      leer(nl,viajes,cancelado, demora, total, n);
      mayd(maxnl,nl,demora,j,n);
      mostrar(maxnl, j);
      rev(nl, viajes, total, n);
      readln;
  end.

