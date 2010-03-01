﻿// Изменения для проекта IMadering

{ -----------------------------------------------------------------------------
  The contents of this file are subject to the Mozilla Public License
  Version 1.1 (the "License"); you may not use this file except in compliance
  with the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/MPL-1.1.html

  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
  the specific language governing rights and limitations under the License.

  The Original Code is: JvDesktopAlert.PAS, released on 2004-03-23.

  The Initial Developer of the Original Code is Peter Thornqvist <peter3 at sourceforge dot net>
  Portions created by Peter Thornqvist are Copyright (C) 2004 Peter Thornqvist.
  All Rights Reserved.

  Contributor(s):
  Hans-Eric Grnlund (stack logic)
  Olivier Sannier (animation styles logic)
  Miha Vrhovnik (custom form display logic)

  You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
  located at http://jvcl.delphi-jedi.org

  Known Issues:
  ----------------------------------------------------------------------------- }
// $Id: JvDesktopAlert.pas 99 2009-07-19 11:15:47Z obones $

unit JvDesktopAlert;

{$I jvcl.inc}

interface

uses

{$IFDEF UNITVERSIONING}

  JclUnitVersioning,

{$ENDIF UNITVERSIONING}

  Windows,
  Classes,
  Controls,
  Graphics,
  Forms,
  ExtCtrls,
  Menus,
  ImgList,
  JvComponentBase,
  JvBaseDlg,
  JvDesktopAlertForm;

// Начало изменений

var
  JvDefaultFrameColor: TColor = TColor(clWhite);
  JvDefaultWindowFromColor: TColor = TColor($0092FFFF);
  JvDefaultWindowToColor: TColor = TColor($00B6FFFF);
  JvDefaultCaptionFromColor: TColor = TColor(clWhite);
  JvDefaultCaptionToColor: TColor = TColor(clWhite);

// Конец изменений

