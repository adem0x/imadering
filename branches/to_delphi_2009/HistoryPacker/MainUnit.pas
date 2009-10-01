unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TMainForm = class(TForm)
    btnCompress: TButton;
    btnUnCompress: TButton;
    SourceDirLabel: TLabel;
    edSrcFolder: TEdit;
    UnpackDirLabel: TLabel;
    edDestFolder: TEdit;
    SourceFileLabel: TLabel;
    edFilename: TEdit;
    pbProgress: TProgressBar;
    ProgressLabel: TLabel;
    btnSrc: TButton;
    btnDestFile: TButton;
    btnDestFolder: TButton;
    LangComboBox: TComboBox;
    LangLabel: TLabel;
    procedure btnCompressClick(Sender: TObject);
    procedure btnUnCompressClick(Sender: TObject);
    procedure edDestFolderChange(Sender: TObject);
    procedure edSrcFolderChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSrcClick(Sender: TObject);
    procedure btnDestFolderClick(Sender: TObject);
    procedure btnDestFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LangComboBoxChange(Sender: TObject);
  private
    { Private declarations }
    SelectFolderL: string;
    SelectFileL: string;
    PackOKL: string;
    UnPackOKL: string;
    procedure DoProgress(Sender: TObject; Position, Total: Integer);
    procedure DoCompressFile(Sender: TObject; const Filename: string);
    procedure DoDecompressFile(Sender: TObject; const Filename: string; var WriteFile: Boolean);
  end;

var
  MainForm: TMainForm;

implementation

uses
  JvBrowseFolder, JvZLibMultiple;

{$R *.dfm}

procedure TMainForm.DoCompressFile(Sender: TObject; const Filename: string);
begin
  ProgressLabel.Caption := Filename;
  Update;
end;

procedure TMainForm.DoDecompressFile(Sender: TObject; const Filename: string; var WriteFile: Boolean);
begin
  if WriteFile then
  begin
    ProgressLabel.Caption := Filename;
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
    ProgressLabel.Caption := '';
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
  ProgressLabel.Caption := PackOKL;
end;

procedure TMainForm.btnUnCompressClick(Sender: TObject);
var z: TJvZlibMultiple;
begin
  z := TJvZlibMultiple.Create(nil);
  Screen.Cursor := crHourGlass;
  try
    ProgressLabel.Caption := '';
    pbProgress.Position := 0;
    z.OnProgress := DoProgress;
    z.OnDecompressingFile := DoDecompressFile;
    z.DecompressFile(edFilename.Text, edDestFolder.Text, true);
  finally
    z.Free;
    Screen.Cursor := crDefault;
  end;
  pbProgress.Position := 0;
  ProgressLabel.Caption := UnPackOKL;
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

procedure TMainForm.FormCreate(Sender: TObject);
begin
  //--Определяем язык системы по умолчанию
  if GetSystemDefaultLangID <> 1049 then LangComboBox.ItemIndex := 0;
  LangComboBoxChange(nil);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  edSrcFolderChange(Sender);
  edDestFolderChange(Sender);
end;

procedure TMainForm.LangComboBoxChange(Sender: TObject);
begin
  //--Переводим форму на другие языки
  case LangComboBox.ItemIndex of
    0: //--English
      begin
        Caption := 'Unpacker stories for IMadering';
        LangLabel.Caption := 'Language:';
        SourceDirLabel.Caption := 'Folder with files for packaging:';
        SourceFileLabel.Caption := 'File for unpacking:';
        UnpackDirLabel.Caption := 'The folder in which files will be unpacked:';
        btnCompress.Caption := 'Compress';
        btnUnCompress.Caption := 'Unpack';
        ProgressLabel.Caption := 'Progress';
        SelectFolderL := 'Select source folder';
        SelectFileL := 'Select destination file';
        PackOKL := 'Compressing files is completed';
        UnPackOKL := 'Extracting files completed';
      end;
    1: //--Русский
      begin
        Caption := 'Распаковщик истории для IMadering';
        LangLabel.Caption := 'Язык:';
        SourceDirLabel.Caption := 'Папка с файлами для упаковки:';
        SourceFileLabel.Caption := 'Файл для распаковки:';
        UnpackDirLabel.Caption := 'Папка в которую будут распакованы файлы:';
        btnCompress.Caption := 'Упаковать';
        btnUnCompress.Caption := 'Распаковать';
        ProgressLabel.Caption := 'Прогресс';
        SelectFolderL := 'Выбор исходной папки';
        SelectFileL := 'Выбор упакованного файла';
        PackOKL := 'Упаковка файлов завершена';
        UnPackOKL := 'Распаковка файлов завершена';
      end;
    2: //--Українська
      begin
        Caption := 'Розпакувальником історії для IMadering';
        LangLabel.Caption := 'Мова:';
        SourceDirLabel.Caption := 'Папка з файлами для упаковки:';
        SourceFileLabel.Caption := 'Файл для розпакування:';
        UnpackDirLabel.Caption := 'Папка в яку будуть розпаковані файли:';
        btnCompress.Caption := 'Запакувати';
        btnUnCompress.Caption := 'Розпакувати';
        ProgressLabel.Caption := 'Прогрес';
        SelectFolderL := 'Вибір вихідної папки';
        SelectFileL := 'Вибір упакованого файлу';
        PackOKL := 'Упаковка файлів завершена';
        UnPackOKL := 'Розпакування файлів завершена';
      end;
  end;
  Application.Title := Caption;
end;

procedure TMainForm.btnSrcClick(Sender: TObject);
var S: string;
begin
  S := edSrcFolder.Text;
  if BrowseForFolder(SelectFolderL, false, S) then edSrcFolder.Text := S;
end;

procedure TMainForm.btnDestFolderClick(Sender: TObject);
var S: string;
begin
  S := edDestFolder.Text;
  if BrowseForFolder(SelectFolderL, true, S) then edDestFolder.Text := S;
end;

procedure TMainForm.btnDestFileClick(Sender: TObject);
begin
  with TSaveDialog.Create(self) do
  try
    InitialDir := '.';
    Title := SelectFileL;
    Filename := edFilename.Text;
    if Execute then edFilename.Text := Filename;
  finally
    Free;
  end;
end;

end.

