{*******************************************************}
{                                                       }
{       CodeGear Delphi Visual Component Library        }
{                                                       }
{           Copyright (c) 1995-2008 CodeGear            }
{                                                       }
{*******************************************************}

unit CategoryButtons;

interface

{$WARN UNIT_PLATFORM OFF}

uses
{$IF DEFINED(CLR)}
  WinUtils,
{$IFEND}
  Windows, Messages, SysUtils, Classes, ImgList, Forms, Controls,
  Graphics, StdCtrls, GraphUtil, ActnList;

const
  crDragCopy = TCursor(-23); { New cursor, with a plus for copying }

type
  TBaseItem = class;
  TBaseButtonItem = class;
  TBaseButtonItemClass = class of TBaseButtonItem;
  TButtonItem = class;
  TButtonItemClass = class of TButtonItem;
  TButtonCategory = class;
  TButtonCategoryClass = class of TButtonCategory;
  TButtonCategories = class;
  TButtonCategoriesClass = class of TButtonCategories;
  TButtonItemActionLink = class;
  TButtonItemActionLinkClass = class of TButtonItemActionLink;

  { TButtonDrawState }
  {
    bdsSelected:    Item is selected and in the "down" state
    bdsHot:         Item has the mouse over it
    bdsFocused:     Item should show focus
    bdsDown:        Item is being pressed by the user
    bdsDragged:     The drag image for that button is being drawn
    bdsInsertLeft:  Show that an item can be inserted to the left of this item
    bdsInsertTop:   Show that an item can be inserted above this item
    bdsInsertRight: Show that an item can be inserted to the right of this item
    bdsInsertBottom: Show that an item can be inserted below this item
  }
  TButtonDrawState = set of (bdsSelected, bdsHot, bdsFocused, bdsDown, 
    bdsDragged, bdsInsertLeft, bdsInsertTop, bdsInsertRight, bdsInsertBottom);

  TCatButtonOptions = set of (boAllowReorder, boAllowCopyingButtons,
    boFullSize, boGradientFill, boShowCaptions, boVerticalCategoryCaptions,
    boBoldCaptions, boUsePlusMinus, boCaptionOnlyBorder);

  TCatButtonEvent = procedure(Sender: TObject; const Button: TButtonItem) of object;
  TCatButtonGetHint = procedure(Sender: TObject; const Button: TButtonItem;
    const Category: TButtonCategory; var HintStr: string; var Handled: Boolean) of object;

  TCatButtonDrawEvent = procedure(Sender: TObject;
    const Button: TButtonItem; Canvas: TCanvas; Rect: TRect;
    State: TButtonDrawState) of object;
  TCatButtonDrawIconEvent = procedure(Sender: TObject;
    const Button: TButtonItem; Canvas: TCanvas; Rect: TRect;
    State: TButtonDrawState; var TextOffset: Integer) of object;
  TCatButtonReorderEvent = procedure(Sender: TObject; const Button: TButtonItem;
    const SourceCategory, TargetCategory: TButtonCategory) of object;
  TCatButtonCopyEvent = procedure(Sender: TObject;
    const SourceButton, CopiedButton: TButtonItem) of object;
  TCategoryReorderEvent = procedure(Sender: TObject; const SourceCategory,
    TargetCategory: TButtonCategory) of object;
  TCategoryCollapseEvent = procedure(Sender: TObject;
    const Category: TButtonCategory) of object;

  TCatButtonFlow = (cbfVertical, cbfHorizontal);

  { Note: TCategoryButtons requires (Win98 | Win NT 4.0) or above }
  TCategoryButtons = class(TCustomControl)
{$IF DEFINED(CLR)}
  strict private
    class var
      FCursorHandle: TSafeCursorHandle;
    class constructor Create;
{$IFEND}
  private
    FButtonFlow: TCatButtonFlow;
    FCollapsedHeight: Integer;
    FDownButton: TButtonItem;
    FDragButton: TButtonItem;
    FDragCategory: TButtonCategory;
    FDragStartPos: TPoint;
    FDragStarted: Boolean;
    FDragImageList: TDragImageList;
    FGradientDirection: TGradientDirection;
    FBackGradientDirection: TGradientDirection;
    FGutterSize: Integer;
    FScrollSize: Integer;
    FSideBufferSize: Integer;
    FHotButton: TButtonItem;
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FInsertLeft, FInsertTop, FInsertRight, FInsertBottom: TBaseItem;
    FIgnoreUpdate: Boolean;
    FScrollBarMax: Integer;
    FScrollBarPos: Integer;
    FPageAmount: Integer;
    FButtonCategories: TButtonCategories;
    FButtonOptions: TCatButtonOptions;
    FButtonWidth, FButtonHeight: Integer;
    FBorderStyle: TBorderStyle;
    FSelectedItem: TBaseItem;
    FFocusedItem: TBaseItem;
    FMouseInControl: Boolean;
    FBackgroundGradientColor: TColor;
    FOnButtonClicked: TCatButtonEvent;
    FOnCopyButton: TCatButtonCopyEvent;
    FOnSelectedItemChange: TCatButtonEvent;
    FOnHotButton: TCatButtonEvent;
    FOnGetHint: TCatButtonGetHint;
    FOnDrawIcon: TCatButtonDrawIconEvent;
    FOnDrawText: TCatButtonDrawEvent;
    FOnDrawButton: TCatButtonDrawEvent;
    FOnBeforeDrawButton: TCatButtonDrawEvent;
    FOnAfterDrawButton: TCatButtonDrawEvent;
    FOnReorderButton: TCatButtonReorderEvent;
    FOnReorderCategory: TCategoryReorderEvent;
    FOnCategoryCollapase: TCategoryCollapseEvent;
    FScrollBarShown: Boolean;
    FHotButtonColor, FSelectedButtonColor, FRegularButtonColor: TColor;
    procedure AdjustCategoryBounds(const Category: TButtonCategory;
      var CategoryBounds: TRect);
    procedure AutoScroll(ScrollCode: TScrollCode);
    procedure ImageListChange(Sender: TObject);
    function CalcButtonsPerRow: Integer;
    function CalcButtonsPerCol: Integer;
    procedure CalcBufferSizes;
    function CalcCategoryHeight(const Category: TButtonCategory;
      const ButtonsPerRow: Integer): Integer;
    function CalcCategoryWidth(const Category: TButtonCategory;
      const ButtonsPerCol: Integer): Integer;
    procedure DrawCategory(const Category: TButtonCategory;
      const Canvas: TCanvas; StartingPos: Integer);
    procedure GetCategoryBounds(const Category: TButtonCategory;
      const StartingPos: Integer; var CategoryBounds,
      ButtonBounds: TRect);
    function GetChevronBounds(const CategoryBounds: TRect): TRect;
    function GetIndexOfFirstCategory: Integer;
    function GetNextButtonInGroup(const StartingButton: TBaseItem;
      GoForward: Boolean): TBaseItem;
    function GetNextButton(const StartingButton: TBaseItem;
      GoForward: Boolean): TBaseItem;
    function GetScrollOffset: Integer;
    function GetScrollBuffer: Integer;
    procedure ScrollPosChanged(ScrollCode: TScrollCode;
      ScrollPos: Integer);
    procedure SetOnDrawButton(const Value: TCatButtonDrawEvent);
    procedure SetOnDrawIcon(const Value: TCatButtonDrawIconEvent);
    procedure SetBorderStyle(const Value: TBorderStyle);
    procedure SetButtonCategories(const Value: TButtonCategories);
    procedure SetButtonHeight(const Value: Integer);
    procedure SetCatButtonOptions(const Value: TCatButtonOptions);
    procedure SetButtonWidth(const Value: Integer);
    procedure SetFocusedItem(const Value: TBaseItem);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetSelectedItem(const Value: TBaseItem);
    procedure ShowScrollBar(const Visible: Boolean);
    procedure SetHotButtonColor(const Value: TColor);
    procedure SetRegularButtonColor(const Value: TColor);
    procedure SetSelectedButtonColor(const Value: TColor);
    procedure SetButtonFlow(const Value: TCatButtonFlow);
    function ShouldScrollDown(out Delay: DWORD): Boolean;
    function ShouldScrollUp(out Delay: DWORD): Boolean;
    procedure SetGradientDirection(const Value: TGradientDirection);
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CNKeydown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure WMMouseLeave(var Message: TMessage); message WM_MOUSELEAVE;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMHScroll(var Message: TWMVScroll); message WM_HSCROLL;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure SetDragButton(const Value: TButtonItem);
    procedure SetBackgroundGradientColor(const Value: TColor);
    procedure SetBackGradientDirection(const Value: TGradientDirection);
  protected
    procedure BeginAutoDrag; override;
    procedure CreateHandle; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoBeginDrag(Immediate: Boolean; Threshold: Integer); virtual;
    procedure DoCopyButton(const Button: TButtonItem;
      const TargetCategory: TButtonCategory; const TargetButton: TButtonItem); dynamic;
    procedure DoEndDrag(Target: TObject; X: Integer; Y: Integer); override;
    procedure DoHotButton; dynamic;
    procedure DoReorderButton(const Button: TButtonItem;
      const TargetCategory: TButtonCategory; const TargetButton: TButtonItem); dynamic;
    procedure DoReorderCategory(const SourceCategory,
      TargetCategory: TButtonCategory); dynamic;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DragOver(Source: TObject; X: Integer; Y: Integer;
      State: TDragState; var Accept: Boolean); override;
    procedure DrawButton(const Button: TButtonItem; Canvas: TCanvas;
      Rect: TRect; State: TButtonDrawState); virtual;
    procedure DoItemClicked(const Button: TBaseItem); dynamic;
    procedure DoSelectedItemChanged(const Button: TBaseItem); dynamic;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function GetAllowReorder: Boolean; dynamic;
    function GetCurrentCategory: TButtonCategory; virtual;
    function GetButtonCategoriesClass: TButtonCategoriesClass; virtual;
    function GetButtonCategoryClass: TButtonCategoryClass; virtual;
    function GetButtonItemClass: TButtonItemClass; virtual;
    function GetScrollPos: Integer;
    procedure SetScrollPos(const Value: Integer);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure ScrollRectIntoView(const Rect: TRect; PlaceOnTop: Boolean = False);
    procedure CMFontchanged(var Message: TMessage); message CM_FONTCHANGED;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property CurrentCategory: TButtonCategory read GetCurrentCategory;
    { DragButton: If a drag operation is coming from this control, it is
      becuase they are dragging this item, or the category. One can
      write to it if they want to control what button is being dragged. }
    property DragButton: TButtonItem read FDragButton write SetDragButton;
    property DragCategory: TButtonCategory read FDragCategory write FDragCategory;
    property DragImageList: TDragImageList read FDragImageList;
    procedure DragDrop(Source: TObject; X: Integer; Y: Integer); override;
    procedure GenerateDragImage;
    function GetButtonRect(const Button: TBaseItem): TRect;
    function GetCategoryRect(const Category: TButtonCategory;
      ButtonOnly: Boolean = False): TRect;
    function GetDragImages: TDragImageList; override;
    function GetButtonAt(X, Y: Integer;
      Category: TButtonCategory = nil): TButtonItem;
    function GetCategoryAt(X, Y: Integer): TButtonCategory;
    procedure ShareUpdateCategory(const Category: TButtonCategory);
    procedure RemoveInsertionPoints;
    procedure ScrollIntoView(const BaseItem: TBaseItem);
    { SetInsertionButton: Call this to set the current insertion "marks".
      Call RemoveInsertionPoints to remove the "marks". }
    procedure SetInsertionButton(InsertionButton: TButtonItem;
      InsertionCategory: TButtonCategory);
    { GetTargetAt: Gives you the target insertion point in the given group.
      TargetButton may be nil, while the TargetCategory is not (or, both may be nil)}
    procedure GetTargetAt(X, Y: Integer; var TargetButton: TButtonItem;
      var TargetCategory: TButtonCategory);
    procedure UpdateButton(const Button: TBaseItem);
    procedure UpdateAllButtons;
    property SelectedItem: TBaseItem read FSelectedItem write SetSelectedItem;
    property FocusedItem: TBaseItem read FFocusedItem write SetFocusedItem;
  published
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BorderWidth;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property ButtonFlow: TCatButtonFlow read FButtonFlow write SetButtonFlow;
    property ButtonHeight: Integer read FButtonHeight write SetButtonHeight default 24;
    property ButtonWidth: Integer read FButtonWidth write SetButtonWidth default 24;
    property ButtonOptions: TCatButtonOptions read FButtonOptions
      write SetCatButtonOptions default [boGradientFill, boShowCaptions, boVerticalCategoryCaptions];
    property DockSite;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Height default 100;
    property Images: TCustomImageList read FImages write SetImages;
    property BackgroundGradientColor: TColor read FBackgroundGradientColor write SetBackgroundGradientColor default clNone;
    property BackgroundGradientDirection: TGradientDirection read FBackGradientDirection write SetBackGradientDirection default gdHorizontal;
    property Categories: TButtonCategories read FButtonCategories write SetButtonCategories;
    property Color default clWindow;
    property Cursor;
    property GradientDirection: TGradientDirection read FGradientDirection write SetGradientDirection default gdHorizontal;
    property HotButtonColor: TColor read FHotButtonColor write SetHotButtonColor default $00EFD3C6;
    property ParentDoubleBuffered;
    property PopupMenu;
    property RegularButtonColor: TColor read FRegularButtonColor write SetRegularButtonColor nodefault;
    property SelectedButtonColor: TColor read FSelectedButtonColor write SetSelectedButtonColor nodefault;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Width default 100;
    property Visible;
    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnAfterDrawButton: TCatButtonDrawEvent read FOnAfterDrawButton write FOnAfterDrawButton;
    property OnBeforeDrawButton: TCatButtonDrawEvent read FOnBeforeDrawButton write FOnBeforeDrawButton;
    property OnButtonClicked: TCatButtonEvent read FOnButtonClicked write FOnButtonClicked;
    property OnCategoryCollapase: TCategoryCollapseEvent read FOnCategoryCollapase write FOnCategoryCollapase;
    property OnClick;
    property OnContextPopup;
    property OnCopyButton: TCatButtonCopyEvent read FOnCopyButton write FOnCopyButton;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawButton: TCatButtonDrawEvent read FOnDrawButton write SetOnDrawButton;
    property OnDrawIcon: TCatButtonDrawIconEvent read FOnDrawIcon write SetOnDrawIcon;
    property OnDrawText: TCatButtonDrawEvent read FOnDrawText write FOnDrawText;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetHint: TCatButtonGetHint read FOnGetHint write FOnGetHint;
    property OnHotButton: TCatButtonEvent read FOnHotButton write FOnHotButton;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnReorderButton: TCatButtonReorderEvent read FOnReorderButton write FOnReorderButton;
    property OnReorderCategory: TCategoryReorderEvent read FOnReorderCategory write FOnReorderCategory;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnSelectedItemChange: TCatButtonEvent read FOnSelectedItemChange write FOnSelectedItemChange;
    property OnStartDock;
    property OnStartDrag;
  end;

  TBaseItem = class(TCollectionItem)
  private
    FCaption: string;
    FInterfaceData: IInterface;
    procedure SetCaption(const Value: string);
    function IsCaptionStored: Boolean; virtual;
    function GetBounds: TRect; virtual; abstract;
  protected
    function GetFirstSibling: TBaseItem;
    function GetLastSibling: TBaseItem;
    function GetNextSibling(Distance: Integer = 1): TBaseItem;
    function GetPrevSibling(Distance: Integer = 1): TBaseItem;
  public
    procedure ScrollIntoView; virtual; abstract;
    property Bounds: TRect read GetBounds;
    property InterfaceData: IInterface read FInterfaceData write FInterfaceData;
    property Caption: string read FCaption write SetCaption stored IsCaptionStored;
  end;

  TBaseButtonItem = class(TBaseItem)
  private
    FActionLink: TButtonItemActionLink;
    FImageIndex: TImageIndex;
    FData: TCustomData;
    FHint: string;
    FOnClick: TNotifyEvent;
    //--Добавляем новые свойства для кнопок
    FUIN: string;
    FGroupId: string;
    FStatus: integer;
    FXImageIndex: TImageIndex;
    FCImageIndex: TImageIndex;
    FContactType: string;
    //
    procedure SetAction(const Value: TBasicAction);
    procedure SetImageIndex(const Value: TImageIndex);
    procedure SetXImageIndex(const Value: TImageIndex);
    procedure SetCImageIndex(const Value: TImageIndex);
    function GetAction: TBasicAction;
    procedure DoActionChange(Sender: TObject);
    function IsCaptionStored: Boolean; override;
    function IsHintStored: Boolean;
    function IsImageIndexStored: Boolean;
    function IsOnClickStored: Boolean;
    function GetBounds: TRect; override;
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); virtual;
    function GetNotifyTarget: TComponent; virtual; abstract;
    function GetDisplayName: string; override;
    function GetActionLinkClass: TButtonItemActionLinkClass; virtual;
    property ActionLink: TButtonItemActionLink read FActionLink write FActionLink;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Data: TCustomData read FData write FData;
  published
    property Action: TBasicAction read GetAction write SetAction;
    property Caption;
    property Hint: string read FHint write FHint stored IsHintStored;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex stored IsImageIndexStored;
    property OnClick: TNotifyEvent read FOnClick write FOnClick stored IsOnClickStored;
    //--Добавляем новые свойства для кнопок
    property UIN: string read FUIN write FUIN;
    property GroupId: string read FGroupId write FGroupId;
    property Status: Integer read FStatus write FStatus default 0;
    property XImageIndex: TImageIndex read FXImageIndex write SetXImageIndex stored IsImageIndexStored;
    property CImageIndex: TImageIndex read FCImageIndex write SetCImageIndex stored IsImageIndexStored;
    property ContactType: string read FContactType write FContactType;
  end;

  TButtonItem = class(TBaseButtonItem)
  private
    function GetButtonGroup: TCategoryButtons;
    function GetCategory: TButtonCategory;
    function GetBounds: TRect; override;
  protected
    function GetNotifyTarget: TComponent; override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure ScrollIntoView; override;
    property Category: TButtonCategory read GetCategory;
  published
    property ButtonGroup: TCategoryButtons read GetButtonGroup;
  end;

  TItemCollection = class(TCollection)
  protected
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
  end;

  TButtonCollection = class(TItemCollection)
  private
    FCategory: TButtonCategory;
    function GetItem(Index: Integer): TButtonItem;
    procedure SetItem(Index: Integer; const Value: TButtonItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
  public
    constructor Create(const ACategory: TButtonCategory);
    function Add: TButtonItem;
    function AddItem(Item: TButtonItem; Index: Integer): TButtonItem;
    function Insert(Index: Integer): TButtonItem;
    property Items[Index: Integer]: TButtonItem read GetItem write SetItem; default;
    property Category: TButtonCategory read FCategory;
  end;

  TButtonCategory = class(TBaseItem)
  private
    FCollapsed: Boolean;
    FColor: TColor;
    FGradientColor: TColor;
    FTextColor: TColor;
    FItems: TButtonCollection;
    { Information for caching drawing state }
    FStart: Integer;
    FEnd: Integer;
    FData: TCustomData;
    //--Добавляем новые свойства для групп
    FGroupId: string;
    FGroupSelected: boolean;
    FGroupCaption: string;
    FGroupType: string;
    //
    function GetCategories: TButtonCategories;
    procedure SetItems(const Value: TButtonCollection);
    procedure SetCollapsed(const Value: Boolean);
    procedure SetColor(const Value: TColor);
    procedure SetGradientColor(const Value: TColor);
    procedure SetTextColor(const Value: TColor);
    function GetBounds: TRect; override;
  protected
    procedure SetIndex(Value: Integer); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure ScrollIntoView; override;
    function IndexOf(const Caption: string): Integer;
    function GetButtonRect(ButtonOnly: Boolean): TRect;
    property Categories: TButtonCategories read GetCategories;
    property Data: TCustomData read FData write FData;
    procedure Assign(Source: TPersistent); override;
    property Bounds: TRect read GetBounds;
  published
    property Caption;
    property Color: TColor read FColor write SetColor;
    property Collapsed: Boolean read FCollapsed write SetCollapsed;
    property GradientColor: TColor read FGradientColor write SetGradientColor default clNone;
    property Items: TButtonCollection read FItems write SetItems;
    property TextColor: TColor read FTextColor write SetTextColor default clWindowText;
    //--Добавляем новые свойства для групп
    property GroupId: string read FGroupId write FGroupId;
    property GroupSelected: Boolean read FGroupSelected write FGroupSelected default false;
    property GroupCaption: string read FGroupCaption write FGroupCaption;
    property GroupType: string read FGroupType write FGroupType;
  end;

  TButtonCategories = class(TItemCollection)
  private
    FButtonGroup: TCategoryButtons;
    FOriginalID: Integer;
    function GetItem(Index: Integer): TButtonCategory;
    procedure SetItem(Index: Integer; const Value: TButtonCategory);
    function GetUpdateCount: Integer;
    function GetVisibleCount: Integer;
  protected
    function GetOwner: TPersistent; override;
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
    procedure Update(Item: TCollectionItem); override;
    property UpdateCount: Integer read GetUpdateCount;
public
    constructor Create(const ButtonGroup: TCategoryButtons); virtual;
    function Add: TButtonCategory;
    function AddItem(Item: TButtonCategory; Index: Integer): TButtonCategory;
    procedure BeginUpdate; override;
    function ItemAt(const Index: Integer): TBaseItem;
    function ItemIndex(const Caption: string): Integer;
    function Insert(Index: Integer): TButtonCategory;
    function IndexOf(const Caption: string): Integer;
    property Items[Index: Integer]: TButtonCategory read GetItem write SetItem; default;
    property ButtonGroup: TCategoryButtons read FButtonGroup;
    property VisibleCount: Integer read GetVisibleCount;
  end;

{ TButtonItemActionLink }

  TButtonItemActionLink = class(TActionLink)
  protected
    FClient: TBaseButtonItem;
    procedure AssignClient(AClient: TObject); override;
    function IsCaptionLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;
    function IsOnExecuteLinked: Boolean; override;
    procedure SetCaption(const Value: string); override;
    procedure SetHint(const Value: string); override;
    procedure SetImageIndex(Value: Integer); override;
    procedure SetOnExecute(Value: TNotifyEvent); override;
  public
    function DoShowHint(var HintStr: string): Boolean; virtual;
  end;

implementation

uses 
{$IF DEFINED(CLR)}
  System.Runtime.InteropServices, System.Security.Permissions, System.Threading,
{$IFEND}
  Themes, ExtCtrls, Types;

{$IF DEFINED(CLR)}
{$R Borland.Vcl.CategoryButtons.res} { Contains the Copy DragCursor }
{$ELSE}
{$R CategoryButtons.res}             { Contains the Copy DragCursor }
{$IFEND}

{ TCategoryButtons }

{$IF DEFINED(CLR)}
class constructor TCategoryButtons.Create;
var
  LHandle: HCURSOR;
begin
  //  Add our drag/copy cursor image
  LHandle := LoadCursor(HInstance, 'CAT_DRAG_COPY'); // Do not localize
  FCursorHandle := TSafeCursorHandle.Create(LHandle);
  Screen.Cursors[crDragCopy] := LHandle;
end;
{$IFEND}

constructor TCategoryButtons.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 100;
  Height := 100;
  ControlStyle := [csDoubleClicks, csCaptureMouse, csDisplayDragImage, csClickEvents, csPannable];
  FButtonCategories := GetButtonCategoriesClass.Create(Self); 
  FBorderStyle := bsSingle;
  FButtonWidth := 24;
  FButtonHeight := 24;
  FGradientDirection := gdHorizontal;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FDoubleBuffered := True;
  FDragImageList := TDragImageList.Create(nil);
  FButtonOptions := [boGradientFill, boShowCaptions, boVerticalCategoryCaptions];

  FHotButtonColor := $00EFD3C6;
  FSelectedButtonColor := GetShadowColor(clBtnFace, -10);
  FRegularButtonColor := GetHighlightColor(clBtnFace, 15);
  FBackgroundGradientColor := clNone;

  TabStop := True;
  Color := clWindow;
end;


procedure TCategoryButtons.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (FBorderStyle = bsSingle) then
  begin
    Params.Style := Params.Style and not WS_BORDER;
    Params.ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
  end;
end;

destructor TCategoryButtons.Destroy;
begin
  FDragImageList.Free;
  FButtonCategories.Free;
  FImageChangeLink.Free;
  FSelectedItem := nil;
  FFocusedItem := nil;
  inherited;
end;

function TCategoryButtons.GetScrollOffset: Integer;
begin
  Result := FScrollBarPos * FScrollSize;
end;

function TCategoryButtons.GetButtonRect(const Button: TBaseItem): TRect;
var
  ButtonsPerRow: Integer;
  Row, Col: Integer;
  StartingPos: Integer;
  CategoryBounds, ButtonBounds: TRect;
begin
  if Button is TButtonItem then
  begin
  { Translate the current virtual position to the actual position }
    StartingPos := (Button as TButtonItem).Category.FStart - GetScrollOffset;
    ButtonBounds := Rect(0,0,0,0);
    GetCategoryBounds((Button as TButtonItem).Category, StartingPos, CategoryBounds, ButtonBounds);
    if not IsRectEmpty(ButtonBounds) then
    begin
      if FButtonFlow = cbfVertical then
        ButtonsPerRow := CalcButtonsPerRow
      else
        ButtonsPerRow := (ButtonBounds.Right - ButtonBounds.Left) div FButtonWidth;
      Row := Button.Index div ButtonsPerRow;
      Result.Top := ButtonBounds.Top + Row*FButtonHeight;
      if (FButtonFlow = cbfVertical) and (boFullSize in FButtonOptions) then
      begin
        Result.Left := ButtonBounds.Left;
        Result.Right := ButtonBounds.Right;
      end
      else
      begin
        Col := Button.Index mod ButtonsPerRow;
        Result.Left := ButtonBounds.Left + Col*FButtonWidth;
        Result.Right := Result.Left + FButtonWidth;
      end;
      Result.Bottom := Result.Top + FButtonHeight;
    end;
  end
  else
    Result := Button.Bounds;
end;

procedure TCategoryButtons.ImageListChange(Sender: TObject);
begin
  UpdateAllButtons;
end;

procedure TCategoryButtons.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  I, J: Integer;
begin
  inherited;
  if (Operation = opRemove) then
  begin
    if AComponent = Images then
      Images := nil
    else
      if AComponent is TBasicAction then
        for I := 0 to FButtonCategories.Count - 1 do
          for J := 0 to FButtonCategories[I].Items.Count - 1 do
            if AComponent = FButtonCategories[I].Items[J].Action then
              FButtonCategories[I].Items[J].Action := nil;
  end;
end;

const
  cBorderBuffer = 5;

function TCategoryButtons.CalcCategoryHeight(const Category: TButtonCategory;
  const ButtonsPerRow: Integer): Integer;
var
  RowCount: Integer;
begin
  if Category.Collapsed or (Category.Items = nil) or (Category.Items.Count = 0) then
    Result := FCollapsedHeight + cBorderBuffer
  else
  begin
    RowCount := Category.Items.Count div ButtonsPerRow;
    if Category.Items.Count mod ButtonsPerRow <> 0 then
      Inc(RowCount);

    Result := RowCount * FButtonHeight + cBorderBuffer;
    if not (boVerticalCategoryCaptions in ButtonOptions) then
      Result := Result + FGutterSize;
  end;
end;

function TCategoryButtons.CalcCategoryWidth(
  const Category: TButtonCategory; const ButtonsPerCol: Integer): Integer;
var
  ColCount: Integer;
begin
  if Category.Collapsed or (Category.Items = nil) or
      (Category.Items.Count = 0) then
    Result := FCollapsedHeight + cBorderBuffer
  else
  begin
    ColCount := Category.Items.Count div ButtonsPerCol;
    if Category.Items.Count mod ButtonsPerCol <> 0 then
      Inc(ColCount);

    Result := ColCount * FButtonWidth + cBorderBuffer;
    if boVerticalCategoryCaptions in ButtonOptions then
      Result := Result + FGutterSize;
  end;
end;

procedure TCategoryButtons.AdjustCategoryBounds(const Category: TButtonCategory;
  var CategoryBounds: TRect);
begin
  // Adjust a the category bounds to collapsed dimensions (even if not collapsed)
  if (FButtonFlow = cbfVertical) and not Category.Collapsed
    and (Category.Items.Count > 0) then
  begin
    if (boVerticalCategoryCaptions in ButtonOptions) then
    begin
      CategoryBounds.Right := CategoryBounds.Left + FCollapsedHeight + cBorderBuffer;
      CategoryBounds.Bottom := CategoryBounds.Bottom - 3;
    end
    else
      CategoryBounds.Bottom := CategoryBounds.Top + FCollapsedHeight + cBorderBuffer - 2
  end;
end;

procedure TCategoryButtons.GetCategoryBounds(const Category: TButtonCategory;
  const StartingPos: Integer; var CategoryBounds, ButtonBounds: TRect);
var
  CatHeight, CatWidth: Integer;
  ButtonsPerRow, ButtonsPerCol: Integer;
  XStart, YStart: Integer;
  XEnd, YEnd: Integer;
begin
  if FButtonFlow = cbfVertical then
  begin
    { 2 Pixel buffer on each side }
    XStart := 2;
    XEnd := ClientWidth - 2;

    ButtonsPerRow := CalcButtonsPerRow;
    CatHeight := CalcCategoryHeight(Category, ButtonsPerRow);

    with CategoryBounds do
    begin
      Left := XStart;
      Top := StartingPos + 1;
      Right := XEnd;
      Bottom := StartingPos + CatHeight - 1;
    end;

    if not Category.Collapsed then
    begin
      if boCaptionOnlyBorder in ButtonOptions then
        with CategoryBounds do
          Inc(Bottom, 3);

      with ButtonBounds do
      begin
        if boVerticalCategoryCaptions in ButtonOptions then
        begin
          Left := XStart + FGutterSize + cBorderBuffer;
          Top := StartingPos;
        end
        else
        begin
          Left := XStart + 2;
          Top := StartingPos + FGutterSize + 2;
        end;
        Right := XEnd - 1;
        Bottom := Top + (Category.Items.Count div ButtonsPerRow) * FButtonHeight;
        if Category.Items.Count mod ButtonsPerRow <> 0 then
          Inc(Bottom, FButtonHeight);
        Inc(Top, 3);
      end;
    end;
  end
  else
  begin
    { 2 Pixel buffer on each side }
    YStart := 2;
    YEnd := ClientHeight - 3;

    ButtonsPerCol := CalcButtonsPerCol;
    CatWidth := CalcCategoryWidth(Category, ButtonsPerCol);

    with CategoryBounds do
    begin
      Left := StartingPos + 1;
      Top := YStart;
      Right := StartingPos + CatWidth - 1;;
      Bottom := YEnd;
    end;

    if not Category.Collapsed then
      with ButtonBounds do
      begin
        Left := StartingPos + 3;
        if not (boVerticalCategoryCaptions in ButtonOptions) then
          Top := YStart + FGutterSize + 1
        else
        begin
          Top := YStart + 2;
          Left := Left + FGutterSize;
        end;

        Bottom := YEnd - 1;
        Right := Left + (Category.Items.Count div ButtonsPerCol) * FButtonWidth;
        if Category.Items.Count mod ButtonsPerCol <> 0 then
          Inc(Right, FButtonWidth);
      end;
  end;
end;

const
  cDropDownSize = 13;

function TCategoryButtons.GetChevronBounds(const CategoryBounds: TRect): TRect;
begin
  Result.Left := CategoryBounds.Left + 2;
  Result.Top := CategoryBounds.Top + 2;
  Result.Right := Result.Left + cDropDownSize;
  Result.Bottom := Result.Top + cDropDownSize;
end;

function TCategoryButtons.GetCurrentCategory: TButtonCategory;
begin
  Result := nil;
  if FSelectedItem <> nil then
  begin
    if FSelectedItem.InheritsFrom(TButtonCategory) then
      Result := FSelectedItem as TButtonCategory
    else if FSelectedItem.InheritsFrom(TButtonItem) then
      Result := TButtonItem(FSelectedItem).Category;
  end;
end;

procedure TCategoryButtons.DrawCategory(const Category: TButtonCategory;
  const Canvas: TCanvas; StartingPos: Integer);

  procedure DrawDropDownButton(X, Y: Integer; Collapsed: Boolean);
  const
    ChevronDirection: array[Boolean] of TScrollDirection = (sdDown, sdRight);
    ChevronXPosAdjust: array[Boolean] of Integer = (2, 0);
    ChevronYPosAdjust: array[Boolean] of Integer = (1, 3);
  var
    Middle: Integer;

    procedure DrawPlusMinus;
    var
      Width, Height: Integer;
      Details: TThemedElementDetails;
    begin
      Width := 9;
      Height := Width;
      Inc(X, 2);
      Inc(Y, 2);

      if ThemeServices.ThemesEnabled then
      begin
        if Collapsed then
          Details := ThemeServices.GetElementDetails(ttGlyphClosed)
        else
          Details := ThemeServices.GetElementDetails(ttGlyphOpened);
        ThemeServices.DrawElement(Canvas.Handle, Details, Rect(X, Y, X + Width, Y + Width));
      end
      else
      begin
        Canvas.Pen.Color := clBtnShadow;
        Canvas.Brush.Color := clWindow;
        Canvas.Rectangle(X, Y, X + Width, Y + Height);
        Canvas.Pen.Color := clWindowText;

        Canvas.MoveTo(X + 2, Y + Width div 2);
        Canvas.LineTo(X + Width - 2, Y + Width div 2);

        if Collapsed then
        begin
          Canvas.MoveTo(X + Width div 2, Y + 2);
          Canvas.LineTo(X + Width div 2, Y + Width - 2);
        end;
      end;
    end;

  begin
    if boUsePlusMinus in ButtonOptions then
    begin
      DrawPlusMinus;
    end
    else
    begin
      Middle := cDropDownSize div 2;
      Canvas.Pen.Color := clBtnShadow;
      DrawChevron(Canvas, ChevronDirection[Collapsed],
        Point(X + Middle - ChevronXPosAdjust[Collapsed], Y + Middle - ChevronYPosAdjust[Collapsed]), 3);
    end;
  end;

var
  I: Integer;
  ButtonTop, ButtonLeft, ButtonRight: Integer;
  ButtonRect: TRect;
  ActualWidth: Integer;
  ButtonStart: Integer;
  ButtonBottom: Integer;
  CapWidth: Integer;
  VerticalCaption: Boolean;
  CapLeft: Integer;
  DrawState: TButtonDrawState;
  Button: TButtonItem;
  CatHeight: Integer;
  CategoryBounds, CategoryFrameBounds,
  ButtonBounds, ChevronBounds: TRect;
  GradientColor, SourceColor, TempColor: TColor;
  Caption: string;
  CaptionRect: TRect;
  CategoryRealBounds: TRect;
begin
  GetCategoryBounds(Category, StartingPos, CategoryBounds, ButtonBounds);

  if FSelectedItem = Category then
    SourceColor := FSelectedButtonColor
  else if Category.Color <> clNone then
    SourceColor := Category.Color
  else
    SourceColor := Self.Color;

  CategoryFrameBounds := CategoryBounds;
  AdjustCategoryBounds(Category, CategoryFrameBounds);
  if boCaptionOnlyBorder in ButtonOptions then
    CategoryRealBounds := CategoryFrameBounds else
    CategoryRealBounds := CategoryBounds;

  if (FSelectedItem <> Category) and (boGradientFill in FButtonOptions) then
  begin
    if Category.GradientColor <> clNone then
      GradientColor := Category.GradientColor
    else
      GradientColor := Self.Color;

    GradientFillCanvas(Canvas, SourceColor, GradientColor, CategoryRealBounds,
      FGradientDirection);
  end
  else
  begin
    Canvas.Brush.Color := SourceColor;
    Canvas.FillRect(CategoryRealBounds)
  end;

  with CategoryRealBounds do
  begin
    Right := Right - 1;
    // take care of the top left few pixels..
    TempColor := Self.Color;
    Canvas.Pixels[Left, Top] := TempColor;
    Canvas.Pixels[Left+1, Top] := TempColor;
    Canvas.Pixels[Left, Top+1] := TempColor;

    Canvas.Pixels[Left, Bottom] := TempColor;
    Canvas.Pixels[Left+1, Bottom] := TempColor;
    Canvas.Pixels[Left, Bottom-1] := TempColor;

    if BackgroundGradientColor <> clNone then
      TempColor := BackgroundGradientColor;

    Canvas.Pixels[Right, Top] := TempColor;
    Canvas.Pixels[Right-1, Top] := TempColor;
    Canvas.Pixels[Right, Top+1] := TempColor;

    Canvas.Pixels[Right, Bottom] := TempColor;
    Canvas.Pixels[Right-1, Bottom] := TempColor;
    Canvas.Pixels[Right, Bottom-1] := TempColor;

    { Now draw an outline }
    Canvas.Pen.Color := GetShadowColor(SourceColor, -10);
    Canvas.Polyline([Point(Left + 2, Top),
      Point(Right - 2, Top), { Top line }
      Point(Right, Top + 2), { Top right curve }
      Point(Right, Bottom - 2), { Right side line }
      Point(Right - 2, Bottom), { Bottom right curve }
      Point(Left + 2, Bottom), { Bottom line }
      Point(Left, Bottom - 2), { Bottom left curve }
      Point(Left, Top + 2), { Left side line }
      Point(Left + 2, Top)]); { Top left curve }
  end;

  if ((Category.Collapsed) and (FSelectedItem <> nil) and
     (CurrentCategory = Category)) or (FSelectedItem = Category) then
  begin
    Canvas.Brush.Color :=  GetShadowColor(SourceColor, -75);
    with CategoryFrameBounds do
      Canvas.FrameRect(Rect(Left + 1, Top + 1, Right, Bottom));
  end;

  ChevronBounds := GetChevronBounds(CategoryRealBounds);

  if Category.Items.Count > 0 then
    DrawDropDownButton(ChevronBounds.Left, ChevronBounds.Top,
      Category.Collapsed);

  VerticalCaption := True;
  if FButtonFlow = cbfVertical then
  begin
    if not (boVerticalCategoryCaptions in ButtonOptions) or
        Category.Collapsed or
        (Category.Items = nil) or
        (Category.Items.Count = 0) then
      VerticalCaption := False
  end
  else if not (boVerticalCategoryCaptions in ButtonOptions) and
      not (Category.Collapsed or (Category.Items = nil) or (Category.Items.Count = 0)) then
    VerticalCaption := False;

  { Draw the category caption. Truncating and vertical as needed. }
  Caption := Category.Caption;

  if (boBoldCaptions in ButtonOptions) then
    Canvas.Font.Style := Canvas.Font.Style + [fsBold];

  CapWidth := Canvas.TextWidth(Caption);
  if VerticalCaption then
    CatHeight := CategoryBounds.Bottom - CategoryBounds.Top - 3 - cDropDownSize
  else
    CatHeight := CategoryBounds.Right - CategoryBounds.Left - 2 - cDropDownSize;

  CapLeft := (CatHeight - CapWidth) div 2;
  if CapLeft < 2 then
    CapLeft := 2;


  Canvas.Brush.Style := bsClear;
  Canvas.Font.Color := Category.TextColor;
  if not VerticalCaption then
  begin
    CaptionRect.Left := CategoryBounds.Left + 4 + cDropDownSize;
    CaptionRect.Top := CategoryBounds.Top + 1;
  end
  else
  begin
    CaptionRect.Left := CategoryBounds.Left + 1;
    CaptionRect.Top := CategoryBounds.Bottom - CapLeft;
    Canvas.Font.Orientation := 900;
  end;

  CaptionRect.Right := CaptionRect.Left + CatHeight;
  CaptionRect.Bottom := CaptionRect.Top + Canvas.TextHeight(Caption);
  Canvas.TextRect(CaptionRect, Caption, [tfNoClip, tfEndEllipsis]);

  if (boBoldCaptions in ButtonOptions) then
    Canvas.Font.Style := Canvas.Font.Style - [fsBold];

  Canvas.Brush.Style := bsSolid;
  Canvas.Font.Orientation := 0;

  if not Category.Collapsed then
  begin
    { Draw the buttons }
    if (FButtonFlow = cbfVertical) and (boFullSize in ButtonOptions) then
      ActualWidth := ClientWidth - FSideBufferSize
    else
      ActualWidth := FButtonWidth;

    ButtonStart := ButtonBounds.Left;
    ButtonTop := ButtonBounds.Top;
    ButtonLeft := ButtonStart;
    for I := 0 to Category.Items.Count - 1 do
    begin
      { Don't waste time painting clipped things }
      if (FButtonFlow = cbfVertical) and (ButtonTop > ClientHeight) then
        Break; { Done drawing }

      { Don't waste time drawing what is offscreen }
      ButtonBottom := ButtonTop + FButtonHeight;
      ButtonRight := ButtonLeft + ActualWidth;
      // Make buttons narrower to leave room to draw the category border
      // around the right side.
      if VerticalCaption and not (boCaptionOnlyBorder in ButtonOptions) then
        Dec(ButtonRight, 3);
      if (ButtonBottom >= 0) and (ButtonRight >= 0) then
      begin
        ButtonRect := Rect(ButtonLeft, ButtonTop, ButtonRight, ButtonBottom);

        Button := Category.Items[I];
        DrawState := [];
        if Button = FHotButton then
        begin
          Include(DrawState, bdsHot);
          if Button = FDownButton then
            Include(DrawState, bdsDown);
        end;
        if Button = FSelectedItem then
          Include(DrawState, bdsSelected)
        else if (Button = FFocusedItem) and Focused and (FDownButton = nil) then
          Include(DrawState, bdsFocused);

        if Button = FInsertTop then
          Include(DrawState, bdsInsertTop)
        else if Button = FInsertBottom then
          Include(DrawState, bdsInsertBottom)
        else if Button = FInsertRight then
          Include(DrawState, bdsInsertRight)
        else if Button = FInsertLeft then
          Include(DrawState, bdsInsertLeft);

        DrawButton(Button, Canvas, ButtonRect, DrawState);
      end;
      Inc(ButtonLeft, ActualWidth);

      if (ButtonLeft + ActualWidth) > ButtonBounds.Right then
      begin
        ButtonLeft := ButtonStart;
        Inc(ButtonTop, FButtonHeight);
      end;
    end;
  end;
end;

procedure TCategoryButtons.Paint;
var
  TopCategory: Integer;
  CatIndex: Integer;
  StartingPos: Integer;
  EndingPos: Integer;
  Category: TButtonCategory;
begin
  TopCategory := GetIndexOfFirstCategory;

  if BackgroundGradientColor = clNone then
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(ClientRect);
  end
  else
    GradientFillCanvas(Canvas, Color, BackgroundGradientColor, ClientRect,
      BackgroundGradientDirection);

  if (TopCategory > -1) and (TopCategory < FButtonCategories.Count) then
  begin
    { Calculate the virtual position and ending position }
    StartingPos := FButtonCategories[TopCategory].FStart - GetScrollOffset;
    if FButtonFlow = cbfVertical then
      EndingPos := ClientHeight
    else
      EndingPos := ClientWidth;
    for CatIndex := TopCategory to FButtonCategories.Count - 1 do
    begin
      Category := FButtonCategories[CatIndex];
      DrawCategory(Category, Canvas, StartingPos);
      StartingPos := StartingPos + Category.FEnd - Category.FStart;
      { Stop drawing early, if we can }
      if StartingPos > EndingPos then
        Break;
    end;
  end;
end;

function TCategoryButtons.CalcButtonsPerRow: Integer;
begin
  if boFullSize in ButtonOptions then
    Result := 1
  else
  begin
    Result := (ClientWidth - FSideBufferSize) div FButtonWidth;
    if Result = 0 then
      Result := 1;
  end;
end;

function TCategoryButtons.CalcButtonsPerCol: Integer;
begin
  { Ignore full size buttons; they don't make sense in this layout }
  Result := (ClientHeight - FSideBufferSize) div FButtonHeight;
  if Result = 0 then
    Result := 1;
end;

const
  cScrollBarKind: array[TCatButtonFlow] of Integer = (SB_VERT, SB_HORZ);

procedure TCategoryButtons.Resize;

  function CalcCategoryHeights: Integer;
  var
    I: Integer;
    Category: TButtonCategory;
    Y: Integer;
    ButtonsPerRow: Integer;
  begin
    ButtonsPerRow := CalcButtonsPerRow;
    Y := 0;
    for I := 0 to FButtonCategories.Count - 1 do
    begin
      Category := FButtonCategories[I];
      Category.FStart := Y;
      Category.FEnd := Y + CalcCategoryHeight(Category, ButtonsPerRow);
      Y := Category.FEnd;
    end;
    Result := Y;
  end;

  function CalcCategoryWidths: Integer;
  var
    I: Integer;
    Category: TButtonCategory;
    X: Integer;
    ButtonsPerCol: Integer;
  begin
    ButtonsPerCol := CalcButtonsPerCol;
    X := 0;
    for I := 0 to FButtonCategories.Count - 1 do
    begin
      Category := FButtonCategories[I];
      Category.FStart := X;
      Category.FEnd := X + CalcCategoryWidth(Category, ButtonsPerCol);
      X := Category.FEnd;
    end;
    Result := X;
  end;

var
  ScrollInfo: TScrollInfo;
  TotalAmount: Integer;
  AmountSeen: Integer;
begin
  inherited;
  if (not HandleAllocated) or (FGutterSize = 0) then
    Exit;

  if FButtonFlow = cbfVertical then
  begin
    TotalAmount := CalcCategoryHeights;
    AmountSeen := ClientHeight;
  end
  else
  begin
    TotalAmount := CalcCategoryWidths;
    AmountSeen := ClientWidth;
  end;

  { Do we have to take the scrollbar into consideration? }
  if (TotalAmount > AmountSeen) then
  begin
    { The max size is the number of "rows of buttons" that are hidden }
    FScrollBarMax := (TotalAmount div FScrollSize);
    ScrollInfo.nMax := FScrollBarMax;

    AmountSeen := AmountSeen div FScrollSize;
    if FScrollBarMax > AmountSeen then
      FPageAmount := AmountSeen
    else
      FPageAmount := FScrollBarMax;

    { Adjust the max to NOT contain the page amount }
    FScrollBarMax := FScrollBarMax - FPageAmount + 1;

    if FScrollBarPos > FScrollBarMax then
      FScrollBarPos := FScrollBarMax;

{$IF DEFINED(CLR)}
    ScrollInfo.cbSize := Marshal.SizeOf(TypeOf(TScrollInfo));
{$ELSE}
    ScrollInfo.cbSize := SizeOf(TScrollInfo);
{$IFEND}
    ScrollInfo.fMask := SIF_RANGE or SIF_POS or SIF_PAGE;
    ScrollInfo.nMin := 0;
    ScrollInfo.nPos := FScrollBarPos;
    ScrollInfo.nPage := FPageAmount;

    SetScrollInfo(Handle, cScrollBarKind[FButtonFlow], ScrollInfo, True);
    ShowScrollBar(True);
  end
  else
  begin
    FScrollBarPos := 0;
    FScrollBarMax := 0;
    ShowScrollBar(False);
  end;
end;

procedure TCategoryButtons.SetBorderStyle(const Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TCategoryButtons.SetButtonHeight(const Value: Integer);
begin
  if (FButtonHeight <> Value) and (Value > 0) then
  begin
    FButtonHeight := Value;
    FScrollSize := FButtonHeight;
    Resize;
    UpdateAllButtons;
  end;
end;

procedure TCategoryButtons.SetButtonCategories(const Value: TButtonCategories);
begin
  FButtonCategories.Assign(Value);
end;

procedure TCategoryButtons.SetCatButtonOptions(const Value: TCatButtonOptions);
begin
  if FButtonOptions <> Value then
  begin
    FButtonOptions := Value;
    CalcBufferSizes;
    Resize;
    UpdateAllButtons;
  end;
end;

procedure TCategoryButtons.SetButtonWidth(const Value: Integer);
begin
  if (FButtonWidth <> Value) and (Value > 0) then
  begin
    FButtonWidth := Value;
    Resize;
    UpdateAllButtons;
  end;
end;

procedure TCategoryButtons.ShowScrollBar(const Visible: Boolean);
begin
  if Visible <> FScrollBarShown then
  begin
    FScrollBarShown := Visible;
    Windows.ShowScrollBar(Handle, cScrollBarKind[ButtonFlow], Visible);
  end;
end;

procedure TCategoryButtons.UpdateAllButtons;
begin
  Invalidate;
end;

procedure TCategoryButtons.UpdateButton(const Button: TBaseItem);
var
  R: TRect;
begin
  { Just invalidate one button's rect }
  if (Button <> nil) and (HandleAllocated) then
  begin
    if (Button is TButtonCategory) and (boCaptionOnlyBorder in ButtonOptions) then
      R := GetCategoryRect(TButtonCategory(Button), True) else
      R := GetButtonRect(Button);
    if not IsRectEmpty(R) then
      InvalidateRect(Handle, R, False);
  end;
end;

procedure TCategoryButtons.WMVScroll(var Message: TWMVScroll);
begin
  with Message do
    ScrollPosChanged(TScrollCode(ScrollCode), Pos);
end;

procedure TCategoryButtons.WMHScroll(var Message: TWMVScroll);
begin
  with Message do
    ScrollPosChanged(TScrollCode(ScrollCode), Pos);
end;

procedure TCategoryButtons.ScrollPosChanged(ScrollCode: TScrollCode;
  ScrollPos: Integer);
var
  OldPos: Integer;
begin
  OldPos := FScrollBarPos;
  if (ScrollCode = scLineUp) and (FScrollBarPos > 0) then
    Dec(FScrollBarPos)
  else if (ScrollCode = scLineDown) and (FScrollBarPos < FScrollBarMax) then
    Inc(FScrollBarPos)
  else if (ScrollCode = scPageUp) then
  begin
    Dec(FScrollBarPos, FPageAmount);
    if FScrollBarPos < 0 then
      FScrollBarPos := 0;
  end
  else if ScrollCode = scPageDown then
  begin
    Inc(FScrollBarPos, FPageAmount);
    if FScrollBarPos > FScrollBarMax then
      FScrollBarPos := FScrollBarMax;
  end
  else if ScrollCode in [scPosition, scTrack] then
    FScrollBarPos := ScrollPos
  else if ScrollCode = scTop then
    FScrollBarPos := 0
  else if ScrollCode = scBottom then
    FScrollBarPos := FScrollBarMax;
  if OldPos <> FScrollBarPos then
  begin
    Windows.SetScrollPos(Handle, cScrollBarKind[FButtonFlow], FScrollBarPos, True);
    Invalidate;
  end;
end;

procedure TCategoryButtons.SetImages(const Value: TCustomImageList);
begin
  if Images <> Value then
  begin
    if Images <> nil then
      Images.UnRegisterChanges(FImageChangeLink);
    FImages := Value;
    if Images <> nil then
    begin
      Images.RegisterChanges(FImageChangeLink);
      Images.FreeNotification(Self);
   end;
   UpdateAllButtons;
  end;
end;

procedure TCategoryButtons.DrawButton(const Button: TButtonItem; Canvas: TCanvas;
  Rect: TRect; State: TButtonDrawState);
var
  TextLeft, TextTop: Integer;
  RectHeight: Integer;
  ImgTop: Integer;
  TextOffset: Integer;
  FillColor: TColor;
  EdgeColor: TColor;
  InsertIndication: TRect;
  TextRect: TRect;
  OrgRect: TRect;
  Caption: string;
begin
  if Assigned(FOnDrawButton) and (not (csDesigning in ComponentState)) then
    FOnDrawButton(Self, Button, Canvas, Rect, State)
  else
  begin
    OrgRect := Rect;
    if Assigned(FOnBeforeDrawButton) then
      FOnBeforeDrawButton(Self, Button, Canvas, Rect, State);
    InflateRect(Rect, -1, -1);

    Canvas.Font.Color := clBtnText;
    if bdsHot in State then
    begin
      FillColor := FHotButtonColor;
      if bdsSelected in State then
        FillColor := GetShadowColor(FillColor, -10);
      EdgeColor := GetShadowColor(FillColor);
    end
    else if bdsSelected in State then
    begin
      FillColor := FSelectedButtonColor;
      EdgeColor := GetShadowColor(FillColor);
    end
    else
    begin
      FillColor := FRegularButtonColor;
      if (bdsFocused in State) then
        EdgeColor := GetShadowColor(FSelectedButtonColor)
      else
        EdgeColor := GetShadowColor(FillColor);
    end;

    Canvas.Brush.Color := FillColor;
    if FillColor <> clNone then
    begin
      Canvas.FillRect(Rect);
      { Draw the edge outline }
      Canvas.Brush.Color := EdgeColor;
      Canvas.FrameRect(Rect);
    end;

    if bdsFocused in State then
    begin
      InflateRect(Rect, -1, -1);
      Canvas.FrameRect(Rect);
    end;

    Canvas.Brush.Color := FillColor;

    { Compute the text location }
    TextLeft := Rect.Left + 4;
    RectHeight := Rect.Bottom - Rect.Top;
    TextTop := Rect.Top + (RectHeight - Canvas.TextHeight('Wg')) div 2;

    if boFullSize in ButtonOptions then
      Inc(TextLeft, 4);  // indent, slightly

    if TextTop < Rect.Top then
      TextTop := Rect.Top;
    if bdsDown in State then
    begin
      Inc(TextTop);
      Inc(TextLeft);
    end;

    { Draw the icon - prefer the event }
    TextOffset := 0;
    if Assigned(FOnDrawIcon) then
      FOnDrawIcon(Self, Button, Canvas, OrgRect, State, TextOffset)
    else if (FImages <> nil) and (Button.ImageIndex > -1) and
        (Button.ImageIndex < FImages.Count) then
    begin
      ImgTop := Rect.Top + (RectHeight - FImages.Height) div 2;
      if ImgTop < Rect.Top then
        ImgTop := Rect.Top;
      if bdsDown in State then
        Inc(ImgTop);
      FImages.Draw(Canvas, TextLeft - 1, ImgTop, Button.ImageIndex);
      TextOffset := FImages.Width + 1;
    end;

    { Show insert indications }
    if [bdsInsertLeft, bdsInsertTop, bdsInsertRight, bdsInsertBottom] * State <> [] then
    begin
      Canvas.Brush.Color := GetShadowColor(EdgeColor);
      InsertIndication := Rect;
      if bdsInsertLeft in State then
      begin
        Dec(InsertIndication.Left, 2);
        InsertIndication.Right := InsertIndication.Left + 2;
      end
      else if bdsInsertTop in State then
      begin
        Dec(InsertIndication.Top);
        InsertIndication.Bottom := InsertIndication.Top + 2;
      end
      else if bdsInsertRight in State then
      begin
        Inc(InsertIndication.Right, 2);
        InsertIndication.Left := InsertIndication.Right - 2;
      end
      else if bdsInsertBottom in State then
      begin
        Inc(InsertIndication.Bottom);
        InsertIndication.Top := InsertIndication.Bottom - 2;
      end;
      Canvas.FillRect(InsertIndication);
      Canvas.Brush.Color := FillColor;
    end;

    if boShowCaptions in FButtonOptions then
    begin
      if FillColor = clNone then
        Canvas.Brush.Style := bsClear;

      { Avoid clipping the image }
      Inc(TextLeft, TextOffset);
      TextRect.Left := TextLeft;
      TextRect.Right := Rect.Right - 2;
      TextRect.Top := TextTop;
      TextRect.Bottom := Rect.Bottom - 2;

      if Assigned(FOnDrawText) then
        FOnDrawText(Self, Button, Canvas, TextRect, State)
      else
      begin
        Caption := Button.Caption;
        Canvas.TextRect(TextRect, Caption, [tfEndEllipsis, tfVerticalCenter]);
      end;
    end;

    if Assigned(FOnAfterDrawButton) then
      FOnAfterDrawButton(Self, Button, Canvas, OrgRect, State);
  end;
  Canvas.Brush.Color := Color; { Restore the original color }
end;

procedure TCategoryButtons.SetOnDrawButton(const Value: TCatButtonDrawEvent);
begin
  FOnDrawButton := Value;
  Invalidate;
end;

procedure TCategoryButtons.SetOnDrawIcon(const Value: TCatButtonDrawIconEvent);
begin
  FOnDrawIcon := Value;
  Invalidate;
end;

procedure TCategoryButtons.CalcBufferSizes;
var
  VertInOpt: Boolean;
begin
  if HandleAllocated then
  begin
    Canvas.Font := Font;
    FCollapsedHeight := Canvas.TextHeight('Wg');  { Do not localize }
    FGutterSize := FCollapsedHeight + 1 { Border around the text };
    FScrollSize := FButtonHeight;

    VertInOpt := boVerticalCategoryCaptions in ButtonOptions;
    if ((FButtonFlow = cbfVertical) and VertInOpt) or
       ((FButtonFlow = cbfHorizontal) and not VertInOpt) then
      FSideBufferSize := FGutterSize + 8
    else
      FSideBufferSize := 8;
  end;
end;

{$IFDEF CLR}
[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
{$ENDIF}
procedure TCategoryButtons.CreateHandle;
begin
  inherited CreateHandle;
  CalcBufferSizes;
  Resize;
end;

procedure TCategoryButtons.WMMouseLeave(var Message: TMessage);
begin
  FMouseInControl := False;
  if FHotButton <> nil then
  begin
    UpdateButton(FHotButton);
    FHotButton := nil;
    DoHotButton;
  end;
  if FDragImageList.Dragging then
  begin
    FDragImageList.HideDragImage;
    RemoveInsertionPoints;
    UpdateWindow(Handle);
    FDragImageList.ShowDragImage;
  end;
end;

procedure TCategoryButtons.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  DownCategory: TButtonCategory;
begin
  inherited;
  if Button = mbLeft then
  begin
    FDragStarted := False;
    DownCategory := GetCategoryAt(X, Y);
    FDownButton := GetButtonAt(X, Y, DownCategory);
    SetSelectedItem(FDownButton);

    { Focus ourselves, when clicked, like a button would, but
      after setting the FDownButton }
    if (not Focused) and CanFocus then
      Windows.SetFocus(Handle);

    if FDownButton <> nil then
    begin
      FDragButton := FDownButton;
      FDragStartPos := Point(X, Y);
      UpdateButton(FDownButton);
    end
    else if DownCategory <> nil then
    begin
      SetSelectedItem(DownCategory);
      if GetAllowReorder then
      begin
        FDragCategory := DownCategory;
        FDragStartPos := Point(X, Y);
      end;
    end;
  end;
end;

procedure TCategoryButtons.BeginAutoDrag;
begin
  FDragStartPos := ScreenToClient(Mouse.CursorPos);
  with FDragStartPos do
    FDragButton := GetButtonAt(X, Y);
  if FDragButton <> nil then
  begin
    FDragStarted := True;
    DoBeginDrag(Mouse.DragImmediate, Mouse.DragThreshold);
  end;
  { Don't call inherited; the above takes care of calling BeginDrag } 
end;

procedure TCategoryButtons.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewHotButton, OldHotButton: TButtonItem;
  EventTrack: TTrackMouseEvent;
  DragThreshold: Integer;
begin
  inherited;
  { Was the drag threshold met? }
  if (GetAllowReorder) and
    ((FDragButton <> nil) or (FDragCategory <> nil)) then
  begin
    DragThreshold := Mouse.DragThreshold;
    if (Abs(FDragStartPos.X - X) >= DragThreshold) or
        (Abs(FDragStartPos.Y - Y) >= DragThreshold) then
    begin
      FDragStartPos.X := X; { Used in the start of the drag }
      FDragStartPos.Y := Y;
      FDownButton := nil; { Stops repaints and clicks }
      if FHotButton <> nil then
      begin
        OldHotButton := FHotButton;
        FHotButton := nil;
        UpdateButton(OldHotButton);
        { We must have the window process the paint message before
          the drag operation starts }
        UpdateWindow(Handle);
        DoHotButton;
      end;
      FDragStarted := True;
      DoBeginDrag(True, -1);
      Exit;
    end;
  end;

  NewHotButton := GetButtonAt(X, Y);
  if NewHotButton <> FHotButton then
  begin
    OldHotButton := FHotButton;
    FHotButton := NewHotButton;
    UpdateButton(OldHotButton);
    UpdateButton(FHotButton);
    DoHotButton;
  end;
  if not FMouseInControl then
  begin
    FMouseInControl := True;
{$IF DEFINED(CLR)}
    EventTrack.cbSize := Marshal.SizeOf(TypeOf(TTrackMouseEvent));
{$ELSE}
    EventTrack.cbSize := SizeOf(TTrackMouseEvent);
{$IFEND}
    EventTrack.dwFlags := TME_LEAVE;
    EventTrack.hwndTrack := Handle;
    EventTrack.dwHoverTime := 0;
    TrackMouseEvent(EventTrack);
  end;
end;

procedure TCategoryButtons.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  R: TRect;
  LastDown: TButtonItem;
  DownCategory: TButtonCategory;
begin
  inherited;
  if (Button = mbLeft) and (not FDragStarted) then
  begin
    LastDown := FDownButton;
    FDownButton := nil;
    FDragButton := nil;
    FDragCategory := nil;
    if LastDown <> nil then
      UpdateButton(LastDown);
    if (LastDown <> nil) and (GetButtonAt(X, Y) = LastDown) then
    begin
      SelectedItem := LastDown;
      DoItemClicked(FSelectedItem);
    end
    else
    begin
      DownCategory := GetCategoryAt(X, Y);
      if ((DownCategory <> nil) and (DownCategory.Items.Count > 0)) then
      begin
        R := GetCategoryRect(DownCategory, True);
        if PtInRect(R, Point(X, Y)) then
          DownCategory.Collapsed := not DownCategory.Collapsed
      end;
    end;
    Click;
  end;
  FDragStarted := False;
end;

function TCategoryButtons.GetButtonAt(X, Y: Integer;
  Category: TButtonCategory = nil): TButtonItem;
var
  Row, Col: Integer;
  CategoryBounds, ButtonBounds: TRect;
  ResIndex: Integer;
  ButtonsPerRow: Integer;
begin
  Result := nil;
  if Category = nil then
    Category := GetCategoryAt(X, Y);
  if Category <> nil then
  begin
    { Translate the X or Y position to our virtual system }
    if FButtonFlow = cbfVertical then
      Y := Y + GetScrollOffset { Amount hidden }
    else
      X := X + GetScrollOffset;
    GetCategoryBounds(Category, Category.FStart, CategoryBounds, ButtonBounds);
    if (X >= ButtonBounds.Left) and (X <= ButtonBounds.Right) and
       (Y >= ButtonBounds.Top) and (Y <= ButtonBounds.Bottom) then
    begin
      { Find out which button it is. }
      Row := (Y - ButtonBounds.Top) div FButtonHeight;
      if (FButtonFlow = cbfVertical) and (boFullSize in FButtonOptions) then
        Col := 0
      else
      begin
        Col := (X - ButtonBounds.Left) div FButtonWidth;
        if ButtonBounds.Left + (Col+1)*FButtonWidth > ButtonBounds.Right then
          Exit; { Not within the bounds }
      end;

      if FButtonFlow = cbfVertical then
        ButtonsPerRow := CalcButtonsPerRow
      else
        ButtonsPerRow := (ButtonBounds.Right - ButtonBounds.Left) div FButtonWidth;
      ResIndex := Row * ButtonsPerRow + Col;
      if ResIndex < Category.Items.Count then
        Result := Category.Items[ResIndex];
    end;
  end;
end;

procedure TCategoryButtons.DoItemClicked(const Button: TBaseItem);
var
  LButton: TButtonItem;
  LOnClick: TNotifyEvent;
begin
  if (Button is TButtonItem) then
  begin
    LButton := TButtonItem(Button);
    LOnClick := LButton.OnClick;
    if Assigned(LOnClick) and (LButton.Action <> nil) and not DelegatesEqual(@LOnClick, @LButton.Action.OnExecute) then
      LOnClick(Self)
    else if not (csDesigning in ComponentState) and (LButton.ActionLink <> nil) then
      LButton.ActionLink.Execute(Self)
    else if Assigned(LOnClick) then
      LOnClick(Self)
    else if Assigned(FOnButtonClicked) then
      FOnButtonClicked(Self, TButtonItem(Button));
  end
  else if Assigned(FOnButtonClicked) then
    FOnButtonClicked(Self, TButtonItem(Button));
end;

procedure TCategoryButtons.DragDrop(Source: TObject; X, Y: Integer);
var
  TargetButton: TButtonItem;
  TargetCategory: TButtonCategory;
begin
  if ((boAllowReorder in ButtonOptions) and
    ((Source = Self) or
        ((Source is TBaseDragControlObject) and (TBaseDragControlObject(Source).Control = Self)))) then
  begin
    RemoveInsertionPoints;
    GetTargetAt(X, Y, TargetButton, TargetCategory);
    if (TargetCategory <> nil) and (FDragButton <> nil) then
    begin
      { Reordering, or copying? }
      if (boAllowCopyingButtons in ButtonOptions) and
         (GetKeyState(VK_CONTROL) < 0) then
        DoCopyButton(FDragButton, TargetCategory, TargetButton)
      else
        DoReorderButton(FDragButton, TargetCategory, TargetButton);
    end
    else if (FDragCategory <> nil) then
      DoReorderCategory(FDragCategory, TargetCategory);
    FDragButton := nil;
    FDragCategory := nil;
  end
  else
    inherited;
end;

procedure TCategoryButtons.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  OverButton: TButtonItem;
  OverCategory: TButtonCategory;
  Temp: DWORD;
begin
  if (boAllowReorder in ButtonOptions) and
    ((Source = Self) or ((Source is TBaseDragControlObject) and
        (TBaseDragControlObject(Source).Control = Self))) then
  begin
    if ShouldScrollDown(Temp) then
      AutoScroll(scLineDown)
    else if ShouldScrollUp(Temp) then
      AutoScroll(scLineUp);

    GetTargetAt(X, Y, OverButton, OverCategory);

    if (boAllowCopyingButtons in ButtonOptions) and
       (GetKeyState(VK_CONTROL) < 0) then
    begin
      Accept := FDragButton <> nil; { Copy from somewhere to anywhere }
      DragCursor := crDragCopy;
    end
    else
    begin
      { Don't accept when it is the same as the start or right after us }
      Accept := (FDragButton <> nil) and (OverButton <> FDragButton)
        and (OverButton <> nil) and (OverButton.Index <> FDragButton.Index + 1);
      DragCursor := crDrag;
    end;

    if not Accept then
    begin
      { Accept if it is into another category, or it isn't the last index
        in the current category }
      Accept := (FDragButton <> nil) and (OverCategory <> nil) and
        ((OverButton = nil) or (OverCategory <> FDragButton.Category) or
         ((FDragButton <> OverButton) and (OverButton.Index <> FDragButton.Index + 1)));
      { If we are dragging the category, use similar logic }
      if (not Accept) and (FDragCategory <> nil) then
      begin
        OverButton := nil;
        Accept := OverCategory <> FDragCategory;
        if Accept then
          if OverCategory = nil then
            Accept := FDragCategory.Index <> Categories.Count - 1;
      end;
    end;

    if FDragButton <> nil then
    begin
      if Accept and (State <> dsDragLeave) then
      begin
        SetInsertionButton(OverButton, OverCategory)
      end
      else
      begin
        if FDragImageList.Dragging then
          FDragImageList.HideDragImage;
        RemoveInsertionPoints;
        if FDragImageList.Dragging then
        begin
          UpdateWindow(Handle);
          FDragImageList.ShowDragImage;
        end;
      end;
    end;
  end
  else
    inherited DragOver(Source, X, Y, State, Accept);
end;

procedure TCategoryButtons.DoHotButton;
begin
  if Assigned(FOnHotButton) then
    FOnHotButton(Self, FHotButton);
end;

procedure TCategoryButtons.GenerateDragImage;
var
  ButtonRect: TRect;
  State: TButtonDrawState;
  DragImage: TBitmap;
begin
  DragImage := TBitmap.Create;
  try
    if FDragButton <> nil then
    begin
      ButtonRect := GetButtonRect(FDragButton);
      DragImage.Width := ButtonRect.Right - ButtonRect.Left;
      DragImage.Height := ButtonRect.Bottom - ButtonRect.Top;
      State := [bdsDragged];
      if FSelectedItem = FDragButton then
        State := State + [bdsSelected];

      DragImage.Canvas.Brush.Color := clBtnFace;
      DragImage.Canvas.FillRect(Rect(0, 0, DragImage.Width, DragImage.Height));
      DrawButton(FDragButton, DragImage.Canvas,
        Rect(0, 0, DragImage.Width, DragImage.Height), State);
    end
    else
    begin
      Assert(FDragCategory <> nil);
      if (FDragCategory <> nil) then
      begin
        ButtonRect := GetCategoryRect(FDragCategory);
        DragImage.Width := ButtonRect.Right - ButtonRect.Left + 3;
        DragImage.Height := ButtonRect.Bottom - ButtonRect.Top + 2;
        DragImage.Canvas.Brush.Color := clBtnFace;
        DragImage.Canvas.FillRect(Rect(0, 0, DragImage.Width, DragImage.Height));
        DrawCategory(FDragCategory, DragImage.Canvas, 0);
      end;
    end;

    if (FDragButton <> nil) or (FDragCategory <> nil) then
    begin
      FDragImageList.Clear;
      FDragImageList.Width := DragImage.Width;
      FDragImageList.Height := DragImage.Height;
      FDragImageList.Add(DragImage, nil);

      FDragImageList.DragHotspot := Point(FDragStartPos.X - ButtonRect.Left - Mouse.DragThreshold,
        FDragStartPos.Y - ButtonRect.Top - Mouse.DragThreshold);
    end;
  finally
    DragImage.Free;
  end;
end;

procedure TCategoryButtons.DoStartDrag(var DragObject: TDragObject);
begin
  GenerateDragImage;
  inherited DoStartDrag(DragObject);
end;

function TCategoryButtons.GetDragImages: TDragImageList;
begin
  Result := FDragImageList;
end;

procedure TCategoryButtons.RemoveInsertionPoints;

  procedure ClearSelection(var Item: TBaseItem);
  var
    OldItem: TBaseItem;
  begin
    if Item <> nil then
    begin
      OldItem := Item;
      Item := nil;
      UpdateButton(OldItem);
    end;
  end;

begin
  ClearSelection(FInsertTop);
  ClearSelection(FInsertLeft);
  ClearSelection(FInsertRight);
  ClearSelection(FInsertBottom);
end;

procedure TCategoryButtons.DoReorderButton(const Button: TButtonItem;
  const TargetCategory: TButtonCategory; const TargetButton: TButtonItem);
var
  TargetIndex: Integer;
  OldCategory: TButtonCategory;
begin
  FIgnoreUpdate := True;
  try
    { Are we moving in the same cateogry to over a button? }
    OldCategory := Button.Category;
    if (TargetButton <> nil) and (Button.Category = TargetButton.Category) then
    begin
      TargetIndex := TargetButton.Index;
      if TargetIndex > Button.Index then
        Dec(TargetIndex); { Account for moving ourselves }
      Button.Index := TargetIndex;
    end
    else if TargetCategory <> nil then
    begin
      if TargetCategory = Button.Category then
      begin
        { Moving to the end of the category }
        Button.Index := TargetCategory.Items.Count - 1;
      end
      else
      begin
        Button.Collection := TargetCategory.Items;
        if (TargetButton <> nil) then
          Button.Index := TargetButton.Index;
        Resize; { We have to recalculate the group's size }
      end;
    end;
  finally
    FIgnoreUpdate := False;
  end;
  Invalidate;
  if Assigned(FOnReorderButton) then
    FOnReorderButton(Self, Button, OldCategory, TargetCategory);
end;

const
  cMinScrollDelay = 20;
  cMaxScrollDelay = 400;

function TCategoryButtons.ShouldScrollDown(out Delay: DWORD): Boolean;
var
  ScrollBuffer: Integer;
  AWidth, AHeight, LX, LY: Integer;
begin
  Result := FScrollBarPos < FScrollBarMax;
  if Result then
  begin
    ScrollBuffer := GetScrollBuffer;
    { Is the mouse still in position? }
    with ScreenToClient(Mouse.CursorPos) do
    begin
      if FButtonFlow = cbfHorizontal then
      begin
        { Switch X and Y and Width and Height }
        AWidth := X; { temp }
        LX := Y;
        LY := AWidth;
        AWidth := Height;
        AHeight := Width;
      end
      else
      begin
        AWidth := Width;
        AHeight := Height;
        LX := X;
        LY := Y;
      end;
    end;
    if (LX < 0) or (LX > AWidth) or (LY > AHeight) or (LY < AHeight - ScrollBuffer) then
      Result := False
    else
      Delay := Trunc(cMaxScrollDelay * ((AHeight - LY) / ScrollBuffer)) + cMinScrollDelay;
  end;
end;

function TCategoryButtons.ShouldScrollUp(out Delay: DWORD): Boolean;
var
  ScrollBuffer: Integer;
  AWidth, LX, LY: Integer;
begin
  Result := FScrollBarPos > 0;
  if Result then
  begin
    ScrollBuffer := GetScrollBuffer;
    with ScreenToClient(Mouse.CursorPos) do
    begin
      if FButtonFlow = cbfHorizontal then
      begin
        AWidth := X;
        LX := Y;
        LY := AWidth;
        AWidth := Height;
      end
      else
      begin
        AWidth := Width;
        LX := X;
        LY := Y;
      end;
    end;

    if (LX < 0) or (LX > AWidth) or (LY < 0) or (LY > ScrollBuffer) then
      Result := False
    else
      Delay := Trunc(cMaxScrollDelay * (LY / ScrollBuffer)) + cMinScrollDelay;
  end;
end;


procedure TCategoryButtons.AutoScroll(ScrollCode: TScrollCode);

  function ShouldContinue(out Delay: DWORD): Boolean;
  begin
    { Are we autoscrolling up or down? }
    if ScrollCode = scLineDown then
      Result := ShouldScrollDown(Delay)
    else
      Result := ShouldScrollUp(Delay)
  end;

var
  CurrentTime, StartTime, ElapsedTime: DWORD;
  Delay: DWORD;
begin
  FDragImageList.HideDragImage;
  RemoveInsertionPoints;
  FDragImageList.ShowDragImage;

  CurrentTime := 0;
  while (ShouldContinue(Delay)) do
  begin
    StartTime := GetCurrentTime;
    ElapsedTime := StartTime - CurrentTime;
    if ElapsedTime < Delay then
      Sleep(Delay - ElapsedTime);
    CurrentTime := StartTime;

    FDragImageList.HideDragImage;
    ScrollPosChanged(ScrollCode, 0{ Ignored});
    UpdateWindow(Handle);
    FDragImageList.ShowDragImage;
  end;
end;

function TCategoryButtons.GetNextButtonInGroup(const StartingButton: TBaseItem;
  GoForward: Boolean): TBaseItem;
var
  Category: TButtonCategory;
  NextIndex: Integer;
begin
  Result := nil;
  if StartingButton <> nil then
  begin
    Category := (StartingButton as TButtonItem).Category;
    if GoForward then
      NextIndex := StartingButton.Index + 1
    else
      NextIndex := StartingButton.Index - 1;

    if (NextIndex > -1) and (NextIndex < Category.Items.Count) then
      Result := Category.Items[NextIndex];  { Same category, next button in it. }
  end;
end;

procedure TCategoryButtons.GetTargetAt(X, Y: Integer;
  var TargetButton: TButtonItem; var TargetCategory: TButtonCategory);
var
  ButtonRect: TRect;
begin
  TargetCategory := GetCategoryAt(X, Y);
  TargetButton := GetButtonAt(X, Y, TargetCategory);
  if (TargetButton <> nil) then
  begin
    { Before the index, or after it?  }
    ButtonRect := GetButtonRect(TargetButton);

    if (FButtonFlow = cbfVertical) and (CalcButtonsPerRow = 1) then
    begin
      if Y > (ButtonRect.Top + (ButtonRect.Bottom - ButtonRect.Top) div 2) then
        TargetButton := GetNextButtonInGroup(TargetButton, True) as TButtonItem;
    end
    else
      if X > (ButtonRect.Left + (ButtonRect.Right - ButtonRect.Left) div 2) then
        TargetButton := GetNextButtonInGroup(TargetButton, True) as TButtonItem;
  end
  else if (TargetCategory <> nil) and (TargetCategory.Items.Count > 0) then
  begin
    { Insert before or after all the items? }
    if FButtonFlow = cbfVertical then
      Y := Y + GetScrollOffset { Amount hidden }
    else
      X := X + GetScrollOffset;
    if (FButtonFlow = cbfVertical) and (CalcButtonsPerRow = 1) then
    begin
      if Y < (TargetCategory.FStart + (TargetCategory.FEnd - TargetCategory.FStart) div 2) then
        if (not TargetCategory.Collapsed) then
          TargetButton := TargetCategory.Items[0]
    end
    else
      if X < (ClientWidth div 2) then
        if (not TargetCategory.Collapsed) then
          TargetButton := TargetCategory.Items[0]
  end;
end;

procedure TCategoryButtons.CNKeyDown(var Message: TWMKeyDown);
var
  IncAmount: Integer;
  CurrentItem: TBaseItem;

  procedure FixIncAmount(const StartValue: Integer);
  begin
    { Keep it within the bounds }
    if StartValue + IncAmount >= FButtonCategories.Count then
      IncAmount := FButtonCategories.Count - StartValue - 1
    else if StartValue + IncAmount < 0 then
      IncAmount := 0 - StartValue;
  end;

  function CalcRowsSeen: Integer;
  begin
    Result := ClientHeight div FButtonHeight;
  end;

  function GetNextItem(const StartIndex: Integer; SuggestedIndex: Integer): TButtonItem;
  var
    CatCount: Integer;
    I: Integer;
  begin
    Result := nil;
    for I := StartIndex to FButtonCategories.Count - 1 do
    begin
      CatCount := FButtonCategories[I].Items.Count;
      if CatCount > 0 then
      begin
        if SuggestedIndex >= CatCount then
          SuggestedIndex := CatCount - 1;
        Result := FButtonCategories[I].Items[SuggestedIndex];
        Break;
      end;
    end;
  end;

  function GetPriorItem(const StartIndex: Integer; Col: Integer): TBaseItem;
  var
    I: Integer;
    CatCount: Integer;
    Category: TButtonCategory;
    LastRow: Integer;
    ButtonsPerRow: Integer;
  begin
    Result := nil;
    ButtonsPerRow := CalcButtonsPerRow;
    for I := StartIndex downto 0 do
    begin
      Category := FButtonCategories[I];
      CatCount := Category.Items.Count;
      if CatCount > 0 then
      begin
        LastRow := CatCount div ButtonsPerRow - 1;
        if CatCount mod ButtonsPerRow <> 0 then
          Inc(LastRow);

        Col := Col + LastRow*ButtonsPerRow;

        if Col >= CatCount then
          Col := CatCount - 1;
        Result := Category.Items[Col];
        Break;
      end;
    end;
  end;

  function CalcActualButtonsPerRow(Category: TButtonCategory): Integer;
  var
    CatBounds: TRect;
  begin
    if FButtonFlow = cbfVertical then
      Result := CalcButtonsPerRow
    else
    begin
      CatBounds := Category.Bounds;
      Result := (CatBounds.Right - CatBounds.Left) div FButtonWidth;
      if Result = 0 then
        Result := 1;
    end;
  end;

  function GetNext(GoForward: Boolean; Distance: Integer = 0): TBaseItem;
  var
    ButtonsPerRow: Integer;
    Category: TButtonCategory;
  begin
    Result := nil;

    if (CurrentItem = nil) then
    begin
      if (Categories.Count > 0) then
        Result := Categories.Items[0];
      Exit;
    end;

    if CurrentItem is TButtonItem then
      Category := TButtonItem(CurrentItem).Category else
      Category := TButtonCategory(CurrentItem);

    ButtonsPerRow := CalcActualButtonsPerRow(Category);

    if Distance <= 0 then
      Distance := ButtonsPerRow;

    if CurrentItem is TButtonItem then
    begin
      if not Category.Collapsed then
      begin
        // Look for next or previous button first
        if GoForward then
          Result := CurrentItem.GetNextSibling(Distance) else
          Result := CurrentItem.GetPrevSibling(Distance);
      end;

      if (Result = nil) or Category.Collapsed then
      begin
        // If no button was found, try a category
        if GoForward then
          Result := Category.GetNextSibling else
          Result := Category;
      end
    end
    else if CurrentItem is TButtonCategory then
    begin
      if GoForward then
      begin
        if not Category.Collapsed and (Category.Items.Count > 0) then
          Result := Category.Items[0] as TBaseItem else
          Result := CurrentItem.GetNextSibling;
      end
      else
      begin
        Result := CurrentItem.GetPrevSibling;
        // Return the last button in the previous category if it isn't collapsed
        if (Result <> nil) and not TButtonCategory(Result).Collapsed and
          (TButtonCategory(Result).Items.Count > 0) then
          Result := TButtonCategory(Result).Items[TButtonCategory(Result).Items.Count - 1] as TBaseItem;
      end;
    end;
  end;

  function CtrlIsDown: Boolean;
  begin
    Result := ssCtrl in KeyboardStateToShiftState;
  end;

  function ChangePage(GoForward: Boolean): TBaseItem;
  var
    NewTop: Integer;
    NewCat: TButtonCategory;
    I: Integer;
    TempBounds, ButtonBounds: TRect;
    YInCat: Integer;
  begin
    NewTop := ClientHeight;
    if not GoForward then
      NewTop := NewTop * -1;

    if CurrentItem <> nil then
      NewTop := GetButtonRect(CurrentItem).Top + FScrollSize * FScrollBarPos + NewTop;

    if NewTop < 0 then
      NewTop := 0
    else if NewTop > FButtonCategories[FButtonCategories.Count-1].FEnd then
      NewTop := FButtonCategories[FButtonCategories.Count-1].FEnd - 1;

    { Find where this is at }
    NewCat := nil;
    for I := 0 to FButtonCategories.Count - 1 do
    begin
      if (FButtonCategories[I].Items.Count > 0) and
         (NewTop < FButtonCategories[I].FEnd) then
      begin
        NewCat := FButtonCategories[I];
        Break;
      end;
    end;

    if NewCat <> nil then
    begin
      GetCategoryBounds(NewCat, NewCat.FStart, TempBounds, ButtonBounds);
      if NewCat.Collapsed or (NewTop < ButtonBounds.Top) then
        Result := NewCat
      else
      begin
        { Find which button we would be on }
        YInCat := NewTop - ButtonBounds.Top + 1;
        if YInCat < 0 then
          YInCat := 0;
        I := (YInCat div FButtonHeight) * CalcButtonsPerRow;
        if YInCat mod FButtonHeight <> 0 then
          Inc(I);
        if I < 0 then
          I := 0
        else if I >= NewCat.Items.Count then
          I := NewCat.Items.Count - 1;
        Result := NewCat.Items[I];
      end;
    end
    else
      Result := nil;
  end;

var
  NewItem: TBaseItem;
  I: Integer;
begin
  CurrentItem := FSelectedItem;
  if (CurrentItem = nil) and (FFocusedItem <> nil) then
    CurrentItem := FFocusedItem;
  NewItem := nil;
  case Message.CharCode of
    VK_SUBTRACT:
      if CurrentItem is TButtonCategory then
        TButtonCategory(CurrentItem).Collapsed := True;
    VK_ADD:
      if CurrentItem is TButtonCategory then
        TButtonCategory(CurrentItem).Collapsed := False;
    VK_MULTIPLY:
      for I := 0 to Categories.Count - 1 do
        Categories[I].Collapsed := False;
    VK_DOWN:
      NewItem := GetNext(True);
    VK_UP:
      NewItem := GetNext(False);
    VK_LEFT:
      begin
        if (CurrentItem is TButtonItem) then
        begin
          if CtrlIsDown and not TButtonItem(CurrentItem).Category.Collapsed then
            TButtonItem(CurrentItem).Category.Collapsed := True
          else if CalcActualButtonsPerRow(TButtonItem(CurrentItem).Category) = 1 then
            NewItem := TButtonItem(CurrentItem).Category
          else
            NewItem := GetNext(False, 1);
        end
        else if CurrentItem is TButtonCategory then
          if not TButtonCategory(CurrentItem).Collapsed then
          begin
            TButtonCategory(CurrentItem).Collapsed := True;
            NewItem := CurrentItem;
          end
          else
            NewItem := GetNext(False, 1);
      end;
    VK_RIGHT:
      begin
        if (CurrentItem is TButtonItem) then
        begin
          if CtrlIsDown and TButtonItem(CurrentItem).Category.Collapsed then
            TButtonItem(CurrentItem).Category.Collapsed := False
          else
            NewItem := GetNext(True, 1)
        end
        else if CurrentItem is TButtonCategory then
          if TButtonCategory(CurrentItem).Collapsed then
            TButtonCategory(CurrentItem).Collapsed := False
          else
            NewItem := GetNext(True, 1);
      end;
    VK_NEXT: NewItem := ChangePage(True);
    VK_PRIOR: NewItem := ChangePage(False);
    VK_RETURN:
      if (CurrentItem is TButtonItem) then
      begin
        if TButtonItem(CurrentItem).Category.Collapsed then
          TButtonItem(CurrentItem).Category.Collapsed := False;
        SelectedItem := CurrentItem;
        DoItemClicked(CurrentItem)
      end;
    VK_HOME:
      if Categories.Count > 0 then
        NewItem := Categories[0];
    VK_END:
      if Categories.Count > 0 then
        begin
        NewItem := Categories[Categories.Count - 1];
        if not TButtonCategory(NewItem).Collapsed and
           (TButtonCategory(NewItem).Items.Count > 0) then
          NewItem := TButtonCategory(NewItem).Items[TButtonCategory(NewItem).Items.Count - 1];
      end;
  else
    inherited;
  end;
  if NewItem <> nil then
  begin
    UpdateButton(FHotButton);
    FHotButton := nil;
    SelectedItem := NewItem;
  end;
end;

procedure TCategoryButtons.ScrollIntoView(const BaseItem: TBaseItem);
begin
  if BaseItem is TButtonItem then
  begin
    if TButtonItem(BaseItem).Category.Collapsed then
      ScrollIntoView(TButtonItem(BaseItem).Category)
    else
      ScrollRectIntoView(BaseItem.Bounds, True);
  end
  else if BaseItem is TButtonCategory then
    ScrollRectIntoView(GetCategoryRect(TButtonCategory(BaseItem)), True);
end;

procedure TCategoryButtons.CMHintShow(var Message: TCMHintShow);
var
  CurrentItem: TButtonItem;
  CurrentCat: TButtonCategory;
  CatRect: TRect;
  Handled: Boolean;
  HintStr: string;
{$IF DEFINED(CLR)}
  LHintInfo: THintInfo;
{$ELSE}
  LHintInfo: PHintInfo;
{$IFEND}
begin
  Message.Result := 1; { Don't show the hint }
  if Message.HintInfo.HintControl = Self then
  begin
    with Message.HintInfo.CursorPos do
    begin
      CurrentCat := GetCategoryAt(X, Y);
      CurrentItem := GetButtonAt(X, Y, CurrentCat);
    end;

    Handled := False;
    HintStr := '';
    if Assigned(FOnGetHint) then
      FOnGetHint(Self, CurrentItem, CurrentCat, HintStr, Handled);
    LHintInfo := Message.HintInfo;
    if (CurrentItem <> nil) then
    begin
      if not Handled then
      begin
        if CurrentItem.Hint <> '' then
          HintStr := CurrentItem.Hint
        else
          HintStr := CurrentItem.Caption;
        if (CurrentItem.ActionLink <> nil) then
          CurrentItem.ActionLink.DoShowHint(HintStr);
      end;
      LHintInfo.CursorRect := GetButtonRect(CurrentItem);
      Handled := True;
    end
    else if (CurrentCat <> nil) then
    begin
      if not Handled then
        HintStr := CurrentCat.Caption;

      CatRect := GetCategoryRect(CurrentCat);
      if not CurrentCat.Collapsed then { exclude the button area on the right }
        CatRect.Right := CatRect.Left + FGutterSize;
      LHintInfo.CursorRect := CatRect;

      Handled := True;
    end;
    if Handled then
    begin
      LHintInfo.HintStr := HintStr;
      Message.Result := 0; { Show the hint }
    end;
{$IF DEFINED(CLR)}
    Message.HintInfo := LHintInfo;
{$IFEND}
  end;
end;

procedure TCategoryButtons.Assign(Source: TPersistent);
begin
  if Source is TCategoryButtons then
  begin
    Categories := TCategoryButtons(Source).Categories;
    ButtonHeight := TCategoryButtons(Source).ButtonHeight;
    ButtonWidth := TCategoryButtons(Source).ButtonWidth;
    ButtonOptions := TCategoryButtons(Source).ButtonOptions;
  end
  else
    inherited;
end;

procedure TCategoryButtons.SetInsertionButton(InsertionButton: TButtonItem;
  InsertionCategory: TButtonCategory);

  procedure UpdateAll;
  begin
    UpdateButton(FInsertTop);
    UpdateButton(FInsertLeft);
    UpdateButton(FInsertBottom);
    UpdateButton(FInsertRight);
    UpdateWindow(Handle);
  end;

  function CalcActualButtonsPerRow: Integer;
  var
    CatBounds, Temp: TRect;
  begin
    if FButtonFlow = cbfVertical then
      Result := CalcButtonsPerRow
    else
    begin
      GetCategoryBounds(InsertionCategory, 0, CatBounds, Temp);
      Result := (CatBounds.Right - CatBounds.Left) div FButtonWidth;
    end;
  end;

var
  ButtonsPerRow: Integer;

begin
  if (FDragCategory = nil) then
  begin
    ButtonsPerRow := CalcActualButtonsPerRow;
    if (InsertionButton = nil) and (InsertionCategory <> nil) and
       (InsertionCategory.Items.Count > 0) then
    begin
      { Appending a button to the current category }
      if FDragImageList.Dragging then
        FDragImageList.HideDragImage;
      RemoveInsertionPoints;
      InsertionButton := InsertionCategory.Items[InsertionCategory.Items.Count - 1];
      if ButtonsPerRow = 1 then
        FInsertBottom := InsertionButton
      else
        FInsertRight := InsertionButton;
      UpdateAll;
      if FDragImageList.Dragging then
        FDragImageList.ShowDragImage;
    end
    else if ((ButtonsPerRow = 1) and (FInsertTop <> InsertionButton)) or
        ((ButtonsPerRow > 1) and (FInsertLeft <> InsertionButton)) then
    begin
      if FDragImageList.Dragging then
        FDragImageList.HideDragImage;
      RemoveInsertionPoints;
      if ButtonsPerRow = 1 then
      begin
        FInsertTop := InsertionButton;
        FInsertBottom := GetNextButtonInGroup(InsertionButton, False);
      end
      else
      begin
        { More than one button per row, so use Left/Right separators }
        FInsertLeft := InsertionButton;
        FInsertRight := GetNextButtonInGroup(InsertionButton, False);
      end;
      UpdateAll;
      if FDragImageList.Dragging then
        FDragImageList.ShowDragImage;
    end;
  end;
end;

procedure TCategoryButtons.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited;
  FDragImageList.EndDrag;
  FDragButton := nil;
  FDragCategory := nil;
  RemoveInsertionPoints;
end;

procedure TCategoryButtons.ShareUpdateCategory(const Category: TButtonCategory);
var
  R: TRect;
begin
  if HandleAllocated then
  begin
    R := GetCategoryRect(Category);
    InvalidateRect(Handle, R, False);
  end;
end;

procedure TCategoryButtons.SetSelectedItem(const Value: TBaseItem);
var
  ButtonRect: TRect;
begin
  if FSelectedItem <> Value then
  begin
    if FFocusedItem <> Value then
      UpdateButton(FFocusedItem);

    if (FSelectedItem is TButtonItem) then
    begin
      UpdateButton(FSelectedItem);
      if TButtonItem(FSelectedItem).Category.Collapsed then
        ShareUpdateCategory(TButtonItem(FSelectedItem).Category)
    end;
    if Value <> nil then
    begin
      ButtonRect := Value.Bounds;
      if (Value is TButtonCategory) then
        AdjustCategoryBounds(TButtonCategory(Value), ButtonRect);
      ScrollRectIntoView(ButtonRect, False);
    end;
    FSelectedItem := Value;
    if Value <> nil then
      FFocusedItem := Value;
    if FSelectedItem <> nil then
    begin
      UpdateButton(FSelectedItem);
      if (FSelectedItem is TButtonItem) and (FSelectedItem as TButtonItem).Category.Collapsed then
        ShareUpdateCategory((FSelectedItem as TButtonItem).Category);
    end;
    if not (csDestroying in ComponentState) then
      DoSelectedItemChanged(FSelectedItem);
  end;
end;

function TCategoryButtons.GetIndexOfFirstCategory: Integer;
var
  TopPos: Integer;
  CatIndex: Integer;
begin
  Result := -1;
  TopPos := GetScrollOffset;
  { Avoid drawing hidden categories }
  for CatIndex := 0 to FButtonCategories.Count - 1 do
  begin
    if FButtonCategories[CatIndex].FEnd >= TopPos then
    begin
      Result := CatIndex;
      Exit;
    end;
  end;
end;

function TCategoryButtons.GetCategoryAt(X, Y: Integer): TButtonCategory;
var
  I: Integer;
  CurrentPos: Integer;
begin
  Result := nil;
  { Is it within our X and Y bounds first? }
  if (X >= 0) and (X < Width) and (Y >= 0) and (Y < Height) then
  begin
    { It is, so translate the X or Y position to our virtual system }
    if FButtonFlow = cbfVertical then
      CurrentPos := Y + GetScrollOffset
    else
      CurrentPos := X + GetScrollOffset;
    { Find out which category this X or Y position would lie in }
    for I := 0 to FButtonCategories.Count - 1 do
    begin
      if CurrentPos <= FButtonCategories[I].FEnd then
      begin
        Result := FButtonCategories[I];
        Break;
      end;
    end;
  end;
end;

procedure TCategoryButtons.ScrollRectIntoView(const Rect: TRect; PlaceOnTop: Boolean = False);
var
  Amount: Integer;

  procedure CalcAmount(const ScrollPixels: Integer; AdjustForPartial: Boolean = True);
  begin
    Amount := ScrollPixels div FScrollSize;
    if AdjustForPartial and (Abs(ScrollPixels mod FScrollSize) > 3) then
      Inc(Amount);
  end;

var
  RectStart, RectEnd, MaxSize: Integer;
begin
  if FButtonFlow = cbfVertical then
  begin
    RectStart := Rect.Top;
    RectEnd := Rect.Bottom;
    MaxSize := ClientHeight;
  end
  else
  begin
    RectStart := Rect.Left;
    RectEnd := Rect.Right;
    MaxSize := ClientWidth;
  end;

  if RectStart < 0 then
  begin
    // Scrolling down into view
    CalcAmount(-1 * RectStart);
    if FScrollBarPos - Amount < 0 then
      Amount := FScrollBarPos;
    ScrollPosChanged(scPosition, FScrollBarPos - Amount);
  end
  else if (RectStart > MaxSize) or (RectEnd > MaxSize) then
  begin
    // Scrolling up into view
    if (RectEnd - RectStart > MaxSize) or PlaceOnTop then
      CalcAmount(RectStart, False) { Put the start into view at the top}
    else
      CalcAmount(RectEnd - MaxSize); { Put the whole thing into view at the bottom }

    if FScrollBarPos + Amount > FScrollBarMax then
      ScrollPosChanged(scPosition, FScrollBarMax)
    else
      ScrollPosChanged(scPosition, FScrollBarPos + Amount);
  end;
end;

function TCategoryButtons.GetCategoryRect(const Category: TButtonCategory;
  ButtonOnly: Boolean = False): TRect;
var
  YPos: Integer;
  ButtonBounds: TRect;
begin
  Result := Rect(0, 0, 0, 0);
  YPos := Category.FStart - GetScrollOffset;
  GetCategoryBounds(Category, YPos, Result, ButtonBounds);
  if ButtonOnly then
    AdjustCategoryBounds(Category, Result);
end;

function TCategoryButtons.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
var
  NextButton: TBaseItem;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);
  if not Result then
  begin
    UpdateButton(FHotButton);
    FHotButton := nil;
    Result := True;
    if (FScrollBarMax > 0) and (Shift = []) then
      ScrollPosChanged(scLineUp, 0)
    else if (FScrollBarMax > 0) and (ssCtrl in Shift) then
      ScrollPosChanged(scPageUp, 0)
    else if ssShift in Shift then
    begin
      NextButton := GetNextButton(SelectedItem, False);
      if NextButton <> nil then
        SelectedItem := NextButton;
    end;
  end;
end;

function TCategoryButtons.GetNextButton(const StartingButton: TBaseItem;
  GoForward: Boolean): TBaseItem;

  function ProcessCategory(const Category: TButtonCategory): TButtonItem;
  begin
    if (not Category.Collapsed) and (Category.Items.Count > 0) then
      if GoForward then
        Result := Category.Items[0]
      else
        Result := Category.Items[Category.Items.Count - 1]
    else
      Result := nil;
  end;

var
  I: Integer;
begin
  if StartingButton <> nil then
  begin
    Result := GetNextButtonInGroup(StartingButton, GoForward);
    if Result = nil then
    begin
      if GoForward then
      begin
        for I := (StartingButton as TButtonItem).Category.Index + 1 to FButtonCategories.Count -1 do
        begin
          Result := ProcessCategory(FButtonCategories[I]);
          if Result <> nil then
            Break;
        end
      end
      else
      begin
        for I := (StartingButton as TButtonItem).Category.Index - 1 downto 0 do
        begin
          Result := ProcessCategory(FButtonCategories[I]);
          if Result <> nil then
            Break;
        end
      end;
    end;
  end
  else
    Result := nil;
end;

function TCategoryButtons.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
var
  NextButton: TBaseItem;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    UpdateButton(FHotButton);
    FHotButton := nil;
    Result := True;
    if (FScrollBarMax > 0) and (Shift = []) then
      ScrollPosChanged(scLineDown, 0)
    else if (FScrollBarMax > 0) and (ssCtrl in Shift) then
      ScrollPosChanged(scPageDown, 0)
    else if ssShift in Shift then
    begin
      NextButton := GetNextButton(SelectedItem, True);
      if NextButton <> nil then
        SelectedItem := NextButton;
    end;
  end;
end;

procedure TCategoryButtons.DoReorderCategory(const SourceCategory,
  TargetCategory: TButtonCategory);
begin
  if TargetCategory = nil then
    SourceCategory.Index := FButtonCategories.Count - 1
  else
    SourceCategory.Index := TargetCategory.Index;
end;

function TCategoryButtons.GetScrollBuffer: Integer;
begin
  Result := FScrollSize * 2;
  if Result < 6 then
    Result := 6;
end;

procedure TCategoryButtons.SetFocusedItem(const Value: TBaseItem);
begin
  if FFocusedItem <> Value then
  begin
    FFocusedItem := Value;
    Invalidate;
  end;
end;

procedure TCategoryButtons.DoSelectedItemChanged(
  const Button: TBaseItem);
begin
  if Assigned(FOnSelectedItemChange) then
    FOnSelectedItemChange(Self, TButtonItem(Button));
end;

procedure TCategoryButtons.DoCopyButton(const Button: TButtonItem;
  const TargetCategory: TButtonCategory; const TargetButton: TButtonItem);
var
  CopiedButton: TButtonItem;
begin
  CopiedButton := TargetCategory.Items.Add;
  if TargetButton <> nil then
    CopiedButton.Index := TargetButton.Index;
  CopiedButton.Assign(Button);

  if Assigned(FOnCopyButton) then
    FOnCopyButton(Self, Button, CopiedButton);
end;

procedure TCategoryButtons.SetHotButtonColor(const Value: TColor);
begin
  if FHotButtonColor <> Value then
  begin
    FHotButtonColor := Value;
    Invalidate;
  end;
end;

procedure TCategoryButtons.SetRegularButtonColor(const Value: TColor);
begin
  if FRegularButtonColor <> Value then
  begin
    FRegularButtonColor := Value;
    Invalidate;
  end;
end;

procedure TCategoryButtons.SetSelectedButtonColor(const Value: TColor);
begin
  if FSelectedButtonColor <> Value then
  begin
    FSelectedButtonColor := Value;
    Invalidate;
  end;
end;

procedure TCategoryButtons.SetButtonFlow(const Value: TCatButtonFlow);
var
  OldFlow: TCatButtonFlow;
begin
  if FButtonFlow <> Value then
  begin
    OldFlow := FButtonFlow;
    FButtonFlow := Value; { Set the flow }
    CalcBufferSizes;
    FScrollBarPos := 0; { Nothing scrolled }
    { Hide the previous scroll bar, if shown, which will cause a resize }
    if FScrollBarShown then
    begin
      FScrollBarShown := False;
      Windows.ShowScrollBar(Handle, cScrollBarKind[OldFlow], False);
    end
    else
    begin
      { We have to resize }
      Resize;
      Invalidate;
    end;
  end;
end;

procedure TCategoryButtons.SetGradientDirection(
  const Value: TGradientDirection);
begin
  if FGradientDirection <> Value then
  begin
    FGradientDirection := Value;
    Invalidate;
  end;
end;

procedure TCategoryButtons.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if not (csDestroying in ComponentState) then
    UpdateButton(FFocusedItem);
end;

procedure TCategoryButtons.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  UpdateButton(FFocusedItem);
end;

procedure TCategoryButtons.CMFontchanged(var Message: TMessage);
begin
  inherited;
  CalcBufferSizes;
  Invalidate;
end;

function TCategoryButtons.GetButtonCategoriesClass: TButtonCategoriesClass;
begin
  Result := TButtonCategories;
end;

function TCategoryButtons.GetButtonCategoryClass: TButtonCategoryClass;
begin
  Result := TButtonCategory;
end;

function TCategoryButtons.GetButtonItemClass: TButtonItemClass;
begin
  Result := TButtonItem;
end;

procedure TCategoryButtons.SetDragButton(const Value: TButtonItem);
begin
  FDragButton := Value;
  FDragStarted := True;
  FDragStartPos := ScreenToClient(Mouse.CursorPos);
end;

procedure TCategoryButtons.DoBeginDrag(Immediate: Boolean; Threshold: Integer);
begin
  BeginDrag(Immediate, Threshold);
end;

function TCategoryButtons.GetAllowReorder: Boolean;
begin
  Result := boAllowReorder in ButtonOptions;
end;

procedure TCategoryButtons.SetBackgroundGradientColor(const Value: TColor);
begin
  if FBackgroundGradientColor <> Value then
  begin
    FBackgroundGradientColor := Value;
    Invalidate;
  end;
end;

procedure TCategoryButtons.SetBackGradientDirection(
  const Value: TGradientDirection);
begin
  if FBackGradientDirection <> Value then
  begin
    FBackGradientDirection := Value;
    Invalidate;
  end;
end;

function TCategoryButtons.GetScrollPos: Integer;
begin
  Result := FScrollBarPos;
end;

procedure TCategoryButtons.SetScrollPos(const Value: Integer);
begin
  if FScrollBarPos <> Value then
  begin
    FScrollBarPos := Value;
    if Categories.UpdateCount = 0 then
      Resize;
  end;
end;

{ TBaseButtonItem }

procedure TBaseButtonItem.ActionChange(Sender: TObject;
  CheckDefaults: Boolean);
begin
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.Caption = '') then
        Self.Caption := Caption;
      if not CheckDefaults or (Self.Hint = '') then
        Self.Hint := Hint;
      if not CheckDefaults or (Self.ImageIndex = -1) then
        Self.ImageIndex := ImageIndex;
      if not CheckDefaults or not Assigned(Self.OnClick) then
        Self.OnClick := OnExecute;
    end;
end;

procedure TBaseButtonItem.Assign(Source: TPersistent);
begin
  if Source is TBaseButtonItem then
  begin
    Caption := TBaseButtonItem(Source).Caption;
    ImageIndex := TBaseButtonItem(Source).ImageIndex;
    Hint := TBaseButtonItem(Source).Hint;
    Data := TBaseButtonItem(Source).Data;
  end
  else
    inherited Assign(Source);
end;

constructor TBaseButtonItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FImageIndex := -1;
end;

destructor TBaseButtonItem.Destroy;
begin
  if FActionLink <> nil then
    FActionLink.Free;
  inherited;
end;

procedure TBaseButtonItem.DoActionChange(Sender: TObject);
begin
  if Sender = Action then ActionChange(Sender, False);
end;

function TBaseButtonItem.GetAction: TBasicAction;
begin
  if ActionLink <> nil then
    Result := ActionLink.Action
  else
    Result := nil;
end;

function TBaseButtonItem.GetActionLinkClass: TButtonItemActionLinkClass;
begin
  Result := TButtonItemActionLink;
end;

function TBaseButtonItem.GetBounds: TRect;
begin
  Result := Rect(-1, -1, -1, -1);
end;

function TBaseButtonItem.GetDisplayName: string;
begin
  Result := Caption;
  if Result = '' then
    Result := inherited GetDisplayName;
end;

function TBaseButtonItem.IsCaptionStored: Boolean;
begin
  Result := (ActionLink = nil) or not ActionLink.IsCaptionLinked;
end;

function TBaseButtonItem.IsHintStored: Boolean;
begin
  Result := (ActionLink = nil) or not ActionLink.IsHintLinked;
end;

function TBaseButtonItem.IsImageIndexStored: Boolean;
begin
  Result := (FImageIndex <> -1) and ((ActionLink = nil) or not ActionLink.IsImageIndexLinked);
end;

function TBaseButtonItem.IsOnClickStored: Boolean;
begin
  Result := (ActionLink = nil) or not ActionLink.IsOnExecuteLinked;
end;

procedure TBaseButtonItem.SetAction(const Value: TBasicAction);
begin
  if Value = nil then
  begin
    ActionLink.Free;
    ActionLink := nil;
  end
  else
  begin
    if ActionLink = nil then
      ActionLink := GetActionLinkClass.Create(Self);
    ActionLink.Action := Value;
    ActionLink.OnChange := DoActionChange;
    ActionChange(Value, csLoading in Value.ComponentState);
    Value.FreeNotification(GetNotifyTarget);
  end;
end;

procedure TBaseButtonItem.SetImageIndex(const Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Changed(False);
  end;
end;

procedure TBaseButtonItem.SetXImageIndex(const Value: TImageIndex);
begin
  if FXImageIndex <> Value then
  begin
    FXImageIndex := Value;
    Changed(False);
  end;
end;

procedure TBaseButtonItem.SetCImageIndex(const Value: TImageIndex);
begin
  if FCImageIndex <> Value then
  begin
    FCImageIndex := Value;
    Changed(False);
  end;
end;

{ TButtonItem }

procedure TButtonItem.Assign(Source: TPersistent);
begin
  if Source is TButtonItem then
  begin
    inherited Assign(Source);
    InterfaceData := TButtonItem(Source).InterfaceData;
  end
  else
    inherited Assign(Source);
end;

function TButtonItem.GetBounds: TRect;
begin
  if (Category = nil) or Category.Collapsed then
    Result := Rect(-1, -1, -1, -1)
  else
    Result := ButtonGroup.GetButtonRect(Self);
end;

function TButtonItem.GetButtonGroup: TCategoryButtons;
begin
  Result := nil;
  if Category <> nil then
  Result := Category.Categories.ButtonGroup;
end;

function TButtonItem.GetCategory: TButtonCategory;
begin
  Result := nil;
  if Collection <> nil then
  Result := TButtonCollection(Collection).Category;
end;

function TButtonItem.GetNotifyTarget: TComponent;
begin
  Result := TComponent(ButtonGroup);
end;

procedure TButtonItem.ScrollIntoView;
begin
  ButtonGroup.ScrollIntoView(Self);
end;

{ TButtonCollection }

function TButtonCollection.Add: TButtonItem;
begin
  Result := TButtonItem(inherited Add);
end;

function TButtonCollection.AddItem(Item: TButtonItem;
  Index: Integer): TButtonItem;
begin
  if Item = nil then
    Result := FCategory.Categories.ButtonGroup.GetButtonItemClass.Create(Self)
  else
    Result := Item;
  if Assigned(Result) then
  begin
    Result.Collection := Self;
    if Index < 0 then
      Index := Count - 1;
    Result.Index := Index;
  end;
end;

constructor TButtonCollection.Create(const ACategory: TButtonCategory);
begin
  inherited Create(ACategory.Categories.ButtonGroup.GetButtonItemClass);
  FCategory := ACategory;
end;

function TButtonCollection.GetItem(Index: Integer): TButtonItem;
begin
  Result := TButtonItem(inherited GetItem(Index));
end;

function TButtonCollection.GetOwner: TPersistent;
begin
  Result := FCategory;
end;

function TButtonCollection.Insert(Index: Integer): TButtonItem;
begin
  Result := AddItem(nil, Index);
end;

procedure TButtonCollection.Notify(Item: TCollectionItem; Action: TCollectionNotification);
var
  ButtonGroup: TCategoryButtons;
begin
  if (Action in [cnDeleting, cnExtracting]) and (FCategory <> nil) then
  begin
    ButtonGroup := FCategory.Categories.ButtonGroup;
    if not (csDestroying in ButtonGroup.ComponentState) then
    begin
      if Item = ButtonGroup.FDownButton then
        ButtonGroup.FDownButton := nil;
      if Item = ButtonGroup.FDragButton then
        ButtonGroup.FDragButton := nil;
      if Item = ButtonGroup.FHotButton then
        Buttongroup.FHotButton := nil;
      if Item = ButtonGroup.FFocusedItem then
        ButtonGroup.FFocusedItem := nil;
      if Item = ButtonGroup.FSelectedItem then
        ButtonGroup.SelectedItem := nil;
    end;
  end;
  inherited;
end;

procedure TButtonCollection.SetItem(Index: Integer; const Value: TButtonItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TButtonCollection.Update(Item: TCollectionItem);
var
  ButtonGroup: TCategoryButtons;
begin
  inherited;
  if (UpdateCount = 0) and (FCategory.Categories.UpdateCount = 0) then
  begin
    ButtonGroup := FCategory.Categories.ButtonGroup;
    if not ButtonGroup.FIgnoreUpdate then
    begin
      if Item <> nil then
        ButtonGroup.UpdateButton(Item as TButtonItem)
      else
      begin
        ButtonGroup.Resize;
        ButtonGroup.UpdateAllButtons;
      end;
    end;
  end;
end;

{ TButtonCategories }

function TButtonCategories.Add: TButtonCategory;
begin
  Result := TButtonCategory(inherited Add);
end;

function TButtonCategories.AddItem(Item: TButtonCategory;
  Index: Integer): TButtonCategory;
begin
  if Item = nil then
    Result := FButtonGroup.GetButtonCategoryClass.Create(Self)
  else
    Result := Item;
  if Assigned(Result) then
  begin
    Result.Collection := Self;
    if Index < 0 then
      Index := Count - 1;
    Result.Index := Index;
  end;
end;

procedure TButtonCategories.BeginUpdate;
begin
  if UpdateCount = 0 then
    if FButtonGroup.SelectedItem <> nil then
      FOriginalID := FButtonGroup.SelectedItem.ID
    else
      FOriginalID := -1;
  inherited;
end;

constructor TButtonCategories.Create(const ButtonGroup: TCategoryButtons);
begin
  inherited Create(ButtonGroup.GetButtonCategoryClass);
  FButtonGroup := ButtonGroup;
  FOriginalID := -1;  
end;

function TButtonCategories.GetItem(Index: Integer): TButtonCategory;
begin
  Result := TButtonCategory(inherited GetItem(Index));
end;

function TButtonCategories.GetOwner: TPersistent;
begin
  Result := FButtonGroup;
end;

function TButtonCategories.GetVisibleCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
  begin
    Inc(Result);
    if not Items[I].Collapsed then
      Inc(Result, Items[I].Items.Count);
  end;
end;

function TButtonCategories.IndexOf(const Caption: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  // First attempt a case sensitive match
  for I := 0 to Count - 1 do
  begin
    if AnsiSameStr(Items[I].Caption, Caption) then
    begin
      Result := I;
      Exit;
    end;
  end;
  // Then fallback to case insensitive
  for I := 0 to Count - 1 do
  begin
    if AnsiSameText(Items[I].Caption, Caption) then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

function TButtonCategories.Insert(Index: Integer): TButtonCategory;
begin
  Result := AddItem(nil, Index);
end;

function TButtonCategories.ItemAt(const Index: Integer): TBaseItem;
var
  I: Integer;
  ItemCount: Integer;
begin
  Result := nil;
  ItemCount := -1;
  for I := 0 to Count - 1 do
  begin
    Inc(ItemCount);
    if ItemCount = Index then
    begin
      Result := Items[I];
      break;
    end;
    if Items[I].Collapsed then
      continue
    else
      Inc(ItemCount, Items[I].Items.Count);
    if Index <= ItemCount then
    begin
      Result := Items[I].Items[Index - (ItemCount - Items[I].Items.Count + 1)];
      break;
    end;
  end;
end;

function TButtonCategories.ItemIndex(const Caption: string): Integer;
var
  CatBasedIndex, I: Integer;
  Item: TBaseItem;
begin
  Result := -1;
  // Always look for an item first in the currently selected category
  if ButtonGroup.CurrentCategory <> nil then
  begin
    CatBasedIndex := ButtonGroup.CurrentCategory.IndexOf(Caption);
    if CatBasedIndex <> -1 then
    begin
      Item := ButtonGroup.CurrentCategory.Items[CatBasedIndex];
      // Need to convert from category based index to absolute index
      for I := 0 to VisibleCount - 1 do
      begin
        if ItemAt(I) = Item then
        begin
          Result := I;
          Exit;
        end;
      end;
    end;
  end;
  // Next attempt a case sensitive match scanning through all visible items
  for I := 0 to VisibleCount - 1 do
  begin
    Item := ItemAt(I);
    if AnsiSameStr(Item.Caption, Caption) then
    begin
      Result := I;
      Exit;
    end;
  end;
  // Then fallback to case insensitive
  for I := 0 to VisibleCount - 1 do
  begin
    Item := ItemAt(I);
    if AnsiSameText(Item.Caption, Caption) then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

procedure TButtonCategories.Notify(Item: TCollectionItem; Action: TCollectionNotification);
begin
  if (Action in [cnDeleting, cnExtracting]) and (FButtonGroup <> nil) and
     not (csDestroying in FButtonGroup.ComponentState) then
  begin
    if Item = ButtonGroup.FFocusedItem then
      ButtonGroup.FFocusedItem := nil;
    if Item = ButtonGroup.FSelectedItem then
      ButtonGroup.SelectedItem := nil;
  end;
  inherited;
end;

procedure TButtonCategories.SetItem(Index: Integer;
  const Value: TButtonCategory);
begin
  inherited SetItem(Index, Value);
end;

function TButtonCategories.GetUpdateCount: Integer;
begin
  Result := inherited UpdateCount;
end;

procedure TButtonCategories.Update(Item: TCollectionItem);
begin
  inherited; 
  if (UpdateCount = 0) and (not FButtonGroup.FIgnoreUpdate) then
  begin
    FButtonGroup.Resize;
    FButtonGroup.UpdateAllButtons;
  end;
end;

{ TButtonCategory }
var
  GLastPreset: Integer = 0;

procedure TButtonCategory.Assign(Source: TPersistent);
begin
  if Source is TButtonCategory then
  begin
    Caption := TButtonCategory(Source).Caption;
    Color := TButtonCategory(Source).Color;
    GradientColor := TButtonCategory(Source).GradientColor;
    TextColor := TButtonCategory(Source).TextColor;
    Collapsed := TButtonCategory(Source).Collapsed;
    Data := TButtonCategory(Source).Data;
    InterfaceData := TButtonCategory(Source).InterfaceData;
  end
  else
    inherited Assign(Source);
end;

constructor TButtonCategory.Create(Collection: TCollection);
const
  cMaxPresets = 10;
  cPresetColors: array[0..cMaxPresets-1] of TColor = ($00FFEAFF, $00F4F4F4, $00EAEBFF,
    $00FFEAFF, $00FFEAEA, $00EAFFFF, $00FFFFEA, $00EAEBFF, $00EBFFEA, $00FFEAEA);
begin
  inherited Create(Collection);
  FGradientColor := clNone;
  FTextColor := clWindowText;
  FItems := TButtonCollection.Create(Self);
  with TButtonCategories(Collection).ButtonGroup do
    FColor := cPresetColors[GLastPreset];
  Inc(GLastPreset);
  if GLastPreset >= cMaxPresets then
    GLastPreset := 0;
end;

destructor TButtonCategory.Destroy;
begin
  if FItems <> nil then
    FItems.Clear;
  inherited;
  FreeAndNil(FItems);
end;

function TButtonCategory.GetBounds: TRect;
begin
  Result := GetButtonRect(False);
end;

function TButtonCategory.GetButtonRect(ButtonOnly: Boolean): TRect;
begin
  if (Categories = nil) or (FItems = nil) then
    Result := Rect(-1,-1,-1,-1)
  else
    Result := Categories.ButtonGroup.GetCategoryRect(Self, ButtonOnly);
end;

function TButtonCategory.GetCategories: TButtonCategories;
begin
  Result := TButtonCategories(Collection);
end;

function TButtonCategory.IndexOf(const Caption: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  // First attempt a case sensitive match
  for I := 0 to Items.Count - 1 do
  begin
    if AnsiSameStr(Items[I].Caption, Caption) then
    begin
      Result := I;
      Exit;
    end;
  end;
  // Then fallback to case insensitive
  for I := 0 to Items.Count - 1 do
  begin
    if AnsiSameText(Items[I].Caption, Caption) then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

procedure TButtonCategory.ScrollIntoView;
begin
  Categories.ButtonGroup.ScrollIntoView(Self);
end;

procedure TButtonCategory.SetCollapsed(const Value: Boolean);
begin
  if FCollapsed <> Value then
  begin
    FCollapsed := Value;
    Changed(True);
    if not FCollapsed then
      ScrollIntoView;
    if Assigned(Categories.ButtonGroup.OnCategoryCollapase) then
      Categories.ButtonGroup.OnCategoryCollapase(Categories.ButtonGroup, Self);
  end;
end;

procedure TButtonCategory.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed(False);
  end;
end;

procedure TButtonCategory.SetGradientColor(const Value: TColor);
begin
  if FGradientColor <> Value then
  begin
    FGradientColor := Value;
    Changed(False);
  end;
end;

procedure TButtonCategory.SetIndex(Value: Integer);
var
  TargetCategory: TButtonCategory;
begin
  if Value <> Index then
  begin
    if Index < Categories.Count then
      TargetCategory := Categories[Value]
    else
      TargetCategory := nil;
    inherited;
    ScrollIntoView;
    if Assigned(Categories.ButtonGroup.FOnReorderCategory) then
      Categories.ButtonGroup.FOnReorderCategory(Categories.ButtonGroup,
        Self, TargetCategory);
  end;
end;

procedure TButtonCategory.SetItems(const Value: TButtonCollection);
begin
  FItems.Assign(Value);
end;

procedure TButtonCategory.SetTextColor(const Value: TColor);
begin
  if FTextColor <> Value then
  begin
    FTextColor := Value;
    Changed(False);
  end;
end;

{ TButtonItemActionLink }

procedure TButtonItemActionLink.AssignClient(AClient: TObject);
begin
  FClient := AClient as TBaseButtonItem;
end;

function TButtonItemActionLink.DoShowHint(var HintStr: string): Boolean;
begin
  Result := True;
  if Action is TCustomAction then
    TCustomAction(Action).DoHint(HintStr);
end;

function TButtonItemActionLink.IsCaptionLinked: Boolean;
begin
  Result := inherited IsCaptionLinked and
    (FClient.Caption = (Action as TCustomAction).Caption);
end;

function TButtonItemActionLink.IsHintLinked: Boolean;
begin
  Result := inherited IsHintLinked and
    (FClient.Hint = (Action as TCustomAction).Hint);
end;

function TButtonItemActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
    (FClient.ImageIndex = (Action as TCustomAction).ImageIndex);
end;

function TButtonItemActionLink.IsOnExecuteLinked: Boolean;
begin
  Result := inherited IsOnExecuteLinked and
    (((not Assigned(FClient.OnClick)) and (not Assigned(Action.OnExecute))) or
     (Assigned(FClient.OnClick) and
      DelegatesEqual(@FClient.OnClick, @Action.OnExecute)));
end;

procedure TButtonItemActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then FClient.Caption := Value;
end;

procedure TButtonItemActionLink.SetHint(const Value: string);
begin
  if IsHintLinked then FClient.Hint := Value;
end;

procedure TButtonItemActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then FClient.ImageIndex := Value;
end;

procedure TButtonItemActionLink.SetOnExecute(Value: TNotifyEvent);
begin
  if IsOnExecuteLinked then FClient.OnClick := Value;
end;

{ TBaseItem }

function TBaseItem.GetFirstSibling: TBaseItem;
begin
  Result := Collection.Items[0] as TBaseItem;
end;

function TBaseItem.GetLastSibling: TBaseItem;
begin
  Result := Collection.Items[Collection.Count - 1] as TBaseItem;
end;

function TBaseItem.GetNextSibling(Distance: Integer): TBaseItem;
begin
  Result := nil;
  if Distance = 0 then
    Distance := 1;
  if Index + Distance < Collection.Count then
    Result := Collection.Items[Index + Distance] as TBaseItem;
end;

function TBaseItem.GetPrevSibling(Distance: Integer): TBaseItem;
begin
  Result := nil;
  if Distance = 0 then
    Distance := 1;
  if Index - Distance >= 0 then
    Result := Collection.Items[Index - Distance] as TBaseItem;
end;

function TBaseItem.IsCaptionStored: Boolean;
begin
  Result := True;
end;

procedure TBaseItem.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed(False);
  end;
end;

{ TItemCollection }

procedure TItemCollection.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
var
  Buttons: TCategoryButtons;
begin
  inherited;
  if Action in [cnDeleting, cnExtracting] then
  begin
    if Item is TButtonItem then
      Buttons := TButtonItem(Item).ButtonGroup
    else
      Buttons := TButtonCategory(Item).Categories.ButtonGroup;
    if Buttons.SelectedItem = Item then
    begin
      Buttons.SelectedItem := nil;
      Buttons.FocusedItem := nil;
    end;
  end;
end;

{$IF NOT DEFINED(CLR)}
initialization
  { Add our drag/copy cursor image }
  Screen.Cursors[crDragCopy] := LoadCursor(HInstance, 'CAT_DRAG_COPY'); { Do not localize }
finalization
  { Free the drag/copy cursor image }
  DestroyCursor(Screen.Cursors[crDragCopy]);
{$IFEND}

end.

