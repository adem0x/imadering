{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit MemoUnit;

interface

{$REGION 'Uses'}

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  CategoryButtons,
  Buttons;

type
  TMemoForm = class(TForm)
    InfoMemo: TMemo;
    HeadLabel: TLabel;
    YesBitBtn: TBitBtn;
    NoBitBtn: TBitBtn;
    CountLabel: TLabel;
    procedure YesBitBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure NoBitBtnClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure InfoMemoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    Invite: Boolean;
    UpDate: Boolean;
    Twit: Boolean;
    procedure UpDateVersion(M: string);
    procedure PostInTwitter(M: string);
    procedure TranslateForm;
  end;

{$ENDREGION}

var
  MemoForm: TMemoForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  IcqProtoUnit,
  VarsUnit,
  UtilsUnit,
  OverbyteIcsUrl,
  OverbyteIcsHttpProt,
  LoginUnit,
  ChatUnit;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TMemoForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TMemoForm.FormCreate(Sender: TObject);
begin
  TranslateForm;
  // Присваиваем иконку окну и кнопке
  MainForm.AllImageList.GetBitmap(139, NoBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(140, YesBitBtn.Glyph);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

{$ENDREGION}
{$REGION 'FormShow'}

procedure TMemoForm.FormShow(Sender: TObject);
begin
  // Если Твит, то ставим фокус в поле ввода
  if (Twit) and (InfoMemo.CanFocus) then
  begin
    InfoMemo.SetFocus;
    InfoMemo.SelStart := InfoMemo.GetTextLen;
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMemoForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TMemoForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Автоматически уничтожаем форму при закрытии
  Action := CaFree;
  MemoForm := nil;
end;

procedure TMemoForm.NoBitBtnClick(Sender: TObject);
begin
  // Закрываем окно
  Close;
end;

{$ENDREGION}
{$REGION 'InfoMemoChange'}

procedure TMemoForm.InfoMemoChange(Sender: TObject);
begin
  // Отображаем счётчик символов
  if Twit then
  begin
    CountLabel.Caption := Format(Lang_Vars[62].L_S, [InfoMemo.GetTextLen, 140]);
    if InfoMemo.GetTextLen > 140 then
      CountLabel.Font.Color := clRed
    else
      CountLabel.Font.Color := clGreen;
  end;
end;

{$ENDREGION}
{$REGION 'UpDateVersion'}

procedure TMemoForm.UpDateVersion(M: string);
begin
  // Ставим иконку окну
  MainForm.AllImageList.GetIcon(6, Icon);
  // Отображаем информацию и запрос на закачку новой версии
  Caption := Lang_Vars[42].L_S;
  HeadLabel.Caption := Lang_Vars[41].L_S;
  CountLabel.Caption := EmptyStr;
  InfoMemo.Text := Lang_Vars[13].L_S + C_RN + C_RN + M;
  // Ставим флаги функции окна
  UpDate := True;
  Invite := False;
  Twit := False;
  // Блокируем мемо
  InfoMemo.readonly := True;
  InfoMemo.Color := ClBtnFace;
end;

{$ENDREGION}
{$REGION 'PostInTwitter'}

procedure TMemoForm.PostInTwitter(M: string);
begin
  // Ставим иконку окну
  MainForm.AllImageList.GetIcon(272, Icon);
  // Отображаем информацию и запрос на закачку новой версии
  Caption := Format(Lang_Vars[61].L_S, [C_Twitter]);
  HeadLabel.Caption := Format(Lang_Vars[61].L_S, [C_Twitter]);
  InfoMemo.Text := M;
  // Ставим флаги функции окна
  UpDate := False;
  Invite := False;
  Twit := True;
  // Разблокируем мемо
  InfoMemo.ReadOnly := False;
  InfoMemo.Color := ClWindow;
  // Обновляем счётчик
  InfoMemoChange(nil);
end;

{$ENDREGION}
{$REGION 'YesBitBtnClick'}

procedure TMemoForm.YesBitBtnClick(Sender: TObject);
// label
// x;
var
  FrmLogin: TLoginForm;
begin
  // Автообновление
  if UpDate then
  begin
    // Открываем офсайт
    OpenURL(C_SitePage);
    // Закрываем это окно
    Close;
  end
  else if Twit then // Пост в Твиттер
  begin
    V_Twitter_PostMsg := Trim(InfoMemo.Text);
    if V_Twitter_PostMsg <> EmptyStr then
    begin
      // Ограничиваем длинну текста
      if Length(V_Twitter_PostMsg) > 140 then
        SetLength(V_Twitter_PostMsg, 140);
      // Проверяем логин Твита
      if (V_Twitter_Username = EmptyStr) or (V_Twitter_Password = EmptyStr) then
      begin
        FrmLogin := TLoginForm.Create(Application);
        try
          MainForm.AllImageList.GetIcon(268, FrmLogin.Icon);
          FrmLogin.Caption := C_Twitter;
          // Модально спрашиваем логин и пароль
          if FrmLogin.ShowModal = MrOk then
          begin
            // Сохраняем в настройках логин и пароль для Twitter

            if FrmLogin.SavePassCheckBox.Checked then
            begin

            end;
            // Запоминаем логин и пароль твиттера
            V_Twitter_Username := FrmLogin.AccountEdit.Text;
            V_Twitter_Password := FrmLogin.PasswordEdit.Text;
          end;
        finally
          FreeAndNil(FrmLogin);
        end;
      end;
      // Запускаем авторизацию в твиттер
      if (V_Twitter_Username <> EmptyStr) and (V_Twitter_Password <> EmptyStr) then
      begin
        // Обнуляем параметры Twitter
        V_Twitter_OAuth_Signature := EmptyStr;
        V_Twitter_OAuth_Token := EmptyStr;
        V_Twitter_OAuth_Token_Secret := EmptyStr;
        V_Twitter_Authenticity_Token := EmptyStr;
        V_Twitter_OAuth_PIN := EmptyStr;
        // Начинаем заполнение параметров
        V_Twitter_Params := TStringList.Create;
        try
          V_Twitter_OAuth_Consumer_Key := C_Twitter_OAuth_Consumer_Key + X_Twitter_OAuth_Consumer_Key;
          V_Twitter_OAuth_Nonce := C_Twitter_OAuth_Nonce + Twitter_Generate_Nonce;
          V_Twitter_OAuth_Timestamp := C_Twitter_OAuth_Timestamp + IntToStr(DateTimeToUnix(Now));
          with V_Twitter_Params do
          begin
            Add(V_Twitter_OAuth_Consumer_Key);
            Add(V_Twitter_OAuth_Nonce);
            Add(C_Twitter_OAuth_Signature_Method);
            Add(V_Twitter_OAuth_Timestamp);
            Add(C_Twitter_OAuth_Version);
          end;
          V_Twitter_OAuth_Signature := Twitter_HMAC_SHA1_Signature(C_Twitter_Host + C_Twitter_Request_Token, C_GET, EmptyStr, V_Twitter_Params);
        finally
          V_Twitter_Params.Free;
        end;
        // Делаем запрос ключей от twitter
        with MainForm.TwitterClient do
        begin
          // Сбрасываем сокет если он занят чем то другим или висит
          Close;
          Abort;
          // Ставим флаг задания
          Tag := 0;
          // Запускаем авторизацию в Twitter
          URL := V_Twitter_OAuth_Signature;
          XLog(C_Twitter + C_BN + Log_Send, URL, C_Twitter, False);
          GetASync;
        end;
      end;
    end;
    // Закрываем это окно
    Close;
  end;

  { if RoasterForm.Roaster_Sel_Button = nil then goto x;
    //
    if Invite then
    begin
    Sini := TIniFile.Create(Mypath + 'Config.ini');
    Sini.WriteString('qwe', 'Invite', Encrypt(Memo1.Text, 12345));
    Sini.Free;
    //
    ICQ_SendMessage_0406(RoasterForm.Roaster_Sel_Button.UIN, Memo1.Text, true);
    end
    else
    begin
    ICQ_SendGrandAuth(RoasterForm.Roaster_Sel_Button.UIN);
    ICQ_ReqAuthSend(RoasterForm.Roaster_Sel_Button.UIN, Memo1.Text);
    end;
    //
    x: ;
    ModalResult := mrOk; }
end;

{$ENDREGION}

end.

