{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit HistoryUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Htmlview, ExtCtrls, Buttons, Menus, VarsUnit,
  ExtDlgs, rXML;

type
  THistoryForm = class(TForm)
    TopPanel: TPanel;
    BottomPanel: TPanel;
    HTMLHistoryViewer: THTMLViewer;
    ContactsComboBox: TComboBox;
    ArhiveComboBox: TComboBox;
    Bevel1: TBevel;
    ContactsLabel: TLabel;
    ArhiveLabel: TLabel;
    SearchTextLabel: TLabel;
    SearchTextEdit: TEdit;
    SearchTextBitBtn: TBitBtn;
    RegistrCheckBox: TCheckBox;
    FullSearchTextCheckBox: TCheckBox;
    ReloadHistoryBitBtn: TBitBtn;
    SaveHistoryAsBitBtn: TBitBtn;
    DeleteHistoryBitBtn: TBitBtn;
    HistoryPopupMenu: TPopupMenu;
    CopyHistorySelText: TMenuItem;
    CopyAllHistoryText: TMenuItem;
    SaveTextAsFileDialog: TSaveTextFileDialog;
    UpSearchCheckBox: TRadioButton;
    DownSearchCheckBox: TRadioButton;
    CloseBitBtn: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HistoryPopupMenuPopup(Sender: TObject);
    procedure HTMLHistoryViewerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SearchTextBitBtnClick(Sender: TObject);
    procedure ReloadHistoryBitBtnClick(Sender: TObject);
    procedure SaveHistoryAsBitBtnClick(Sender: TObject);
    procedure DeleteHistoryBitBtnClick(Sender: TObject);
    procedure ContactsComboBoxChange(Sender: TObject);
    procedure CopyHistorySelTextClick(Sender: TObject);
    procedure CopyAllHistoryTextClick(Sender: TObject);
    procedure CloseBitBtnClick(Sender: TObject);
  private
    { Private declarations }
    ReqHUIN: string;
    ReqCType: string;
  public
    { Public declarations }
    procedure TranslateForm;
    procedure LoadHistoryFromFile(hUIN: string; fullpath: boolean = false);
  end;

var
  HistoryForm: THistoryForm;

implementation

{$R *.dfm}

uses
  MainUnit, ChatUnit, UtilsUnit, UnitLogger;

procedure THistoryForm.LoadHistoryFromFile(hUIN: string; fullpath: boolean = false);
label
  x;
var
  HistoryFile, Doc: string;
  I, II: integer;
begin
  if fullpath then
  begin
    //--Получаем тип и идентификатор контакта
    ReqHUIN := Parse('_', hUIN, 2);
    ReqCType := Parse('_', hUIN, 1);
    //--Очистили компонент истории и выводим надпись, что история загружается
    Doc := '<html><head>' + ChatCSS + '<title>Chat</title></head><body>';
    Doc := Doc + '<span class=b>' + HistoryLoadFileL + '</span>';
    HTMLHistoryViewer.LoadFromBuffer(PChar(Doc), Length(Doc), EmptyStr);
    HTMLHistoryViewer.Refresh;
    //--Загружаем файл истории сообщений
    HistoryFile := ProfilePath + 'Profile\History\' + hUIN + '.z';
    if FileExists(HistoryFile) then
    begin
      try
        //--Распаковываем файл с историей
        UnZip_File(HistoryFile, ProfilePath + 'Profile\History\');
        //--Добавляем стили
        Doc := '<html><head>' + ChatCSS + '<title>Chat</title></head><body>';
        //--Записываем историю
        Doc := Doc + ReadFromFile(ProfilePath + 'Profile\History\Icq_History.htm');
        //--Удаляем уже не нужный распакованный файл с историей
        if FileExists(ProfilePath + 'Profile\History\Icq_History.htm') then DeleteFile(ProfilePath + 'Profile\History\Icq_History.htm');
        if not TextSmilies then ChatForm.CheckMessage_Smilies(Doc);
        SetLength(Doc, Length(Doc) - 6);
        Doc := Doc + '<HR>';
        HTMLHistoryViewer.LoadFromBuffer(PChar(Doc), Length(Doc), EmptyStr);
        //--Ставим каретку в самый низ текста
        HTMLHistoryViewer.VScrollBarPosition := HTMLHistoryViewer.VScrollBar.Max;
        HTMLHistoryViewer.CaretPos := Length(Doc);
      except
        on E: Exception do
          TLogger.Instance.WriteMessage(E);
      end;
    end;
  end
  else
  begin
    //--Запоминаем идентификатор контакта
    ReqHUIN := hUIN;
    //--Проверяем состояние истории для этого контакта
    with MainForm.ContactList do
    begin
      for I := 0 to Categories.Count - 1 do
      begin
        for II := 0 to Categories[I].Items.Count - 1 do
        begin
          if Categories[I].Items[II].UIN = hUIN then
          begin
            //--Запоминаем тип контакта
            ReqCType := Categories[I].Items[II].ContactType;
            //--Прокручиваем список на эту учётную запись
            ContactsComboBox.ItemIndex := ContactsComboBox.Items.IndexOf(ReqCType + '_' + hUIN);
            //--Проверяем загружена ли история уже
            if Categories[I].Items[II].History = EmptyStr then
            begin
              //--Загружаем файл истории сообщений
              HistoryFile := ProfilePath + 'Profile\History\' + ReqCType + '_' + hUIN + '.z';
              if FileExists(HistoryFile) then
              begin
                try
                  //--Распаковываем файл с историей
                  UnZip_File(HistoryFile, ProfilePath + 'Profile\History\');
                  //--Записываем историю в хранилище у этого контакта
                  Categories[I].Items[II].History := ReadFromFile(ProfilePath + 'Profile\History\Icq_History.htm');
                  //--Удаляем уже не нужный распакованный файл с историей
                  if FileExists(ProfilePath + 'Profile\History\Icq_History.htm') then DeleteFile(ProfilePath + 'Profile\History\Icq_History.htm');
                except
                  on E: Exception do
                    TLogger.Instance.WriteMessage(E);
                end;
              end;
            end;
            //--Отображаем историю в чате
            if Categories[I].Items[II].History <> EmptyStr then
            begin
              //--Очистили компонент истории и выводим надпись, что история загружается
              Doc := '<html><head>' + ChatCSS + '<title>Chat</title></head><body>';
              Doc := Doc + '<span class=b>' + HistoryLoadFileL + '</span>';
              HTMLHistoryViewer.LoadFromBuffer(PChar(Doc), Length(Doc), EmptyStr);
              HTMLHistoryViewer.Refresh;
              //--Добавляем стили
              Doc := '<html><head>' + ChatCSS + '<title>Chat</title></head><body>';
              //--Загружаем из файла истории указанное количесво сообщений
              Doc := Doc + Categories[I].Items[II].History;
              if not TextSmilies then ChatForm.CheckMessage_Smilies(Doc);
              SetLength(Doc, Length(Doc) - 6);
              Doc := Doc + '<HR>';
              HTMLHistoryViewer.LoadFromBuffer(PChar(Doc), Length(Doc), EmptyStr);
              //--Ставим каретку в самый низ текста
              HTMLHistoryViewer.VScrollBarPosition := HTMLHistoryViewer.VScrollBar.Max;
              HTMLHistoryViewer.CaretPos := Length(Doc);
            end
            else
            begin
              //--Очистили компонент истории и выводим сообщение, что история не найдена
              Doc := '<html><head>' + ChatCSS + '<title>Chat</title></head><body>';
              Doc := Doc + '<span class=d>' + HistoryNotFileL + '</span>';
              HTMLHistoryViewer.LoadFromBuffer(PChar(Doc), Length(Doc), EmptyStr);
            end;
            //--Выходим из цыкла если нашли контакт
            goto x;
          end;
        end;
      end;
    end;
  end;
  x: ;
end;

procedure THistoryForm.CopyHistorySelTextClick(Sender: TObject);
begin
  //--Копируем выделенный текст в буфер обмена
  HTMLHistoryViewer.CopyToClipboard;
end;

procedure THistoryForm.CopyAllHistoryTextClick(Sender: TObject);
begin
  //--Копируем весь текст в буфер обмена
  HTMLHistoryViewer.SelectAll;
  HTMLHistoryViewer.CopyToClipboard;
end;

procedure THistoryForm.HistoryPopupMenuPopup(Sender: TObject);
begin
  //--Определяем есть ли выделенный текст
  if HTMLHistoryViewer.SelLength = 0 then
  begin
    CopyHistorySelText.Enabled := false;
  end
  else
  begin
    CopyHistorySelText.Enabled := true;
  end;
end;

procedure THistoryForm.TranslateForm;
begin
  //--Переводим форму на другие языки

end;

procedure THistoryForm.SearchTextBitBtnClick(Sender: TObject);
begin
  //--Снимаем предыдущее выделение текста
  HTMLHistoryViewer.SelLength := 0;
  //--Делаем поиск текста в истории
  if not HTMLHistoryViewer.FindEx(SearchTextEdit.Text, RegistrCheckBox.Checked,
    UpSearchCheckBox.Checked) then Showmessage(HistorySearchNoL);
end;

procedure THistoryForm.ReloadHistoryBitBtnClick(Sender: TObject);
begin
  //--Перезагружаем файл истории
  LoadHistoryFromFile(ReqHUIN);
end;

procedure THistoryForm.SaveHistoryAsBitBtnClick(Sender: TObject);
var
  list: TStringList;
begin
  //--Если путь к файлу пустой, то выходим
  if (ReqHUIN = EmptyStr) or (ReqCType = EmptyStr) then Exit;
  //--Указываем начальное имя файла
  SaveTextAsFileDialog.FileName := 'History_' + ReqCType + '_' + ReqHUIN;
  //--Открываем диалог сохранения файла
  if SaveTextAsFileDialog.Execute then
  begin
    //--Создаём лист строк
    list := TStringList.Create;
    try
      //--Выделяем весь текст в истории
      HTMLHistoryViewer.SelectAll;
      //--Копируем выделенный текст в лист
      list.Text := HTMLHistoryViewer.SelText;
      //--Сбрасываем выделение текста
      HTMLHistoryViewer.SelLength := 0;
      //--Сохраняем текст из листа в файл из диалога
      list.SaveToFile(SaveTextAsFileDialog.FileName);
    finally
      list.Free;
    end;
  end;
end;

procedure THistoryForm.DeleteHistoryBitBtnClick(Sender: TObject);
var
  Doc: string;
  i: integer;
begin
  //--Если путь к файлу пустой, то выходим
  if (ReqHUIN = EmptyStr) or (ReqCType = EmptyStr) then Exit;
  //--Выводим запрос на удаление файла истории
  i := MessageBox(Handle, PChar(HistoryDelL), PChar(WarningHead), MB_TOPMOST or MB_YESNO or MB_ICONQUESTION);
  //--Если ответ положительный
  if i = 6 then
  begin
    //--Удаляем файл
    if FileExists(ProfilePath + 'Profile\History\' + ReqCType + '_' + ReqHUIN + '.z') then
      DeleteFile(ProfilePath + 'Profile\History\' + ReqCType + '_' + ReqHUIN + '.z');
    //--Очищаем компонент истории
    HTMLHistoryViewer.Clear;
    Doc := EmptyStr;
    HTMLHistoryViewer.LoadFromBuffer(PChar(Doc), Length(Doc), EmptyStr);
  end;
end;

procedure THistoryForm.CloseBitBtnClick(Sender: TObject);
begin
  //--Закрываем окно с историей
  Close;
end;

procedure THistoryForm.ContactsComboBoxChange(Sender: TObject);
begin
  //--Загружаем файл с историей выбранного контакта
  LoadHistoryFromFile(ContactsComboBox.Text, true);
  if SearchTextEdit.CanFocus then SearchTextEdit.SetFocus;
end;

procedure THistoryForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //--Указываем, что окно после закрытия уничтожится
  Action := caFree;
  HistoryForm := nil;
end;

procedure THistoryForm.FormCreate(Sender: TObject);
begin
  //--Инициализируем XML
  with TrXML.Create() do
  try
    //--Загружаем настройки
    if FileExists(ProfilePath + SettingsFileName) then
    begin
      LoadFromFile(ProfilePath + SettingsFileName);
      //--Загружаем позицию окна
      if OpenKey('settings\forms\historyform\position') then
      try
        Top := ReadInteger('top');
        Left := ReadInteger('left');
        Height := ReadInteger('height');
        Width := ReadInteger('width');
        //--Определяем не находится ли окно за пределами экрана
        MainForm.FormSetInWorkArea(self);;
      finally
        CloseKey();
      end;
    end;
  finally
    Free();
  end;
  //--Переводим окно на другие языки
  TranslateForm;
  //--Назначаем иконки окну и кнопкам
  MainForm.AllImageList.GetIcon(147, Icon);
  MainForm.AllImageList.GetBitmap(221, SearchTextBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(6, ReloadHistoryBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(150, SaveHistoryAsBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(148, DeleteHistoryBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(3, CloseBitBtn.Glyph);
  //--Создаём список имеющихся файлов истории для выбора
  ListFileDirHist(ProfilePath + 'Profile\History', '*.z', '.z', ContactsComboBox.Items);
  //--Делаем окно независимым и ставим его кнопку в панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure THistoryForm.FormDestroy(Sender: TObject);
begin
  //--Создаём необходимые папки
  ForceDirectories(ProfilePath + 'Profile');
  //--Сохраняем настройки положения окна истории в xml
  with TrXML.Create() do
  try
    if FileExists(ProfilePath + SettingsFileName) then
      LoadFromFile(ProfilePath + SettingsFileName);
    //--Сохраняем позицию окна
    if OpenKey('settings\forms\historyform\position', True) then
    try
      WriteInteger('top', Top);
      WriteInteger('left', Left);
      WriteInteger('height', Height);
      WriteInteger('width', Width);
    finally
      CloseKey();
    end;
    //--Записываем сам файл
    SaveToFile(ProfilePath + SettingsFileName);
  finally
    Free();
  end;
end;

procedure THistoryForm.HTMLHistoryViewerKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //--При нажатии клавиш контрл + с копируем выделенный текст в буфер обмена
  if (GetKeyState(VK_CONTROL) < 0) and (Key = 67) then
  begin
    HTMLHistoryViewer.CopyToClipboard;
  end;
end;

end.