type
  // The possible animation styles as an enumeration
  TJvAlertStyle = (AsFade, AsCenterGrow);

  // The different status a style handler can have
  TJvStyleHandlerStatus = (HsIdle, HsStartAnim, HsEndAnim, HsDisplay);

  TJvCustomDesktopAlertStyleHandler = class;

  TJvDesktopAlertStack = class;
  TJvDesktopAlert = class;

  TJvDesktopAlertChangePersistent = class(TPersistent)
  private
    FOnChange: TNotifyEvent;

  protected
    procedure Change;

  public
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TJvDesktopAlertColors = class(TJvDesktopAlertChangePersistent)
  private
    FWindowFrom: TColor;
    FCaptionTo: TColor;
    FWindowTo: TColor;
    FFrame: TColor;
    FCaptionFrom: TColor;
    procedure SetCaptionFrom(const Value: TColor);
    procedure SetCaptionTo(const Value: TColor);
    procedure SetFrame(const Value: TColor);
    procedure SetWindowFrom(const Value: TColor);
    procedure SetWindowTo(const Value: TColor);

  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;

  published
    property Frame: TColor read FFrame write SetFrame default clWhite;
    property WindowFrom: TColor read FWindowFrom write SetWindowFrom default TColor($009DCDFF);
    property WindowTo: TColor read FWindowTo write SetWindowTo default TColor($00DAF4FF);
    property CaptionFrom: TColor read FCaptionFrom write SetCaptionFrom default TColor($00AEC2FF);
    property CaptionTo: TColor read FCaptionTo write SetCaptionTo default TColor($00ABBCFF);
  end;

  TJvDesktopAlertPosition = (DapTopLeft, DapTopRight, DapBottomLeft, DapBottomRight, DapCustom, DapDesktopCenter, DapMainFormCenter,
    DapOwnerFormCenter, DapActiveFormCenter, DapMainFormTopLeft, DapMainFormTopRight, DapMainFormBottomLeft, DapMainFormBottomRight,
    DapOwnerFormTopLeft, DapOwnerFormTopRight, DapOwnerFormBottomLeft, DapOwnerFormBottomRight, DapActiveFormTopLeft,
    DapActiveFormTopRight, DapActiveFormBottomLeft, DapActiveFormBottomRight);

  TJvDesktopAlertLocation = class(TJvDesktopAlertChangePersistent)
  private
    FTop: Integer;
    FLeft: Integer;
    FPosition: TJvDesktopAlertPosition;
    FAlwaysResetPosition: Boolean;
    FHeight: Integer;
    FWidth: Integer;
    procedure SetTop(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetPosition(const Value: TJvDesktopAlertPosition);
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);

  public
    constructor Create;

  published
    property Position: TJvDesktopAlertPosition read FPosition write SetPosition default DapBottomRight;
    property Top: Integer read FTop write SetTop;
    property Left: Integer read FLeft write SetLeft;
    property Width: Integer read FWidth write SetWidth;
    property Height: Integer read FHeight write SetHeight;
    property AlwaysResetPosition: Boolean read FAlwaysResetPosition write FAlwaysResetPosition default True;
  end;

  TJvDesktopAlertButtonItem = class(TCollectionItem)
  private
    FImageIndex: Integer;
    FOnClick: TNotifyEvent;
    FTag: Integer;

  public
    procedure Assign(Source: TPersistent); override;

  published
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property Tag: Integer read FTag write FTag;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TJvDesktopAlertButtons = class(TOwnedCollection)
  private
    function GetItem(index: Integer): TJvDesktopAlertButtonItem;
    procedure SetItem(index: Integer; const Value: TJvDesktopAlertButtonItem);

  public
    constructor Create(AOwner: TPersistent);
    function Add: TJvDesktopAlertButtonItem;
    property Items[index: Integer]: TJvDesktopAlertButtonItem read GetItem write SetItem; default;
    procedure Assign(Source: TPersistent); override;
  end;

  TJvDesktopAlertOption = (DaoCanClick, DaoCanMove, DaoCanMoveAnywhere, DaoCanClose);
  TJvDesktopAlertOptions = set of TJvDesktopAlertOption;

  TJvCustomDesktopAlert = class(TJvCommonDialogP)
  private
    FStacker: TJvDesktopAlertStack;
    FColors: TJvDesktopAlertColors;
    FLocation: TJvDesktopAlertLocation;
    FOptions: TJvDesktopAlertOptions;
    FAutoFocus: Boolean;
    FAutoFree: Boolean;
    FAlertStyle: TJvAlertStyle;
    FStyleHandler: TJvCustomDesktopAlertStyleHandler;

    function GetStacker: TJvDesktopAlertStack;
    procedure SetColors(const Value: TJvDesktopAlertColors);
    function GetAlertStack: TJvDesktopAlertStack;
    procedure SetAlertStack(const Value: TJvDesktopAlertStack);
    procedure SetLocation(const Value: TJvDesktopAlertLocation);
    procedure DoLocationChange(Sender: TObject);
    procedure SetOptions(const Value: TJvDesktopAlertOptions);
    procedure SetStyleHandler(const Value: TJvCustomDesktopAlertStyleHandler);
    procedure SetAlertStyle(const Value: TJvAlertStyle);

  protected
    FDesktopForm: TJvCustomFormDesktopAlert;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure InternalOnMove(Sender: TObject);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Showing: Boolean;
    procedure Close(Immediate: Boolean);
    function Execute: Boolean; override;
    property StyleHandler: TJvCustomDesktopAlertStyleHandler read FStyleHandler write SetStyleHandler;

  published
    property AlertStack: TJvDesktopAlertStack read GetAlertStack write SetAlertStack;
    property AlertStyle: TJvAlertStyle read FAlertStyle write SetAlertStyle default AsFade;
    property AutoFocus: Boolean read FAutoFocus write FAutoFocus default False;
    property AutoFree: Boolean read FAutoFree write FAutoFree default False;

    property Options: TJvDesktopAlertOptions read FOptions write SetOptions default[DaoCanClick .. DaoCanClose];
    property Colors: TJvDesktopAlertColors read FColors write SetColors;
    property Location: TJvDesktopAlertLocation read FLocation write SetLocation;

    // This property is equivalent to StyleHandler, it is just renamed to look better in the inspector
    property StyleOptions: TJvCustomDesktopAlertStyleHandler read FStyleHandler write SetStyleHandler;
  end;

  TJvDesktopAlert = class(TJvCustomDesktopAlert)
  private
    FImages: TCustomImageList;
    FButtons: TJvDesktopAlertButtons;
    FOnClose: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    FOnMessageClick: TNotifyEvent;
    FOnShow: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FData: TObject;
    FOnShown: TNotifyEvent;
    FOnShowing: TNotifyEvent;
    procedure SetButtons(const Value: TJvDesktopAlertButtons);
    procedure SetDropDownMenu(const Value: TPopupMenu);
    procedure SetFont(const Value: TFont);
    procedure SetHeaderFont(const Value: TFont);
    procedure SetImage(const Value: TPicture);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetPopupMenu(const Value: TPopupMenu);
    procedure InternalOnShowing(Sender: TObject);
    procedure InternalOnShow(Sender: TObject);
    procedure InternalOnShown(Sender: TObject);
    procedure InternalOnClose(Sender: TObject; var Action: TCloseAction);
    procedure InternalMouseEnter(Sender: TObject);
    procedure InternalMouseLeave(Sender: TObject);
    procedure InternalMessageClick(Sender: TObject);
    function GetFont: TFont;
    function GetHeaderFont: TFont;
    function GetImage: TPicture;
    function GetDropDownMenu: TPopupMenu;
    function GetHeaderText: string;
    function GetMessageText: string;
    function GetPopupMenu: TPopupMenu;
    procedure SetHeaderText(const Value: string);
    procedure SetMessageText(const Value: string);
    function GetParentFont: Boolean;
    function GetShowHint: Boolean;
    function GetHint: string;
    procedure SetHint(const Value: string);
    procedure SetParentFont(const Value: Boolean);
    procedure SetShowHint(const Value: Boolean);
    function GetCloseButtonClick: TNotifyEvent;
    procedure SetCloseButtonClick(const Value: TNotifyEvent);
    function GetBiDiMode: TBidiMode;
    procedure SetBiDiMode(const Value: TBidiMode);
    function GetDesktopForm: TJvFormDesktopAlert;
    property DesktopForm: TJvFormDesktopAlert read GetDesktopForm;

  protected
    FFormButtons: array of TControl;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;
    property Form: TJvCustomFormDesktopAlert read FDesktopForm;
    property Data: TObject read FData write FData;

  published
    property AlertStack;
    property AlertStyle;
    property AutoFocus;
    property AutoFree;

    property Options;
    property Colors;
    property Location;

    property StyleOptions;

    property BiDiMode: TBidiMode read GetBiDiMode write SetBiDiMode default BdLeftToRight;
    property HeaderText: string read GetHeaderText write SetHeaderText;
    property MessageText: string read GetMessageText write SetMessageText;

    property HeaderFont: TFont read GetHeaderFont write SetHeaderFont;
    property Hint: string read GetHint write SetHint;
    property ShowHint: Boolean read GetShowHint write SetShowHint;
    property Font: TFont read GetFont write SetFont;
    property ParentFont: Boolean read GetParentFont write SetParentFont;
    property Buttons: TJvDesktopAlertButtons read FButtons write SetButtons;
    property Image: TPicture read GetImage write SetImage;
    property Images: TCustomImageList read FImages write SetImages;
    property DropDownMenu: TPopupMenu read GetDropDownMenu write SetDropDownMenu;
    property PopupMenu: TPopupMenu read GetPopupMenu write SetPopupMenu;

    property OnShowing: TNotifyEvent read FOnShowing write FOnShowing;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnShown: TNotifyEvent read FOnShown write FOnShown;
    property OnCloseButtonClick: TNotifyEvent read GetCloseButtonClick write SetCloseButtonClick;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnMessageClick: TNotifyEvent read FOnMessageClick write FOnMessageClick;
  end;

  TJvDesktopAlertForm = class(TJvCustomDesktopAlert)
  private
    procedure SetForm(const Value: TJvCustomFormDesktopAlert);

  protected
  public
    property Form: TJvCustomFormDesktopAlert read FDesktopForm write SetForm;
    function Execute: Boolean; override;

  published
    property AlertStack;
    property AlertStyle;
    property AutoFocus;
    property AutoFree;

    property Options;
    property Colors;
    property Location;

    property StyleOptions;
  end;

  TJvDesktopAlertStack = class(TJvComponent)
  private
    FItems: TList;
    FPosition: TJvDesktopAlertPosition;
    function GetCount: Integer;
    function GetItems(index: Integer): TJvCustomFormDesktopAlert;
    procedure SetPosition(const Value: TJvDesktopAlertPosition);

  protected
    procedure UpdatePositions; virtual;

  public
    procedure Add(AForm: TCustomForm); virtual;
    procedure Remove(AForm: TCustomForm); virtual;

    property Items[index: Integer]: TJvCustomFormDesktopAlert read GetItems;
    property Count: Integer read GetCount;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    // all forms must have the same position property
    property Position: TJvDesktopAlertPosition read FPosition write SetPosition default DapBottomRight;
  end;

  // Common ancestor of all the alert styles for a TJvCustomFormDesktopAlert
  TJvCustomDesktopAlertStyleHandler = class(TPersistent)
  private
    FAnimTimer: TTimer;
    FOwnerForm: TJvCustomFormDesktopAlert;
    FStartSteps: Cardinal;
    FEndSteps: Cardinal;
    FEndInterval: Cardinal;
    FStartInterval: Cardinal;
    FDisplayDuration: Cardinal;
    FCurrentStep: Cardinal;
    FStatus: TJvStyleHandlerStatus;
    procedure SetDisplayDuration(const Value: Cardinal);
    procedure SetOwnerForm(const Value: TJvCustomFormDesktopAlert);
    function GetActive: Boolean;

  protected
    procedure SetEndInterval(const Value: Cardinal); virtual;
    procedure SetEndSteps(const Value: Cardinal); virtual;
    procedure SetStartInterval(const Value: Cardinal); virtual;
    procedure SetStartSteps(const Value: Cardinal); virtual;
    // This procedure will be called for each step of the starting animation
    // It will be called StartSteps time, every StartInterval milliseconds
    // The implementation here only ensures that once the number of steps
    // is reached, the timer is stopped
    procedure StartAnimTimer(Sender: TObject); virtual;
    // This procedure will be called for each step of the ending animation
    // It will be called EndSteps time, every EndInterval milliseconds
    // The implementation here only ensures that once the number of steps
    // is reached, the timer is stopped and then calls DoDisplay
    procedure EndAnimTimer(Sender: TObject); virtual;
    // This procedure will be called once after DisplayDuration
    // (if it is > 0) when the start animation is finished.
    procedure DisplayTimer(Sender: TObject); virtual;
    // This procedure is called just before the start animation timer
    // is enabled. Use it to setup initial values required for the
    // animation
    // As implemented in this base class, the owner form is shown
    procedure PrepareStartAnimation; virtual;
    // This procedure is called just after the start animation has finished
    // Use it to set the final values of the animation
    procedure FinalizeStartAnimation; virtual; abstract;
    // This procedure is called just before the end animation timer
    // is enabled. Use it to setup initial values required for the
    // animation
    procedure PrepareEndAnimation; virtual; abstract;
    // This procedure is called just after the end animation has finished
    // Use it to set the final values of the animation
    // As implemented in this base class, this closes the owner form.
    // Note: It is required to close the form or the end animation
    // will keep being repeated
    procedure FinalizeEndAnimation; virtual;
    // The timer used for all animations and waits
    property AnimTimer: TTimer read FAnimTimer;

  public
    constructor Create(OwnerForm: TJvCustomFormDesktopAlert); virtual;
    destructor Destroy; override;
    // Sets up the timer to call StartAnimTimer on the correct interval
    // then show the owner form.
    // If StartSteps is not greater than 0, the animation will not start
    // and the form will not be shown.
    procedure DoStartAnimation; virtual;
    // Sets up the timer to call EndAnimTimer on the correct interval
    // If EndSteps is not greater than 0, the animation will not start
    procedure DoEndAnimation; virtual;
    // Sets up the timer to call DisplayTimer after the correct delay
    // If DisplayDuration is equal to 0, the timer is not enabled and
    // DisplayTimer will never be called
    procedure DoDisplay; virtual;
    // Aborts the current animation, if any. Will call the proper Finalize
    // function as applicable. The middle wait is NOT aborted by a call
    // to this function
    procedure AbortAnimation; virtual;
    // The owner form, the form to which the style is associated.
    // This value MUST NOT be nil when any of the DoXXXX function is called
    property OwnerForm: TJvCustomFormDesktopAlert read FOwnerForm write SetOwnerForm;
    // The current step in the animation (starts at 0, use Active to know
    // if an animation or wait is in progress).
    property CurrentStep: Cardinal read FCurrentStep;
    // Returns AnimTimer.Enabled
    property Active: Boolean read GetActive;
    // Returns the status of the handler
    property Status: TJvStyleHandlerStatus read FStatus;

  published
    // The duration between each step of the start animation
    property StartInterval: Cardinal read FStartInterval write SetStartInterval;
    // The number of steps in the start animation
    property StartSteps: Cardinal read FStartSteps write SetStartSteps;
    // The duration between each step of the end animation
    property EndInterval: Cardinal read FEndInterval write SetEndInterval;
    // The number of steps in the end animation
    property EndSteps: Cardinal read FEndSteps write SetEndSteps;
    // The duration of the middle wait (between the end of the start
    // animation and the beginning of the end animation)
    property DisplayDuration: Cardinal read FDisplayDuration write SetDisplayDuration;
  end;

  // This style will make the form fade in and fade out.
  // NOTE: This is only supported by Delphi or C++ Builder 6 and above
  // NOTE: Even if the compiler supports it, this only works if the
  // operating system is Windows 2000 or Windows XP
  TJvFadeAlertStyleHandler = class(TJvCustomDesktopAlertStyleHandler)
  private
    FMinAlphaBlendValue: Byte;
    FCurrentAlphaBlendValue: Byte;
    FMaxAlphaBlendValue: Byte;
    procedure SetMinAlphaBlendValue(const Value: Byte);
    procedure SetMaxAlphaBlendValue(const Value: Byte);

  protected
    procedure StartAnimTimer(Sender: TObject); override;
    procedure EndAnimTimer(Sender: TObject); override;
    // Applies the current alpha blend value to the owner form
    procedure DoAlphaBlend(Value: Byte);
    procedure PrepareStartAnimation; override;
    procedure FinalizeStartAnimation; override;
    procedure PrepareEndAnimation; override;
    procedure FinalizeEndAnimation; override;

  public
    constructor Create(OwnerForm: TJvCustomFormDesktopAlert); override;
    procedure AbortAnimation; override;

  published
    property MinAlphaBlendValue: Byte read FMinAlphaBlendValue write SetMinAlphaBlendValue default 0;
    property MaxAlphaBlendValue: Byte read FMaxAlphaBlendValue write SetMaxAlphaBlendValue default 255;
    property CurrentAlphaBlendValue: Byte read FCurrentAlphaBlendValue;
    property StartInterval default 25;
    property StartSteps default 10;
    property EndInterval default 50;
    property EndSteps default 10;
    property DisplayDuration default 1400;
  end;

  TJvCenterGrowAlertStyleHandler = class(TJvCustomDesktopAlertStyleHandler)
  private
    FMaxGrowthPercentage: Double;
    FMinGrowthPercentage: Double;
    procedure SetMaxGrowthPercentage(const Value: Double);
    procedure SetMinGrowthPercentage(const Value: Double);

  protected
    procedure StartAnimTimer(Sender: TObject); override;
    procedure EndAnimTimer(Sender: TObject); override;
    // Applies the current region growth percentage value to the owner form
    procedure DoGrowRegion(Percentage: Double);
    procedure PrepareStartAnimation; override;
    procedure FinalizeStartAnimation; override;
    procedure PrepareEndAnimation; override;
    procedure FinalizeEndAnimation; override;

  public
    constructor Create(OwnerForm: TJvCustomFormDesktopAlert); override;
    procedure AbortAnimation; override;

  published
    property StartInterval default 25;
    property StartSteps default 10;
    property EndInterval default 50;
    property EndSteps default 10;
    property DisplayDuration default 1400;
    property MinGrowthPercentage: Double read FMinGrowthPercentage write SetMinGrowthPercentage;
    property MaxGrowthPercentage: Double read FMaxGrowthPercentage write SetMaxGrowthPercentage;
  end;

