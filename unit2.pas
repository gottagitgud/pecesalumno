unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, mysql57conn, FileUtil,
  Forms, Controls, Graphics, Dialogs, StdCtrls, DbCtrls, LCLType, ExtCtrls, Crt;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MySQL57Connection1: TMySQL57Connection;
    MySQL57Connection2: TMySQL57Connection;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    SQLTransaction2: TSQLTransaction;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;
  consultamatricula: TStringList;
  MousePos: TPoint;
  grupo: string;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.Button1Click(Sender: TObject);
begin
  SQLQuery1.sql.text := 'SELECT matricula FROM registros WHERE matricula ='+Edit3.text+';';
  DBEdit1.DataField := 'matricula';
  SQLQuery1.active := true;
  Delay (3000);

  if (Edit1.text = '') then
     ShowMessage('El nombre no puede estar en blanco')

  else
  begin
      if(Edit4.text = '') then
        ShowMessage('La contraseña no puede estar en blanco')

      else
      begin
           if(DBEdit1.text = '')then
           begin
            grupo:=Edit2.Text;
            if (grupo[2]='-') then
            begin
              grupo:=grupo[1]+grupo[3];
            end;
            SQLQuery2.SQL.text := 'insert into registros (nombre, grupo, matricula, contrasena) values('''+Edit1.text+''','''+grupo+''','+Edit3.text+','''+Edit4.text+''')';
            SQLQuery2.ExecSQL;
            SQLTransaction2.Commit;
            ShowMessage('Registrado correctamente');
            Form2.hide;
      end

      else
          begin
          ShowMessage('La matícula ya está registrada');
          SQLQuery2.active := false;
          DBEdit1.DataField := '';
          DBEdit1.text := '';
          end;
      end;
  end;
end;
end.

