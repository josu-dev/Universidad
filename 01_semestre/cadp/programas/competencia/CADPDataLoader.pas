unit CADPDataLoader;
interface
type
  TDatos = record
          salario : integer;
          edad :  integer;
          DNI : string;
          legajo : integer;
        end;
  
   procedure CADPleerDato (var d : TDatos; var ultimo : boolean);
   procedure CADPVolverAlInicio(miArchivo : string);
   procedure CADPfinalizarLectura();

implementation
uses
 Sysutils;
   
var
   myfile : TextFile;
   
   procedure CADPVolverAlInicio(miArchivo : string);
   begin
        Assign(myfile, miArchivo);
        reset(myfile);
   end; 
   
   procedure CADPleerDato(var d : TDatos; var ultimo : boolean);
   begin
      if not eof(myfile) then
      begin
	   readln(myfile,d.salario);
	   readln(myfile,d.edad);
	   readln(myfile,d.dni);
	   readln(myfile, d.legajo);
	   ultimo := eof(myfile);
	  end
      else begin
         d.salario := -1;
         ultimo := true;
      end;   
   end;
   
   procedure CADPfinalizarLectura();
   begin
      close(myfile);
   end;
   
initialization
begin

end;
  

finalization
begin

end;      
end.