function CreateHandlerForStyle(Style: TJvAlertStyle; OwnerForm: TJvCustomFormDesktopAlert): TJvCustomDesktopAlertStyleHandler;

{$IFDEF UNITVERSIONING}

const
  UnitVersioning: TUnitVersionInfo =
    (RCSfile: '$URL: https://jvcl.svn.sourceforge.net:443/svnroot/jvcl/trunk/jvcl/run/JvDesktopAlert.pas $'; Revision: '$Revision: 99 $';
    Date: '$Date: 2009-07-19 13:15:47 +0200 (dim., 19 juil. 2009) $'; LogPath: 'JVCL\run');

{$ENDIF UNITVERSIONING}

implementation

uses
  SysUtils,
  Messages,
  JvJVCLUtils,
  JvTypes;

var
  GStacker: TJvDesktopAlertStack = nil;

function CreateHandlerForStyle(Style: TJvAlertStyle; OwnerForm: TJvCustomFormDesktopAlert): TJvCustomDesktopAlertStyleHandler;
begin
  case Style of
    AsFade: Result := TJvFadeAlertStyleHandler.Create(OwnerForm);
    AsCenterGrow: Result := TJvCenterGrowAlertStyleHandler.Create(OwnerForm);
  else raise Exception.Create('');
  end;
end;

function GlobalStacker: TJvDesktopAlertStack;
begin
  if GStacker = nil then
    GStacker := TJvDesktopAlertStack.Create(nil);
  Result := GStacker;
end;

// === { TJvDesktopAlertChangePersistent } ====================================

procedure TJvDesktopAlertChangePersistent.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

// === { TJvDesktopAlertColors } ==============================================

constructor TJvDesktopAlertColors.Create;
begin
  inherited Create;
  FFrame := JvDefaultFrameColor;
  FWindowFrom := JvDefaultWindowFromColor;
  FWindowTo := JvDefaultWindowToColor;
  FCaptionFrom := JvDefaultCaptionFromColor;
  FCaptionTo := JvDefaultCaptionToColor;
end;

procedure TJvDesktopAlertColors.Assign(Source: TPersistent);
begin
  if Source is TJvDesktopAlertColors then
    begin
      if Source <> Self then
        begin
          FFrame := TJvDesktopAlertColors(Source).Frame;
          FWindowFrom := TJvDesktopAlertColors(Source).WindowFrom;
          FWindowTo := TJvDesktopAlertColors(Source).WindowTo;
          FCaptionFrom := TJvDesktopAlertColors(Source).CaptionFrom;
          FCaptionTo := TJvDesktopAlertColors(Source).CaptionTo;
          Change;
        end;
    end
  else
    inherited Assign(Source);
end;

procedure TJvDesktopAlertColors.SetCaptionFrom(const Value: TColor);
begin
  if FCaptionFrom <> Value then
    begin
      FCaptionFrom := Value;
      Change;
    end;
