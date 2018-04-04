unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Crt, IniFiles;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;
  config: TINIFile;

implementation

{$R *.lfm}

{ TForm3 }

procedure TForm3.FormCreate(Sender: TObject);
begin
  config := TINIFile.Create('db.ini');
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
   if Edit5.Text<>'' then config.WriteString('General', 'cs', Edit5.Text);
   if Edit1.Text<>'' then config.WriteInteger('General', 'numero_pc', strtoint(Edit1.Text));
   if Edit2.Text<>'' then config.WriteString('BD', 'host', Edit2.Text);
   if Edit3.Text<>'' then config.WriteString('BD', 'usuario', Edit3.Text);
   if Edit4.Text<>'' then config.WriteString('BD', 'pass', Edit4.Text);
   if Edit6.Text<>'' then config.WriteString('BD', 'base', Edit6.Text);
   Form3.Visible:=false;
end;

end.

