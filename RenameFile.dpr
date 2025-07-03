program RenameFile;

uses
  Forms,
  RenameFileUn in 'RenameFileUn.pas' {Form1},
  RXMisc in 'component\RXMisc.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