end;

procedure TJvDesktopAlertColors.SetCaptionTo(const Value: TColor);
begin
  if FCaptionTo <> Value then
    begin
      FCaptionTo := Value;
      Change;
    end;
end;

procedure TJvDesktopAlertColors.SetFrame(const Value: TColor);
begin
  if FFrame <> Value then
    begin
      FFrame := Value;
      Change;
    end;
end;

procedure TJvDesktopAlertColors.SetWindowFrom(const Value: TColor);
begin
  if FWindowFrom <> Value then
    begin
      FWindowFrom := Value;
      Change;
    end;
end;

procedure TJvDesktopAlertColors.SetWindowTo(const Value: TColor);
begin
  if FWindowTo <> Value then
    begin
      FWindowTo := Value;
      Change;
    end;
end;

// === { TJvDesktopAlertLocation } ============================================

constructor TJvDesktopAlertLocation.Create;
begin
  inherited Create;
  FPosition := DapBottomRight;
  FAlwaysResetPosition := True;
end;

procedure TJvDesktopAlertLocation.SetHeight(const Value: Integer);
begin
  if FHeight <> Value then
    begin
      FHeight := Value;
      Change;
    end;
end;

procedure TJvDesktopAlertLocation.SetLeft(const Value: Integer);
begin
  if FLeft <> Value then
    begin
      FLeft := Value;
      Change;
    end;
end;

procedure TJvDesktopAlertLocation.SetPosition(const Value: TJvDesktopAlertPosition);
begin
  // if FPosition <> Value then
  begin
    FPosition := Value;
    Change;
  end;
end;

procedure TJvDesktopAlertLocation.SetTop(const Value: Integer);
begin
  if FTop <> Value then
    begin
      FTop := Value;
      Change;
    end;
end;

procedure TJvDesktopAlertLocation.SetWidth(const Value: Integer);
begin
  if FWidth <> Value then
    begin
      FWidth := Value;
      Change;
    end;
end;

// === { TJvDesktopAlertButtonItem } ==========================================

procedure TJvDesktopAlertButtonItem.Assign(Source: TPersistent);
begin
  if Source is TJvDesktopAlertButtonItem then
    begin
      if Source <> Self then
        begin
          ImageIndex := TJvDesktopAlertButtonItem(Source).ImageIndex;
          OnClick := TJvDesktopAlertButtonItem(Source).OnClick;
          Tag := TJvDesktopAlertButtonItem(Source).Tag;
        end;
    end
  else
    inherited Assign(Source);
end;

// === { TJvDesktopAlertButtons } =============================================

constructor TJvDesktopAlertButtons.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TJvDesktopAlertButtonItem);
end;

function TJvDesktopAlertButtons.Add: TJvDesktopAlertButtonItem;
begin
  Result := TJvDesktopAlertButtonItem( inherited Add);
end;

procedure TJvDesktopAlertButtons.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TJvDesktopAlertButtons then
    begin
      if Source <> Self then
        begin
          Clear;
          for I := 0 to TJvDesktopAlertButtons(Source).Count - 1 do
            Add.Assign(TJvDesktopAlertButtons(Source)[I]);
        end;
    end
  else
    inherited Assign(Source);
end;

function TJvDesktopAlertButtons.GetItem(index: Integer): TJvDesktopAlertButtonItem;
begin
  Result := TJvDesktopAlertButtonItem( inherited Items[index]);
end;

procedure TJvDesktopAlertButtons.SetItem(index: Integer; const Value: TJvDesktopAlertButtonItem);
begin
  inherited Items[index] := Value;
end;


// === { TJvDesktopAlert } ====================================================

constructor TJvDesktopAlert.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButtons := TJvDesktopAlertButtons.Create(Self);
  FDesktopForm := TJvFormDesktopAlert.Create(Self);
  AlertStyle := AsFade;
  FOptions := [DaoCanClick .. DaoCanClose];
end;

destructor TJvDesktopAlert.Destroy;
begin
  FreeAndNil(FButtons);

  inherited Destroy;
end;

function TJvDesktopAlert.Execute: Boolean;
var
  I, X, Y: Integer;
  FActiveWindow, FActiveFocus: HWND;
begin
  inherited Execute;

  DesktopForm.OnShowing := InternalOnShowing;
  DesktopForm.OnShow := InternalOnShow;
  DesktopForm.OnShown := InternalOnShown;
  DesktopForm.OnClose := InternalOnClose;
  DesktopForm.OnMouseEnter := InternalMouseEnter;
  DesktopForm.OnMouseLeave := InternalMouseLeave;
  DesktopForm.OnUserMove := InternalOnMove;
  DesktopForm.LblText.OnClick := InternalMessageClick;
  DesktopForm.Moveable := (DaoCanMove in Options);
  DesktopForm.MoveAnywhere := (DaoCanMoveAnywhere in Options);
  DesktopForm.Closeable := (DaoCanClose in Options);
  DesktopForm.ClickableMessage := DaoCanClick in Options;
  if not Assigned(DesktopForm.TbClose.OnClick) then
    DesktopForm.TbClose.OnClick := DesktopForm.AcCloseExecute;

  DesktopForm.TbDropDown.DropDownMenu := DropDownMenu;
  DesktopForm.ImIcon.Picture := Image;

  DesktopForm.Font := Font;
  DesktopForm.LblHeader.Caption := HeaderText;
  DesktopForm.LblHeader.Font := HeaderFont;
  DesktopForm.LblText.Caption := MessageText;

  for I := 0 to Length(FFormButtons) - 1 do
    FFormButtons[I].Free;
  SetLength(FFormButtons, Buttons.Count);
  X := 2;
  Y := DesktopForm.Height - 23;
  for I := 0 to Length(FFormButtons) - 1 do
    begin
      FFormButtons[I] := TJvDesktopAlertButton.Create(DesktopForm);
      with TJvDesktopAlertButton(FFormButtons[I]) do
        begin
          SetBounds(X, Y, 21, 21);
          ToolType := AbtImage;
          Images := Self.Images;
          ImageIndex := Buttons[I].ImageIndex;
          Tag := Buttons[I].Tag;
          InternalClick := Buttons[I].OnClick;
          OnClick := DesktopForm.DoButtonClick;
          Parent := DesktopForm;
          Inc(X, 22);
        end;
    end;
  Location.Position := GetStacker.Position;
  if not AutoFocus then
    begin
      FActiveFocus := GetFocus;
      FActiveWindow := GetActiveWindow;
    end
  else
    begin
      FActiveWindow := NullHandle;
      FActiveFocus := NullHandle;
    end;
  DesktopForm.AllowFocus := AutoFocus;
  DesktopForm.ShowNoActivate;
  Result := True;
  if not AutoFocus and (FActiveFocus <> GetFocus) then
    begin
      if (FActiveFocus <> NullHandle) then
        SetFocus(FActiveFocus)
      else if (FActiveWindow <> NullHandle) then
        SetActiveWindow(FActiveWindow);
    end;
  GetStacker.Add(DesktopForm);
end;

function TJvDesktopAlert.GetDesktopForm: TJvFormDesktopAlert;
begin
  Result := TJvFormDesktopAlert(FDesktopForm);
end;

function TJvDesktopAlert.GetDropDownMenu: TPopupMenu;
begin
  Result := DesktopForm.TbDropDown.DropDownMenu;
end;

function TJvDesktopAlert.GetFont: TFont;
begin
  Result := DesktopForm.LblText.Font;
end;

function TJvDesktopAlert.GetHeaderFont: TFont;
begin
  Result := DesktopForm.LblHeader.Font;
end;

function TJvDesktopAlert.GetHeaderText: string;
begin
  Result := DesktopForm.LblHeader.Caption;
end;

function TJvDesktopAlert.GetImage: TPicture;
begin
  Result := DesktopForm.ImIcon.Picture;
