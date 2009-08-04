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
  ExtDlgs, SimpleXML;

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
  MainUnit, ChatUnit, UtilsUnit;

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
    //--Очистили компонент истории
    HTMLHistoryViewer.Clear;
    //--Загружаем файл истории сообщений
    HistoryFile := MyPath + 'Profile\History\' + hUIN + '.z';
    if FileExists(HistoryFile) then
    begin
      try
        //--Распаковываем файл с историей
        UnZip_File(HistoryFile, MyPath + 'Profile\History\');
        //--Добавляем стили
        Doc := '<html><head>' + ChatCSS + '<title>Chat</title></head><body>';
        //--Записываем историю
        Doc := Doc + ReadFromFile(MyPath + 'Profile\History\Icq_History.htm');
        //--Удаляем уже не нужный распакованный файл с историей
        if FileExists(MyPath + 'Profile\History\Icq_History.htm') then DeleteFile(MyPath + 'Profile\History\Icq_History.htm');
        if not TextSmilies then ChatForm.CheckMessage_Smilies(Doc);
        SetLength(Doc, Length(Doc) - 6);
        Doc := Doc + '<HR>';
        HTMLHistoryViewer.LoadFromBuffer(PChar(Doc), Length(Doc), '');
        HTMLHistoryViewer.Position := HTMLHistoryViewer.VScrollBar.Max;
        //--Ставим каретку в самый низ текста
        HTMLHistoryViewer.CaretPos := Length(Doc);
      except
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
            if Categories[I].Items[II].History = '' then
            begin
              //--Загружаем файл истории сообщений
              HistoryFile := MyPath + 'Profile\History\' + ReqCType + '_' + hUIN + '.z';
              if FileExists(HistoryFile) then
              begin
                try
                  //--Распаковываем файл с историей
                  UnZip_File(HistoryFile, MyPath + 'Profile\History\');
                  //--Записываем историю в хранилище у этого контакта
                  Categories[I].Items[II].History := ReadFromFile(MyPath + 'Profile\History\Icq_History.htm');
                  //--Удаляем уже не нужный распакованный файл с историей
                  if FileExists(MyPath + 'Profile\History\Icq_History.htm') then DeleteFile(MyPath + 'Profile\History\Icq_History.htm');
                except
                end;
              end;
            end;
            //--Отображаем историю в чате
            if Categories[I].Items[II].History <> '' then
            begin
              //--Очистили компонент истории
              HTMLHistoryViewer.Clear;
              //--Добавляем стили
              Doc := '<html><head>' + ChatCSS + '<title>Chat</title></head><body>';
              //--Загружаем из файла истории указанное количесво сообщений
              Doc := Doc + Categories[I].Items[II].History;
              if not TextSmilies then ChatForm.CheckMessage_Smilies(Doc);
              SetLength(Doc, Length(Doc) - 6);
              Doc := Doc + '<HR>';
              HTMLHistoryViewer.LoadFromBuffer(PChar(Doc), Length(Doc), '');
              HTMLHistoryViewer.Position := HTMLHistoryViewer.VScrollBar.Max;
              //--Ставим каретку в самый низ текста
              HTMLHistoryViewer.CaretPos := Length(Doc);
            end
            else
            begin
              //--Очистили компонент истории
              HTMLHistoryViewer.Clear;
              //--Добавляем стили
              Doc := '<html><head>' + ChatCSS + '<title>Chat</title></head><body>';
              Doc := Doc + '<span class=d>' + HistoryNotFile + '</span>';
              HTMLHistoryViewer.LoadFromBuffer(PChar(Doc), Length(Doc), '');
            end;
            //--Выходим из цыкла если нашли контакт
            goto x;
          end;
          //--Не замораживаем интерфэйс
          Application.ProcessMessages;
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
    HistoryPopupMenu.Items.Items[0].Enabled := false;
  end
  else
  begin
    HistoryPopupMenu.Items.Items[0].Enabled := true;
  end;
end;

procedure THistoryForm.TranslateForm;
begin
  //--Переводим форму на другие языки

end;

procedure THistoryForm.SearchTextBitBtnClick(Sender: TObject);
begin
  //--Делаем поиск текста в истории
  HTMLHistoryViewer.FindEx(SearchTextEdit.Text, RegistrCheckBox.Checked, UpSearchCheckBox.Checked);
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
  if (ReqHUIN = '') or (ReqCType = '') then Exit;
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
  if (ReqHUIN = '') or (ReqCType = '') then Exit;
  //--Выводим запрос на удаление файла истории
  i := MessageBox(Handle, PChar(HistoryDelL), PChar(WarningHead), MB_TOPMOST or MB_YESNO or MB_ICONQUESTION);
  //--Если ответ положительный
  if i = 6 then
  begin
    //--Удаляем файл
    if FileExists(MyPath + 'Profile\History\' + ReqCType + '_' + ReqHUIN + '.z') then
      DeleteFile(MyPath + 'Profile\History\' + ReqCType + '_' + ReqHUIN + '.z');
    //--Очищаем компонент истории
    HTMLHistoryViewer.Clear;
    Doc := '';
    HTMLHistoryViewer.LoadFromBuffer(PChar(Doc), Length(Doc), '');
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
var
  Xml: IXmlDocument;
  XmlElem: IXmlNode;
begin
  //--Инициализируем XML
  try
    Xml := CreateXmlDocument;
    //--Загружаем настройки
    if FileExists(MyPath + 'Profile\HistoryForm.xml') then
    begin
      Xml.Load(MyPath + 'Profile\HistoryForm.xml');
      //--Загружаем позицию окна
      XmlElem := Xml.DocumentElement.SelectSingleNode('historyform-position');
      if XmlElem <> nil then
      begin
        Top := XmlElem.GetIntAttr('top');
        Left := XmlElem.GetIntAttr('left');
        Height := XmlElem.GetIntAttr('height');
        Width := XmlElem.GetIntAttr('width');
        //--Определяем не находится ли окно за пределами экрана
        while Top + Height > Screen.Height do Top := Top - 50;
        while Left + Width > Screen.Width do Left := Left - 50;
      end;
    end;
  except
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
  ListFileDirHist(MyPath + 'Profile\History', '*.z', '.z', ContactsComboBox.Items);
  //--Делаем окно независимым и ставим его кнопку в панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure THistoryForm.FormDestroy(Sender: TObject);
var
  Xml: IXmlDocument;
  XmlElem: IXmlNode;
begin
  //--Создаём необходимые папки
  ForceDirectories(MyPath + 'Profile');
  //--Сохраняем настройки положения окна истории в xml
  try
    Xml := CreateXmlDocument('xml');
    //--Сохраняем позицию окна
    XmlElem := Xml.DocumentElement.AppendElement('historyform-position');
    XmlElem.SetIntAttr('top', Top);
    XmlElem.SetIntAttr('left', Left);
    XmlElem.SetIntAttr('height', Height);
    XmlElem.SetIntAttr('width', Width);
    //--Записываем сам файл
    Xml.Save(MyPath + 'Profile\HistoryForm.xml');
  except
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

