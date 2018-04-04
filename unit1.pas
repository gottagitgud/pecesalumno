unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus, DbCtrls, ExtCtrls, Unit2, Unit3, Unit4, mysql57conn, sqldb, db, Crt, IniFiles, LCLType;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MySQL57Connection1: TMySQL57Connection;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseLeave(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  MousePos: TPoint;
  HH, MM, SS, MS, YY, MN, DD, num_pc : Word;
  capturarcontrasena, contrasena, host, pass, usuario, base: string;
  config: TINIFile;


implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  try
     num_pc:=config.ReadInteger('General','numero_pc', 1);
     host:=config.ReadString('BD','host','sql3.freemysqlhosting.net');
     usuario:=config.ReadString('BD','usuario','sql3230377');
     base:=config.ReadString('BD','base','sql3230377');
     pass:=config.ReadString('BD','pass','naM63aRsSF');
  finally
    config.Free;
  end;

  MySQL57Connection1.DatabaseName:=base;
  MySQL57Connection1.UserName:=usuario;
  MySQL57Connection1.Password:=pass;
  MySQL57Connection1.HostName:=host;
  SQLQuery1.sql.text := 'SELECT matricula FROM registros WHERE matricula = '+Edit1.text+';';
  SQLQuery1.active := false;
  SQLQuery1.active := true;
  DBEdit1.DataField:='matricula';
  if(DBEdit1.text = Edit1.text)then
  begin
    DBEdit1.DataField := '';
    SQLQuery1.active := false;
    SQLQuery1.sql.text := 'SELECT contrasena FROM registros WHERE contrasena = '''+Edit2.text+''' AND matricula = '+Edit1.text+';';
    DBEdit1.DataField:='contrasena';
    SQLQuery1.active := true;
    Delay (3000);

    if(DBEdit1.text = Edit2.text)then
    begin
      ShowMessage('Entrada registrada');
      Form1.hide;
      Form2.hide;
      SQLQuery1.active := false;
      SQLQuery1.sql.text := 'CREATE TABLE IF NOT EXISTS pc1_'+IntToStr(DD)+'_'+IntToStr(MN)+'_'+IntToStr(YY)+' (ID int(13) NOT NULL AUTO_INCREMENT, matricula bigint(16) NOT NULL, horaentrada time, horasalida time, PRIMARY KEY (ID));';
      SQLQuery1.ExecSQL;
      SQLTransaction1.commit;
      SQLQuery1.sql.text := 'INSERT INTO pc'+IntToStr(num_pc)+'_'+IntToStr(DD)+'_'+IntToStr(MN)+'_'+IntToStr(YY)+' (matricula, horaentrada, horasalida) VALUES ('+Edit1.text+', CURTIME(), CURTIME());';
      SQLQuery1.ExecSQL;
      SQLTransaction1.commit;
      Timer1.enabled := true;
    end
    else

    begin
      ShowMessage('Contraseña incorrecta');
      SQLQuery1.active := false;
      SQLQuery1.sql.text := '';
      DBEdit1.DataField:='';
    end;
  end

  else
  begin
    if(length(Edit1.text) <> 14) then
      ShowMessage('Matrícula inválida')
    else
      ShowMessage('Matrícula no registrada');
  end;
end;
procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  ShowMessage('Debe registrarse primero');
  CanClose := false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DecodeDate(Date, YY, MN, DD);
  config := TINIFile.Create('db.ini');
end;

procedure TForm1.FormDeactivate(Sender: TObject);
begin

end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

end;

procedure TForm1.FormMouseLeave(Sender: TObject);
begin
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  Form2.visible := true;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  contrasena:=config.ReadString('General','cs','');
  capturarcontrasena:= inputbox('','Introduzca la contraseña:','');
  if capturarcontrasena = contrasena then
     Form3.Visible:=true
  else
    ShowMessage('Contraseña incorrecta');
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Form4.Visible:=true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  DecodeTime(Time, HH, MM, SS, MS);
  SQLQuery1.sql.text := 'UPDATE pc1_'+IntToStr(DD)+'_'+IntToStr(MN)+'_'+IntToStr(YY)+' SET horasalida = (CURTIME()) ORDER BY ID DESC LIMIT 1;';
  SQLQuery1.ExecSQL;
  SQLTransaction1.Commit;
end;

end.