end;

function TJvDesktopAlert.GetMessageText: string;
begin
  Result := DesktopForm.LblText.Caption;
end;

function TJvDesktopAlert.GetParentFont: Boolean;
begin
  Result := DesktopForm.ParentFont;
end;

function TJvDesktopAlert.GetPopupMenu: TPopupMenu;
begin
  Result := DesktopForm.PopupMenu;
end;

function TJvDesktopAlert.GetShowHint: Boolean;
begin
  Result := DesktopForm.ShowHint;
end;

function TJvDesktopAlert.GetHint: string;
begin
  Result := DesktopForm.Hint;
end;

procedure TJvDesktopAlert.InternalMessageClick(Sender: TObject);
var
  FEndInterval: Cardinal;
begin
  if Assigned(FOnMessageClick) and (DaoCanClick in Options) then
    begin
      FEndInterval := StyleHandler.EndInterval;
      try
        StyleHandler.EndInterval := 0;
        FOnMessageClick(Self); // (p3) should this be Sender instead?
      finally
        StyleHandler.EndInterval := FEndInterval;
      end;
      if not DesktopForm.MouseInControl then
        StyleHandler.DoEndAnimation;
    end;
end;

procedure TJvDesktopAlert.InternalMouseEnter(Sender: TObject);
begin
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TJvDesktopAlert.InternalMouseLeave(Sender: TObject);
begin
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;

procedure TJvDesktopAlert.InternalOnClose(Sender: TObject; var Action: TCloseAction);
begin
  if (CsDestroying in ComponentState) then
    Exit;
  if Location.Position = DapCustom then
    begin
      Location.Top := DesktopForm.Top;
      Location.Left := DesktopForm.Left;
    end;
  if Assigned(FOnClose) then
    FOnClose(Self);
  GetStacker.Remove(DesktopForm);
  if AutoFree and (DesktopForm <> nil) and not(CsDesigning in ComponentState) then
    begin
      DesktopForm.OnClose := nil;
      // post a message to the form so we have time to finish off all event handlers and
      // timers before the form and component are freed
      PostMessage(DesktopForm.Handle, JVDESKTOPALERT_AUTOFREE, WPARAM(DesktopForm), LPARAM(Self));
      FDesktopForm := nil;
    end;
end;

procedure TJvDesktopAlert.InternalOnShow(Sender: TObject);
begin
  if Assigned(FOnShow) then
    FOnShow(Self);
end;

procedure TJvDesktopAlert.InternalOnShowing(Sender: TObject);
begin
  if Assigned(FOnShowing) then
    FOnShowing(Self);
end;

procedure TJvDesktopAlert.InternalOnShown(Sender: TObject);
begin
  if Assigned(FOnShown) then
    FOnShown(Self);
end;

procedure TJvDesktopAlert.SetButtons(const Value: TJvDesktopAlertButtons);
begin
  FButtons.Assign(Value);
end;

procedure TJvDesktopAlert.SetDropDownMenu(const Value: TPopupMenu);
begin
  DesktopForm.TbDropDown.DropDownMenu := Value;
end;

procedure TJvDesktopAlert.SetFont(const Value: TFont);
begin
  DesktopForm.LblText.Font := Value;
end;

procedure TJvDesktopAlert.SetHeaderFont(const Value: TFont);
begin
  DesktopForm.LblHeader.Font := Value;
end;

procedure TJvDesktopAlert.SetHeaderText(const Value: string);
begin
  DesktopForm.LblHeader.Caption := Value;
end;

procedure TJvDesktopAlert.SetHint(const Value: string);
begin
  DesktopForm.Hint := Value;
end;

procedure TJvDesktopAlert.SetImage(const Value: TPicture);
begin
  DesktopForm.ImIcon.Picture := Value;
end;

procedure TJvDesktopAlert.SetImages(const Value: TCustomImageList);
begin
  ReplaceComponentReference(Self, Value, TComponent(FImages));
end;

procedure TJvDesktopAlert.SetMessageText(const Value: string);
begin
  DesktopForm.LblText.Caption := Value;
  DesktopForm.LblText.Update;
end;

procedure TJvDesktopAlert.SetParentFont(const Value: Boolean);
begin
  DesktopForm.ParentFont := Value;
end;

procedure TJvDesktopAlert.SetPopupMenu(const Value: TPopupMenu);
begin
  DesktopForm.PopupMenu := Value;
end;

procedure TJvDesktopAlert.SetShowHint(const Value: Boolean);
begin
  DesktopForm.ShowHint := Value;
end;

function TJvDesktopAlert.GetCloseButtonClick: TNotifyEvent;
begin
  Result := DesktopForm.TbClose.OnClick;
end;

procedure TJvDesktopAlert.SetCloseButtonClick(const Value: TNotifyEvent);
begin
  DesktopForm.TbClose.OnClick := Value;
end;

// === { TJvDesktopAlertStack } ===============================================

constructor TJvDesktopAlertStack.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TList.Create;
  FPosition := DapBottomRight;
end;

destructor TJvDesktopAlertStack.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TJvDesktopAlertStack.Add(AForm: TCustomForm);
begin
  FItems.Add(AForm);
  UpdatePositions;
end;

function TJvDesktopAlertStack.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TJvDesktopAlertStack.GetItems(index: Integer): TJvCustomFormDesktopAlert;
begin
  Result := TJvCustomFormDesktopAlert(FItems[index]);
  Assert((Result = nil) or (Result is TJvCustomFormDesktopAlert));
end;

procedure TJvDesktopAlertStack.Remove(AForm: TCustomForm);
var
  index, PrevNilSlot: Integer;
  Form: TJvCustomFormDesktopAlert;
begin
  if (AForm <> nil) and (AForm is TJvCustomFormDesktopAlert) then
    begin
      // The basic trick here is to push piling forms down in the list, while keeping the
      // static ones (i.e. a form that has the mouse pointer over it) in place.
      index := FItems.IndexOf(AForm);
      if index >= 0 then
        begin
          FItems[index] := nil;

          Inc(index);
          while index < FItems.Count do
            begin
              Form := Items[index];
              if Assigned(Form) and (not Form.MouseInControl) then
                begin
                  PrevNilSlot := Pred(index);
                  while FItems[PrevNilSlot] <> nil do
                    Dec(PrevNilSlot);
                  FItems[PrevNilSlot] := FItems[index];
                  FItems[index] := nil;
                end;

              Inc(index);
            end;

          while (Pred(FItems.Count) >= 0) and (FItems[Pred(FItems.Count)] = nil) do
            FItems.Delete(Pred(FItems.Count));

          UpdatePositions;
        end;
    end;
end;

procedure TJvDesktopAlertStack.SetPosition(const Value: TJvDesktopAlertPosition);
begin
  if FPosition <> Value then
    begin
      // if Value = dapCustom then raise
      // Exception.Create('TJvDesktopAlertStack does not handle dapCustom alerts!');
      // FItems.Clear;
      FPosition := Value;
    end;
end;

procedure TJvDesktopAlertStack.UpdatePositions;
var
  C, I: Integer;
  Form: TJvCustomFormDesktopAlert;
  X, Y: Integer;
  R: TRect;
