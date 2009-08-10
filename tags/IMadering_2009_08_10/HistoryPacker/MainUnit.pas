unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, JvZLibMultiple, StdCtrls, ComCtrls;

type
  TMainForm = class(TForm)
    btnCompress: TButton;
    btnUnCompress: TButton;
    Label1: TLabel;
    edSrcFolder: TEdit;
    Label2: TLabel;
    edDestFolder: TEdit;
    Label3: TLabel;
    edFilename: TEdit;
    pbProgress: TProgressBar;
    lblFilename: TLabel;
    btnSrc: TButton;
    btnDestFile: TButton;
    btnDestFolder: TButton;
    procedure btnCompressClick(Sender: TObject);
    procedure btnUnCompressClick(Sender: TObject);
    procedure edDestFolderChange(Sender: TObject);
    procedure edSrcFolderChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSrcClick(Sender: TObject);
    procedure btnDestFolderClick(Sender: TObject);
    procedure btnDestFileClick(Sender: TObject);
  private
    { Private declarations }
    procedure DoProgress(Sender: TObject; Position, Total: Integer);
    procedure DoCompressFile(Sender: TObject; const Filename: string);
    procedure DoDecompressFile(Sender: TObject; const Filename: string; var WriteFile: Boolean); // NEW!
  end;

var
  MainForm: TMainForm;

implementation

uses
  JvBrowseFolder;

{$R *.dfm}

procedure TMainForm.DoCompressFile(Sender: TObject; const Filename: string);
begin
  lblFilename.Caption := Filename;
  Update;
end;

procedure TMainForm.DoDecompressFile(Sender: TObject; const Filename: string; var WriteFile: Boolean);
begin
  if WriteFile then
  begin
    lblFilename.Caption := Filename;
    Update;
  end;
end;

procedure TMainForm.btnCompressClick(Sender: TObject);
var
  z: TJvZlibMultiple;
begin
  ForceDirectories(ExtractFilePath(edFilename.Text));
  z := TJvZlibMultiple.Create(nil);
  Screen.Cursor := crHourGlass;
  try
    lblFilename.Caption := '';
    pbProgress.Position := 0;
    z.OnProgress := DoProgress;
    z.OnCompressingFile := DoCompressFile;
    z.CompressionLevel := 9;
    z.CompressDirectory(edSrcFolder.Text, true, edFilename.Text);
  finally
    z.Free;
    Screen.Cursor := crDefault;
  end;
  pbProgress.Position := 0;
  lblFilename.Caption := 'Упаковка файлов завершена';
end;

procedure TMainForm.btnUnCompressClick(Sender: TObject);
var z: TJvZlibMultiple;
begin
  z := TJvZlibMultiple.Create(nil);
  Screen.Cursor := crHourGlass;
  try
    lblFilename.Caption := '';
    pbProgress.Position := 0;
    z.OnProgress := DoProgress;
    z.OnDecompressingFile := DoDecompressFile;
    z.DecompressFile(edFilename.Text, edDestFolder.Text, true);
  finally
    z.Free;
    Screen.Cursor := crDefault;
  end;
  pbProgress.Position := 0;
  lblFilename.Caption := 'Распаковка файлов завершена';
end;

procedure TMainForm.DoProgress(Sender: TObject; Position, Total: Integer);
begin
  pbProgress.Max := Total;
  pbProgress.Position := Position;
  Update;
end;

procedure TMainForm.edDestFolderChange(Sender: TObject);
begin
  btnUnCompress.Enabled := edDestFolder.Text <> '';
end;

procedure TMainForm.edSrcFolderChange(Sender: TObject);
begin
  btnCompress.Enabled := DirectoryExists(edSrcFolder.Text) and (edFilename.Text <> '');
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  edSrcFolderChange(Sender);
  edDestFolderChange(Sender);
end;

procedure TMainForm.btnSrcClick(Sender: TObject);
var S: string;
begin
  S := edSrcFolder.Text;
  if BrowseForFolder('Select source folder', false, S) then edSrcFolder.Text := S;
end;

procedure TMainForm.btnDestFolderClick(Sender: TObject);
var S: string;
begin
  S := edDestFolder.Text;
  if BrowseForFolder('Select source folder', true, S) then edDestFolder.Text := S;
end;

procedure TMainForm.btnDestFileClick(Sender: TObject);
begin
  with TSaveDialog.Create(self) do
  try
    InitialDir := '.';
    Title := 'Select destination file';
    Filename := edFilename.Text;
    if Execute then edFilename.Text := Filename;
  finally
    Free;
  end;
end;

end.

