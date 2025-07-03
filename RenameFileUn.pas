unit RenameFileUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, FileCtrl,
  // Eu
  RXMisc;

type
  TForm1 = class(TForm)
    DirViewPanel: TPanel;
    Panel1: TPanel;
    DirPanel: TPanel;
    DirectoryListBox: TDirectoryListBox;
    DriveComboBox: TDriveComboBox;
    Splitter: TPanel;
    FileListPanel: TPanel;
    ListViewCaption: TPanel;
    Notebook: TNotebook;
    StatusBar1: TStatusBar;
    FileListBox: TFileListBox;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    txOldEdit: TEdit;
    ChangeForButton: TButton;
    txNewEdit: TEdit;
    procedure DirPanelResize(Sender: TObject);
    procedure SplitterMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SplitterMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SplitterMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FileListPanelCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure DirViewPanelResize(Sender: TObject);
    procedure FileListPanelResize(Sender: TObject);
    procedure ChangeForButtonClick(Sender: TObject);
    procedure FileListBoxChange(Sender: TObject);
    procedure txNewEditChange(Sender: TObject);
  private
    { Private declarations }
    SplitControl: RXMisc.TSplitControl;
    procedure ResizeChangeFor;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  StrUtils;

procedure TForm1.DirPanelResize(Sender: TObject);
begin
  Self.DriveComboBox.Width := TPanel(Sender).Width - 2;

  Self.DriveComboBox.Top := Self.DirPanel.ClientHeight - Self.DriveComboBox.Height;
  Self.DirectoryListBox.Height := Self.DriveComboBox.Top - 4;
end;

procedure TForm1.SplitterMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and (Shift = [ssLeft]) then
    SplitControl.BeginSizing(Splitter, DirViewPanel);
end;

procedure TForm1.SplitterMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  with SplitControl do if Sizing then ChangeSizing(X, Y);
end;

procedure TForm1.SplitterMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  with SplitControl do if Sizing then EndSizing;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SplitControl := TSplitControl.Create(Self);

  ResizeChangeFor;

  // Test
{  with TDirectoryListBox(FileListBox) do
  begin
    Columns := 3;
    SendMessage(Handle, LB_SETCOLUMNWIDTH, Canvas.TextWidth('WWWWWWWW.WWW'), 0);
  end;
}
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    if Assigned(SplitControl) then SplitControl.Free;
end;

procedure TForm1.ResizeChangeFor;
const
  spaceWidth = 10;
var
  base:   Cardinal;
begin
  base := (Self.GroupBox1.ClientWidth - 4*spaceWidth) div 3;

  // Edit old text
  Self.txOldEdit.Left := spaceWidth;
  Self.txOldEdit.Width := base;

  // Button Change file name
  Self.ChangeForButton.Left  := Self.txOldEdit.Left + Self.txOldEdit.Width + spaceWidth;
  Self.ChangeForButton.Width := base;

  //
  Self.txNewEdit.Left := Self.ChangeForButton.Left + Self.ChangeForButton.Width + spaceWidth;
  Self.txNewEdit.Width := base;
end;

procedure TForm1.FileListPanelCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  ResizeChangeFor;
end;

procedure TForm1.DirViewPanelResize(Sender: TObject);
begin
  ResizeChangeFor;
end;

procedure TForm1.FileListPanelResize(Sender: TObject);
begin
    ResizeChangeFor;
end;

procedure TForm1.ChangeForButtonClick(Sender: TObject);
var
  r:        Integer;
  oldName,
  newName,
  txtPath,
  errorMessage:  String;
begin
  txtPath := Self.FileListBox.Directory;
  if not (StrUtils.RightStr(txtPath,1) = '\') then begin
    txtPath := txtPath + '\';
  end;
  for r := 0 to Self.FileListBox.Items.Count - 1 do begin
    if Self.FileListBox.Selected[r] then begin
      oldName := Self.FileListBox.Items[r];
      // type TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
      newName := SysUtils.StringReplace(oldName, Self.txOldEdit.Text, Self.txNewEdit.Text, []);
      if newName <> oldName then begin
         if not SysUtils.RenameFile(txtPath + oldName, txtPath + newName) then begin
            System.SetLength( errorMessage, 255);
            if (Windows.FormatMessage(Windows.FORMAT_MESSAGE_FROM_SYSTEM
              or Windows.FORMAT_MESSAGE_IGNORE_INSERTS, Nil, Windows.GetLastError, 0, @errorMessage[1], Length(errorMessage),0)) = 0 then begin
              errorMessage := '';
            end;
            raise Exception.Create('Unable to rename file:'#13#10 + oldName + #13#10 + errorMessage);
         end;
      end;
    end;
  end;
  Self.FileListBox.Update;
end;

procedure TForm1.txNewEditChange(Sender: TObject);
begin
  if (Self.txOldEdit.Text <> '')
        and (Self.FileListBox.ItemIndex > 0)
        and (Self.txOldEdit.Text <> Self.txNewEdit.Text)then begin
      Self.ChangeForButton.Enabled := True;
    end
    else begin
      Self.ChangeForButton.Enabled := False;
  end;
end;

procedure TForm1.FileListBoxChange(Sender: TObject);
begin
  if Self.FileListBox.ItemIndex > 0 then begin
    Self.txOldEdit.Text := Self.FileListBox.Items[Self.FileListBox.ItemIndex];
    Self.txNewEdit.Text := Self.txOldEdit.Text;
    Self.ChangeForButton.Enabled := False;
  end;
end;  
end.