begin
  C := Count;
  if C > 0 then
    begin
      R := ScreenWorkArea;
      case Position of
        DapBottomRight: begin
            Y := R.Bottom;
            for I := 0 to Pred(C) do
              begin
                Form := Items[I];
                if Assigned(Form) and Form.Visible then
                  begin
                    X := R.Right - Form.Width;
                    Dec(Y, Form.Height);
                    Form.SetNewOrigin(X, Y);
                  end;
              end;
          end;
        DapBottomLeft: begin
            X := R.Left;
            Y := R.Bottom;
            for I := 0 to Pred(C) do
              begin
                Form := Items[I];
                if Assigned(Form) and Form.Visible then
                  begin
                    Dec(Y, Form.Height);
                    Form.SetNewOrigin(X, Y);
                  end;
              end;
          end;
        DapTopRight: begin
            Y := R.Top;
            for I := 0 to Pred(C) do
              begin
                Form := Items[I];
                if Assigned(Form) and Form.Visible then
                  begin
                    X := R.Right - Form.Width;
                    Form.SetNewOrigin(X, Y);
                    Inc(Y, Form.Height);
                  end;
              end;
          end;
        DapTopLeft: begin
            Y := R.Top;
            X := R.Left;
            for I := 0 to Pred(C) do
              begin
                Form := Items[I];
                if Assigned(Form) and Form.Visible then
                  begin
                    Form.SetNewOrigin(X, Y);
                    Inc(Y, Form.Height);
                  end;
              end;
          end;
      end;
    end;
end;

// === { TJvCustomDesktopAlertStyle } =========================================

constructor TJvCustomDesktopAlertStyleHandler.Create(OwnerForm: TJvCustomFormDesktopAlert);
begin
  inherited Create;
  FAnimTimer := TTimer.Create(nil);
  FAnimTimer.Enabled := False;
  FOwnerForm := OwnerForm;
end;

destructor TJvCustomDesktopAlertStyleHandler.Destroy;
begin
  FAnimTimer.OnTimer := nil;
  FreeAndNil(FAnimTimer);
  inherited Destroy;
end;

procedure TJvCustomDesktopAlertStyleHandler.AbortAnimation;
begin
  AnimTimer.Enabled := False;
  if Status = HsStartAnim then
    FinalizeStartAnimation
  else if Status = HsEndAnim then
    FinalizeEndAnimation;
end;

procedure TJvCustomDesktopAlertStyleHandler.DoEndAnimation;
begin
  if EndSteps > 0 then
    begin
      AnimTimer.Enabled := False;
      AnimTimer.OnTimer := EndAnimTimer;
      AnimTimer.Interval := EndInterval;
      FCurrentStep := 0;
      PrepareEndAnimation;
      FStatus := HsEndAnim;
      AnimTimer.Enabled := True;
    end;
end;

procedure TJvCustomDesktopAlertStyleHandler.DoDisplay;
begin
  if DisplayDuration > 0 then
    begin
      AnimTimer.Enabled := False;
      AnimTimer.OnTimer := DisplayTimer;
      AnimTimer.Interval := DisplayDuration;
      FCurrentStep := 0;
      FStatus := HsDisplay;
      AnimTimer.Enabled := True;
    end;
end;

procedure TJvCustomDesktopAlertStyleHandler.DoStartAnimation;
begin
  if StartSteps > 0 then
    begin
      AnimTimer.Enabled := False;
      AnimTimer.OnTimer := StartAnimTimer;
      AnimTimer.Interval := StartInterval;
      FCurrentStep := 0;
      PrepareStartAnimation;
      FStatus := HsStartAnim;
      AnimTimer.Enabled := True;
    end;
end;

procedure TJvCustomDesktopAlertStyleHandler.EndAnimTimer(Sender: TObject);
begin
  Inc(FCurrentStep);
  if CurrentStep >= EndSteps then
    begin
      AnimTimer.Enabled := False;
      FinalizeEndAnimation;
    end;
end;

procedure TJvCustomDesktopAlertStyleHandler.DisplayTimer(Sender: TObject);
begin
  AnimTimer.Enabled := False;
  FStatus := HsIdle;
end;

function TJvCustomDesktopAlertStyleHandler.GetActive: Boolean;
begin
  Result := AnimTimer.Enabled;
end;

procedure TJvCustomDesktopAlertStyleHandler.SetEndInterval(const Value: Cardinal);
begin
  FEndInterval := Value;
end;

procedure TJvCustomDesktopAlertStyleHandler.SetEndSteps(const Value: Cardinal);
begin
  FEndSteps := Value;
  if FEndSteps < 1 then
    FEndSteps := 1;
end;

procedure TJvCustomDesktopAlertStyleHandler.SetDisplayDuration(const Value: Cardinal);
begin
  FDisplayDuration := Value;
end;

procedure TJvCustomDesktopAlertStyleHandler.SetOwnerForm(const Value: TJvCustomFormDesktopAlert);
begin
  FOwnerForm := Value;
end;

procedure TJvCustomDesktopAlertStyleHandler.SetStartInterval(const Value: Cardinal);
begin
  FStartInterval := Value;
end;

procedure TJvCustomDesktopAlertStyleHandler.SetStartSteps(const Value: Cardinal);
begin
  FStartSteps := Value;
  if FStartSteps < 1 then
    FStartSteps := 1;
end;

procedure TJvCustomDesktopAlertStyleHandler.StartAnimTimer(Sender: TObject);
begin
  Inc(FCurrentStep);
  if CurrentStep >= StartSteps then
    begin
      AnimTimer.Enabled := False;
      FinalizeStartAnimation;
      DoDisplay;
    end;
end;

procedure TJvCustomDesktopAlertStyleHandler.FinalizeEndAnimation;
begin
  if OwnerForm <> nil then
    OwnerForm.Close;
end;

procedure TJvCustomDesktopAlertStyleHandler.PrepareStartAnimation;
begin
  if OwnerForm <> nil then
    ShowWindow(OwnerForm.Handle, SW_SHOWNA);
end;

// === { TJvFadeAlertStyleHandler } ===========================================

const
  WS_EX_LAYERED = $00080000;
  LWA_ALPHA = $00000002;

type
  TDynamicSetLayeredWindowAttributes = function(HWnd: THandle; CrKey: COLORREF; BAlpha: Byte; DwFlags: DWORD): Boolean; stdcall;

constructor TJvFadeAlertStyleHandler.Create(OwnerForm: TJvCustomFormDesktopAlert);
begin
  inherited Create(OwnerForm);

  // Set default values
  StartInterval := 25;
  StartSteps := 10;
  EndInterval := 50;
  EndSteps := 10;
  DisplayDuration := 1400;
  MinAlphaBlendValue := 0;
  MaxAlphaBlendValue := 255;
end;

procedure TJvFadeAlertStyleHandler.AbortAnimation;
begin
  if not(Status in [HsDisplay, HsStartAnim]) then
    begin
      AnimTimer.Enabled := False;
      DoAlphaBlend(MaxAlphaBlendValue);
    end;
end;

procedure TJvFadeAlertStyleHandler.DoAlphaBlend(Value: Byte);
var
  DynamicSetLayeredWindowAttributes: TDynamicSetLayeredWindowAttributes;
  CurrentStyle: Cardinal;

procedure InitProcs;
const
  SUser32 = 'User32.dll';
var
  ModH: HMODULE;
begin
  ModH := GetModuleHandle(SUser32);
  if ModH <> 0 then
    @DynamicSetLayeredWindowAttributes := GetProcAddress(ModH, 'SetLayeredWindowAttributes')
  else
    @DynamicSetLayeredWindowAttributes := nil;
end;

begin
  if OwnerForm <> nil then
    begin
      InitProcs;
      if OwnerForm.HandleAllocated and Assigned(DynamicSetLayeredWindowAttributes) then
        begin
          CurrentStyle := GetWindowLong(OwnerForm.Handle, GWL_EXSTYLE);
          if (CurrentStyle and WS_EX_LAYERED) = 0 then
            SetWindowLong(OwnerForm.Handle, GWL_EXSTYLE, GetWindowLong(OwnerForm.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
          DynamicSetLayeredWindowAttributes(OwnerForm.Handle, 0, Value, LWA_ALPHA);
        end;
    end;
end;

procedure TJvFadeAlertStyleHandler.EndAnimTimer(Sender: TObject);
begin
  inherited EndAnimTimer(Sender);
  DoAlphaBlend(MaxAlphaBlendValue - ((Cardinal(MaxAlphaBlendValue) - MinAlphaBlendValue) * CurrentStep) div EndSteps);
end;

procedure TJvFadeAlertStyleHandler.FinalizeEndAnimation;
begin
  DoAlphaBlend(MinAlphaBlendValue);
  inherited FinalizeEndAnimation; // Do not forget to call inherited, to hide the form
end;

procedure TJvFadeAlertStyleHandler.FinalizeStartAnimation;
begin
  DoAlphaBlend(MaxAlphaBlendValue);
end;

procedure TJvFadeAlertStyleHandler.PrepareEndAnimation;
begin
  DoAlphaBlend(MaxAlphaBlendValue);
end;

procedure TJvFadeAlertStyleHandler.PrepareStartAnimation;
begin
  DoAlphaBlend(MinAlphaBlendValue);
  inherited PrepareStartAnimation;
end;

procedure TJvFadeAlertStyleHandler.SetMaxAlphaBlendValue(const Value: Byte);
begin
  FMaxAlphaBlendValue := Value;
end;

procedure TJvFadeAlertStyleHandler.SetMinAlphaBlendValue(const Value: Byte);
begin
  FMinAlphaBlendValue := Value;
end;

procedure TJvFadeAlertStyleHandler.StartAnimTimer(Sender: TObject);
begin
  DoAlphaBlend(MinAlphaBlendValue + ((Cardinal(MaxAlphaBlendValue) - MinAlphaBlendValue) * CurrentStep) div StartSteps);
  inherited StartAnimTimer(Sender);
end;

// === { TJvCenterGrowAlertStyleHandler } =====================================

constructor TJvCenterGrowAlertStyleHandler.Create(OwnerForm: TJvCustomFormDesktopAlert);
begin
  inherited Create(OwnerForm);

  // Set default values
  StartInterval := 25;
  StartSteps := 10;
  EndInterval := 50;
  EndSteps := 10;
  DisplayDuration := 1400;

  MinGrowthPercentage := 0;
  MaxGrowthPercentage := 100;
end;

procedure TJvCenterGrowAlertStyleHandler.AbortAnimation;
begin
  if not(Status in [HsDisplay, HsStartAnim]) then
    begin
      AnimTimer.Enabled := False;
      DoGrowRegion(MaxGrowthPercentage);
    end;
end;

procedure TJvCenterGrowAlertStyleHandler.DoGrowRegion(Percentage: Double);
var
  RegionRect: TRect;
  Region: HRGN;
  RegionHeight: Integer;
  RegionWidth: Integer;
begin
  if OwnerForm <> nil then
    begin
      RegionHeight := Round(Percentage * OwnerForm.Height / 100.0);
      RegionWidth := Round(Percentage * OwnerForm.Width / 100.0);

      RegionRect.Left := (OwnerForm.Width - RegionWidth) div 2;
      RegionRect.Right := RegionRect.Left + RegionWidth;
      RegionRect.Top := (OwnerForm.Height - RegionHeight) div 2;
      RegionRect.Bottom := RegionRect.Top + RegionHeight;

      Region := CreateRectRgnIndirect(RegionRect);
      SetWindowRgn(OwnerForm.Handle, Region, True);
    end;
end;

procedure TJvCenterGrowAlertStyleHandler.StartAnimTimer(Sender: TObject);
begin
  DoGrowRegion(MinGrowthPercentage + ((MaxGrowthPercentage - MinGrowthPercentage) * CurrentStep) / StartSteps);
  inherited StartAnimTimer(Sender);
end;

procedure TJvCenterGrowAlertStyleHandler.EndAnimTimer(Sender: TObject);
begin
  inherited EndAnimTimer(Sender);
  DoGrowRegion(MaxGrowthPercentage - ((MaxGrowthPercentage - MinGrowthPercentage) * CurrentStep) / EndSteps);
end;

procedure TJvCenterGrowAlertStyleHandler.FinalizeEndAnimation;
begin
  DoGrowRegion(MinGrowthPercentage);
  inherited FinalizeEndAnimation;
end;

procedure TJvCenterGrowAlertStyleHandler.FinalizeStartAnimation;
begin
  DoGrowRegion(MaxGrowthPercentage);
end;

procedure TJvCenterGrowAlertStyleHandler.PrepareEndAnimation;
begin
  DoGrowRegion(MaxGrowthPercentage);
end;

procedure TJvCenterGrowAlertStyleHandler.PrepareStartAnimation;
begin
  DoGrowRegion(MinGrowthPercentage);
  inherited PrepareStartAnimation;
end;

procedure TJvCenterGrowAlertStyleHandler.SetMaxGrowthPercentage(const Value: Double);
begin
  FMaxGrowthPercentage := Value;
  if FMaxGrowthPercentage < 0.0 then
    FMaxGrowthPercentage := 0.0;
  if FMaxGrowthPercentage > 100.0 then
    FMaxGrowthPercentage := 100.0;
end;

procedure TJvCenterGrowAlertStyleHandler.SetMinGrowthPercentage(const Value: Double);
begin
  FMinGrowthPercentage := Value;
  if FMinGrowthPercentage < 0.0 then
    FMinGrowthPercentage := 0.0;
  if FMinGrowthPercentage > 100.0 then
    FMinGrowthPercentage := 100.0;
end;

function TJvDesktopAlert.GetBiDiMode: TBidiMode;
begin
  Result := FDesktopForm.BiDiMode;
end;

procedure TJvDesktopAlert.SetBiDiMode(const Value: TBidiMode);
begin
  FDesktopForm.BiDiMode := Value;
end;

{ TJvCustomDesktopAlert }

procedure TJvCustomDesktopAlert.Close(Immediate: Boolean);
begin
  if Showing then
    begin
      if Immediate then
        FDesktopForm.Close
      else
        FStyleHandler.DoEndAnimation;
    end;
end;

constructor TJvCustomDesktopAlert.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FColors := TJvDesktopAlertColors.Create;
  FLocation := TJvDesktopAlertLocation.Create;
  FLocation.OnChange := DoLocationChange;
  AlertStyle := AsFade;
  FOptions := [DaoCanClick .. DaoCanClose];
end;

destructor TJvCustomDesktopAlert.Destroy;
begin
  // when AutoFreeing, Delphi doesn't like the component having an owner, so remove the Owner here
  if FAutoFree and (Owner <> nil) and not(CsDesigning in ComponentState) then
    Owner.RemoveComponent(Self);
  if (FDesktopForm <> nil) then
    begin
      if FDesktopForm.Showing then
        FDesktopForm.Close;
      FDesktopForm.OnClose := nil;
      GetStacker.Remove(FDesktopForm);
      FDesktopForm.Release;
      FDesktopForm := nil;
    end;
  FreeAndNil(FColors);
  FreeAndNil(FLocation);
  FreeAndNil(FStyleHandler);
  inherited Destroy;
end;

procedure TJvCustomDesktopAlert.DoLocationChange(Sender: TObject);
begin
  if GetStacker.Position <> Location.Position then
    begin
      if GetStacker = GlobalStacker then
        GetStacker.Position := Location.Position
      else
        Location.Position := GetStacker.Position;
    end;
end;

function TJvCustomDesktopAlert.Execute: Boolean;
var
  ARect: TRect;
  Position: TJvDesktopAlertPosition;

procedure CenterForm(AForm: TCustomForm; ARect: TRect);
begin
  AForm.Top := ARect.Top + ((ARect.Bottom - ARect.Top) - AForm.Height) div 2;
  AForm.Left := ARect.Left + ((ARect.Right - ARect.Left) - AForm.Width) div 2;
end;

begin
  Assert(FDesktopForm <> nil);
  if FDesktopForm.Visible then
    FDesktopForm.Close;

  ARect := ScreenWorkArea;
  if (Application <> nil) and (Application.MainForm <> nil) and
    (Location.Position in [DapMainFormTopLeft, DapMainFormTopRight, DapMainFormBottomLeft, DapMainFormBottomRight]) then
    ARect := Application.MainForm.BoundsRect
  else if (Screen.ActiveForm <> nil) and (Location.Position in [DapActiveFormTopLeft, DapActiveFormTopRight, DapActiveFormBottomLeft,
    DapActiveFormBottomRight]) then
    ARect := Screen.ActiveForm.BoundsRect
  else if (Owner is TCustomForm) and (Location.Position in [DapOwnerFormTopLeft, DapOwnerFormTopRight, DapOwnerFormBottomLeft,
    DapOwnerFormBottomRight]) then
    ARect := TCustomForm(Owner).BoundsRect;

  Position := Location.Position;
  case Position of
    DapMainFormTopLeft, DapActiveFormTopLeft, DapOwnerFormTopLeft: Position := DapTopLeft;
    DapMainFormTopRight, DapActiveFormTopRight, DapOwnerFormTopRight: Position := DapTopRight;
    DapMainFormBottomLeft, DapActiveFormBottomLeft, DapOwnerFormBottomLeft: Position := DapBottomLeft;
    DapMainFormBottomRight, DapActiveFormBottomRight, DapOwnerFormBottomRight: Position := DapBottomRight;
  end;

  if Location.Width <> 0 then
    FDesktopForm.Width := Location.Width
  else
    FDesktopForm.Width := CDefaultAlertFormWidth;
  if Location.Height <> 0 then
    FDesktopForm.Height := Location.Height
  else
    FDesktopForm.Height := CDefaultAlertFormHeight;
  case Position of
    DapTopLeft: begin
        FDesktopForm.Top := ARect.Top;
        FDesktopForm.Left := ARect.Left;
      end;
    DapTopRight: begin
        FDesktopForm.Top := ARect.Top;
        FDesktopForm.Left := ARect.Right - FDesktopForm.Width;
      end;
    DapBottomLeft: begin
        FDesktopForm.Top := ARect.Bottom - FDesktopForm.Height;
        FDesktopForm.Left := ARect.Left;
      end;
    DapBottomRight: begin
        FDesktopForm.Top := ARect.Bottom - FDesktopForm.Height;
        FDesktopForm.Left := ARect.Right - FDesktopForm.Width;
      end;
    DapCustom: begin
        FDesktopForm.Top := Location.Top;
        FDesktopForm.Left := Location.Left;
      end;
    DapDesktopCenter, DapMainFormCenter, DapOwnerFormCenter, DapActiveFormCenter: begin
        CenterForm(FDesktopForm, ARect);
        if (Location.Position = DapActiveFormCenter) and (Screen.ActiveForm <> nil) then
          CenterForm(FDesktopForm, Screen.ActiveForm.BoundsRect)
        else if (Location.Position = DapMainFormCenter) and (Application <> nil) and (Application.MainForm <> nil) then
          CenterForm(FDesktopForm, Application.MainForm.BoundsRect)
        else if (Location.Position = DapOwnerFormCenter) and (Owner is TCustomForm) then
          CenterForm(FDesktopForm, TCustomForm(Owner).BoundsRect);
      end;
  end;

  FDesktopForm.Moveable := (DaoCanMove in Options);
  FDesktopForm.MoveAnywhere := (DaoCanMoveAnywhere in Options);
  FDesktopForm.WindowColorFrom := Colors.WindowFrom;
  FDesktopForm.WindowColorTo := Colors.WindowTo;
  FDesktopForm.CaptionColorFrom := Colors.CaptionFrom;
  FDesktopForm.CaptionColorTo := Colors.CaptionTo;
  FDesktopForm.FrameColor := Colors.Frame;

  Result := True;
end;

function TJvCustomDesktopAlert.GetAlertStack: TJvDesktopAlertStack;
begin
  if FStacker = GlobalStacker then
    Result := nil
  else
    Result := FStacker;
end;

function TJvCustomDesktopAlert.GetStacker: TJvDesktopAlertStack;
begin
  if FStacker = nil then
    Result := GlobalStacker
  else
    Result := FStacker;
end;

procedure TJvCustomDesktopAlert.InternalOnMove(Sender: TObject);
begin
  if not(CsDesigning in ComponentState) and not Location.AlwaysResetPosition and (Location.Position <> DapCustom) then
    begin
      GetStacker.Remove(FDesktopForm);
      Location.Position := DapCustom;
    end;
end;

procedure TJvCustomDesktopAlert.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = OpRemove then
    begin
      if AComponent = FStacker then
        AlertStack := nil;
    end;
end;

procedure TJvCustomDesktopAlert.SetAlertStack(const Value: TJvDesktopAlertStack);
begin
  if ReplaceComponentReference(Self, Value, TComponent(FStacker)) then
    if FStacker <> nil then
      Location.Position := FStacker.Position;
end;

procedure TJvCustomDesktopAlert.SetAlertStyle(const Value: TJvAlertStyle);
begin
  FAlertStyle := Value;
  FStyleHandler.Free;
  FStyleHandler := CreateHandlerForStyle(AlertStyle, TJvCustomFormDesktopAlert(FDesktopForm));
end;

procedure TJvCustomDesktopAlert.SetColors(const Value: TJvDesktopAlertColors);
begin
  FColors.Assign(Value);
end;

procedure TJvCustomDesktopAlert.SetLocation(const Value: TJvDesktopAlertLocation);
begin
  //
end;

procedure TJvCustomDesktopAlert.SetOptions(const Value: TJvDesktopAlertOptions);
begin
  if FOptions <> Value then
    begin
      FOptions := Value;
      if not(DaoCanMove in FOptions) then
        Exclude(FOptions, DaoCanMoveAnywhere);
    end;
end;

procedure TJvCustomDesktopAlert.SetStyleHandler(const Value: TJvCustomDesktopAlertStyleHandler);
begin
  FStyleHandler.Assign(Value);
end;

function TJvCustomDesktopAlert.Showing: Boolean;
begin
  Result := (FDesktopForm <> nil) and FDesktopForm.Showing;
end;

{ TJvDesktopAlertForm }

function TJvDesktopAlertForm.Execute: Boolean;
var
  FActiveWindow, FActiveFocus: HWND;
begin
  inherited Execute;
  FDesktopForm.Closeable := (DaoCanClose in Options);
  FDesktopForm.OnUserMove := InternalOnMove;

  Location.Position := GetStacker.Position;
  if not AutoFocus then
    begin
      FActiveFocus := GetFocus;
      FActiveWindow := GetActiveWindow;
    end
  else
    begin
      FActiveWindow := NullHandle;
      FActiveFocus := NullHandle;
    end;
  FDesktopForm.AllowFocus := AutoFocus;
  FDesktopForm.ShowNoActivate;
  Result := True;
  if not AutoFocus and (FActiveFocus <> GetFocus) then
    begin
      if (FActiveFocus <> NullHandle) then
        SetFocus(FActiveFocus)
      else if (FActiveWindow <> NullHandle) then
        SetActiveWindow(FActiveWindow);
    end;
  GetStacker.Add(FDesktopForm);
end;

procedure TJvDesktopAlertForm.SetForm(const Value: TJvCustomFormDesktopAlert);
begin
  FDesktopForm := Value;
  if Value <> nil then
    begin
      Location.Width := FDesktopForm.Width;
      Location.Height := FDesktopForm.Height;
    end;
  // reforce alert style so proper form will be assigned to alert displayer
  AlertStyle := AlertStyle;
end;

initialization

{$IFDEF UNITVERSIONING}

RegisterUnitVersion(HInstance, UnitVersioning);

{$ENDIF UNITVERSIONING}

finalization

FreeAndNil(GStacker);

{$IFDEF UNITVERSIONING}

UnregisterUnitVersion(HInstance);

{$ENDIF UNITVERSIONING}

end.
