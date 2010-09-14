﻿// Изменения для проекта IMadering

{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2010 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit CategoryButtons;

interface

{$WARN UNIT_PLATFORM OFF}

uses

{$IF DEFINED(CLR)}

  WinUtils,

{$IFEND}

  Windows,
  Messages,
  SysUtils,
  Classes,
  ImgList,
  Forms,
  Controls,
  Graphics,
  StdCtrls,
  GraphUtil,
  ActnList;

{ const
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
  TItemCollection = class;

  { TCategoryButtons }

  TButtonDrawState = set of (BdsSelected, // Item is selected and in the "down" state
    BdsHot, // Item has the mouse over it
    BdsFocused, // Item should show focus
    BdsDown, // Item is being pressed by the user
    BdsDragged, // The drag image for that button is being drawn
    BdsInsertLeft, // Show that an item can be inserted to the left of this item
    BdsInsertTop, // Show that an item can be inserted above this item
    BdsInsertRight, // Show that an item can be inserted to the right of this item
    BdsInsertBottom // Show that an item can be inserted below this item
    );

  TCatButtonFlow = (CbfVertical, CbfHorizontal);

  TCatButtonOptions = set of (BoAllowReorder, BoAllowCopyingButtons, BoFullSize, BoGradientFill, BoShowCaptions, BoVerticalCategoryCaptions, BoBoldCaptions, BoUsePlusMinus, BoCaptionOnlyBorder);

  TCatButtonEvent = procedure(Sender: TObject; const Button: TButtonItem) of object;
  TCatButtonCategoryEvent = procedure(Sender: TObject; const Category: TButtonCategory) of object;
  TCatButtonGetHint = procedure(Sender: TObject; const Button: TButtonItem; const Category: TButtonCategory; var HintStr: string; var Handled: Boolean) of object;

  TCatButtonDrawEvent = procedure(Sender: TObject; const Button: TButtonItem; Canvas: TCanvas; Rect: TRect; State: TButtonDrawState) of object;
  TCatButtonDrawIconEvent = procedure(Sender: TObject; const Button: TButtonItem; Canvas: TCanvas; Rect: TRect; State: TButtonDrawState; var TextOffset: Integer) of object;
  TCatButtonReorderEvent = procedure(Sender: TObject; const Button: TButtonItem; const SourceCategory, TargetCategory: TButtonCategory) of object;
  TCatButtonCopyEvent = procedure(Sender: TObject; const SourceButton, CopiedButton: TButtonItem) of object;

  TCatButtonEditingEvent = procedure(Sender: TObject; Item: TBaseItem; var AllowEdit: Boolean) of object;
  TCatButtonEditedEvent = procedure(Sender: TObject; Item: TBaseItem; var S: string) of object;
  TCatButtonCancelEditEvent = procedure(Sender: TObject; const Item: TBaseItem) of object;

  TCategoryReorderEvent = procedure(Sender: TObject; const SourceCategory, TargetCategory: TButtonCategory) of object;
  TCategoryCollapseEvent = procedure(Sender: TObject; const Category: TButtonCategory) of object;

  TCategoryButtons = class(TCustomControl)

{$IF DEFINED(CLR)}

  strict private
    class var FCursorHandle: TSafeCursorHandle;
    class constructor Create;

{$IFEND}

  strict private
    FButtonFlow: TCatButtonFlow;
    FCollapsedHeight: Integer;
    FDownButton: TButtonItem;
    // FDragButton: TButtonItem;
    FHotButton: TButtonItem;
    // FDragCategory: TButtonCategory;
    // FDragStartPos: TPoint;
    // FDragStarted: Boolean;
    // FDragImageList: TDragImageList;
    FGradientDirection: TGradientDirection;
    FBackGradientDirection: TGradientDirection;
    FGutterSize: Integer;
    FScrollSize: Integer;
    FSideBufferSize: Integer;
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
    FScrollBarShown: Boolean;
    FBackgroundGradientColor: TColor;
    FHotButtonColor: TColor;
    FSelectedButtonColor: TColor;
    FRegularButtonColor: TColor;
    FInplaceEdit: TCustomEdit;
    FPanPoint: TPoint;

    FOnButtonClicked: TCatButtonEvent;
    FOnCategoryClicked: TCatButtonCategoryEvent;
    FOnCopyButton: TCatButtonCopyEvent;
    FOnSelectedButtonChange: TCatButtonEvent;
    FOnSelectedCategoryChange: TCatButtonCategoryEvent;
    FOnHotButton: TCatButtonEvent;
    FOnGetHint: TCatButtonGetHint;
    FOnDrawIcon: TCatButtonDrawIconEvent;
    FOnDrawText: TCatButtonDrawEvent;
    FOnDrawButton: TCatButtonDrawEvent;
    FOnBeforeDrawButton: TCatButtonDrawEvent;
    FOnAfterDrawButton: TCatButtonDrawEvent;
    FOnReorderButton: TCatButtonReorderEvent;
    FOnEditing: TCatButtonEditingEvent;
    FOnEdited: TCatButtonEditedEvent;
    FOnCancelEdit: TCatButtonCancelEditEvent;
    FOnReorderCategory: TCategoryReorderEvent;
    FOnCategoryCollapase: TCategoryCollapseEvent;

    procedure AdjustCategoryBounds(const Category: TButtonCategory; var CategoryBounds: TRect; IgnoreButtonFlow: Boolean = False);
    // procedure AutoScroll(ScrollCode: TScrollCode);
    function CalcButtonsPerRow: Integer;
    function CalcButtonsPerCol: Integer;
    procedure CalcBufferSizes;
    function CalcCategoryHeight(const Category: TButtonCategory; const ButtonsPerRow: Integer): Integer;
    function CalcCategoryWidth(const Category: TButtonCategory; const ButtonsPerCol: Integer): Integer;
    procedure DrawCategory(const Category: TButtonCategory; const Canvas: TCanvas; StartingPos: Integer);
    procedure GetCategoryBounds(const Category: TButtonCategory; const StartingPos: Integer; var CategoryBounds, ButtonBounds: TRect);
    function GetChevronBounds(const CategoryBounds: TRect): TRect;
    function GetIndexOfFirstCategory: Integer;
    function GetNextButtonInGroup(const StartingItem: TBaseItem; GoForward: Boolean): TBaseItem;
    function GetNextButton(const StartingItem: TBaseItem; GoForward: Boolean): TBaseItem;
    function GetScrollOffset: Integer;
    // function GetScrollBuffer: Integer;
    procedure ImageListChange(Sender: TObject);
    procedure ScrollPosChanged(ScrollCode: TScrollCode; ScrollPos: Integer);
    procedure SetOnDrawButton(const Value: TCatButtonDrawEvent);
    procedure SetOnDrawIcon(const Value: TCatButtonDrawIconEvent);
    procedure SetBackgroundGradientColor(const Value: TColor);
    procedure SetBackGradientDirection(const Value: TGradientDirection);
    procedure SetBorderStyle(const Value: TBorderStyle);
    procedure SetButtonCategories(const Value: TButtonCategories);
    procedure SetButtonFlow(const Value: TCatButtonFlow);
    procedure SetButtonHeight(const Value: Integer);
    procedure SetButtonWidth(const Value: Integer);
    procedure SetCatButtonOptions(const Value: TCatButtonOptions);
    // procedure SetDragButton(const Value: TButtonItem);
    procedure SetFocusedItem(const Value: TBaseItem);
    procedure SetGradientDirection(const Value: TGradientDirection);
    procedure SetHotButtonColor(const Value: TColor);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetRegularButtonColor(const Value: TColor);
    procedure SetSelectedItem(const Value: TBaseItem);
    procedure SetSelectedButtonColor(const Value: TColor);
    // function ShouldScrollDown(out Delay: DWORD): Boolean;
    // function ShouldScrollUp(out Delay: DWORD): Boolean;
    procedure ShowScrollBar(const Visible: Boolean);
    procedure CMFontchanged(var message: TMessage); message CM_FONTCHANGED;
    procedure CMHintShow(var message: TCMHintShow); message CM_HINTSHOW;
    procedure CNKeydown(var message: TWMKeyDown); message CN_KEYDOWN;

{$HINTS OFF}

    procedure WMEraseBkgnd(var message: TWMEraseBkgnd);

{$HINTS ON}

    procedure WMMouseLeave(var message: TMessage); message WM_MOUSELEAVE;
    procedure WMVScroll(var message: TWMVScroll); message WM_VSCROLL;
    procedure WMHScroll(var message: TWMVScroll); message WM_HSCROLL;
    procedure WMSetFocus(var message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var message: TWMKillFocus); message WM_KILLFOCUS;

  protected
    // procedure BeginAutoDrag; override;
    function CanEdit(Item: TBaseItem): Boolean; dynamic;
    procedure CreateHandle; override;
    procedure CreateParams(var Params: TCreateParams); override;
    // procedure DoBeginDrag(Immediate: Boolean; Threshold: Integer); virtual;
    procedure DoCopyButton(const Button: TButtonItem; const TargetCategory: TButtonCategory; const TargetButton: TButtonItem); dynamic;
    // procedure DoEndDrag(Target: TObject; X: Integer; Y: Integer); override;
    procedure DoGesture(const EventInfo: TGestureEventInfo; var Handled: Boolean); override;
    procedure DoHotButton; dynamic;
    { procedure DoReorderButton(const Button: TButtonItem;
      const TargetCategory: TButtonCategory; const TargetButton: TButtonItem); dynamic;
      procedure DoReorderCategory(const SourceCategory,
      TargetCategory: TButtonCategory); dynamic;
      procedure DoStartDrag(var DragObject: TDragObject); override; }
    procedure DoItemClicked(const Item: TBaseItem); dynamic;
    procedure DoItemNotify(Item: TCollectionItem; Action: TCollectionNotification);
    procedure DoItemUpdate(Item: TCollectionItem);
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure DoSelectedItemChanged(const Item: TBaseItem); dynamic;
    { procedure DragOver(Source: TObject; X: Integer; Y: Integer;
      State: TDragState; var Accept: Boolean); override; }
    procedure DrawButton(const Button: TButtonItem; Canvas: TCanvas; Rect: TRect; State: TButtonDrawState); virtual;
    function Edit(const Item: TBaseItem): Boolean; virtual;
    procedure EndEdit(Cancel: Boolean);
    function GetAllowReorder: Boolean; dynamic;
    function GetCurrentCategory: TButtonCategory; virtual;
    function GetButtonCategoriesClass: TButtonCategoriesClass; virtual;
    function GetButtonCategoryClass: TButtonCategoryClass; virtual;
    function GetButtonItemClass: TButtonItemClass; virtual;
    function GetInplaceEditBounds(const Item: TBaseItem): TRect;
    function GetScrollPos: Integer;
    function HasVerticalCaption(const Category: TButtonCategory): Boolean;
    function IsTouchPropertyStored(AProperty: TTouchProperty): Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure ScrollRectIntoView(const Rect: TRect; PlaceOnTop: Boolean = False);
    procedure SetScrollPos(const Value: Integer);
    procedure WndProc(var message: TMessage); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    // procedure DragDrop(Source: TObject; X: Integer; Y: Integer); override;
    // procedure GenerateDragImage;
    function GetButtonAt(X, Y: Integer; Category: TButtonCategory = nil): TButtonItem;
    function GetButtonRect(const Item: TBaseItem): TRect;
    function GetCategoryAt(X, Y: Integer): TButtonCategory;
    function GetCategoryRect(const Category: TButtonCategory; ButtonOnly: Boolean = False): TRect;
    // function GetDragImages: TDragImageList; override;
    { procedure GetTargetAt(X, Y: Integer; var TargetButton: TButtonItem;
      var TargetCategory: TButtonCategory); }
    function IsEditing: Boolean;
    // procedure RemoveInsertionPoints;
    procedure ScrollIntoView(const Item: TBaseItem);
    { procedure SetInsertionButton(InsertionButton: TButtonItem;
      InsertionCategory: TButtonCategory); }
    procedure UpdateAllButtons;
    procedure UpdateButton(const Item: TBaseItem);
    property CurrentCategory: TButtonCategory read GetCurrentCategory;
    // property DragButton: TButtonItem read FDragButton write SetDragButton;
    // property DragCategory: TButtonCategory read FDragCategory write FDragCategory;
    // property DragImageList: TDragImageList read FDragImageList;
    property SelectedItem: TBaseItem read FSelectedItem write SetSelectedItem;
    property FocusedItem: TBaseItem read FFocusedItem write SetFocusedItem;

  published
    property Align;
    property Anchors;
    property BackgroundGradientColor: TColor read FBackgroundGradientColor write SetBackgroundGradientColor default ClNone;
    property BackgroundGradientDirection: TGradientDirection read FBackGradientDirection write SetBackGradientDirection default GdHorizontal;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BorderWidth;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default BsSingle;
    property ButtonFlow: TCatButtonFlow read FButtonFlow write SetButtonFlow;
    property ButtonHeight: Integer read FButtonHeight write SetButtonHeight default 24;
    property ButtonWidth: Integer read FButtonWidth write SetButtonWidth default 24;
    property ButtonOptions: TCatButtonOptions read FButtonOptions write SetCatButtonOptions default[BoGradientFill, BoShowCaptions, BoVerticalCategoryCaptions];
    property Categories: TButtonCategories read FButtonCategories write SetButtonCategories;
    property Color default ClWindow;
    property Cursor;
    property DockSite;
    property DoubleBuffered;
    // property DragCursor;
    // property DragKind;
    // property DragMode;
    property Enabled;
    property Font;
    property GradientDirection: TGradientDirection read FGradientDirection write SetGradientDirection default GdHorizontal;
    property Height default 100;
    property HotButtonColor: TColor read FHotButtonColor write SetHotButtonColor default $00EFD3C6;
    property Images: TCustomImageList read FImages write SetImages;
    property ParentDoubleBuffered;
    property PopupMenu;
    property RegularButtonColor: TColor read FRegularButtonColor write SetRegularButtonColor nodefault;
    property SelectedButtonColor: TColor read FSelectedButtonColor write SetSelectedButtonColor nodefault;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Touch;
    property Visible;
    property Width default 100;

    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnAfterDrawButton: TCatButtonDrawEvent read FOnAfterDrawButton write FOnAfterDrawButton;
    property OnBeforeDrawButton: TCatButtonDrawEvent read FOnBeforeDrawButton write FOnBeforeDrawButton;
    property OnButtonClicked: TCatButtonEvent read FOnButtonClicked write FOnButtonClicked;
    property OnCancelEdit: TCatButtonCancelEditEvent read FOnCancelEdit write FOnCancelEdit;
    property OnCategoryCollapase: TCategoryCollapseEvent read FOnCategoryCollapase write FOnCategoryCollapase;
    property OnCategoryClicked: TCatButtonCategoryEvent read FOnCategoryClicked write FOnCategoryClicked;
    property OnClick;
    property OnContextPopup;
    property OnCopyButton: TCatButtonCopyEvent read FOnCopyButton write FOnCopyButton;
    property OnDockDrop;
    property OnDockOver;
    // property OnDragDrop;
    // property OnDragOver;
    property OnDrawButton: TCatButtonDrawEvent read FOnDrawButton write SetOnDrawButton;
    property OnDrawIcon: TCatButtonDrawIconEvent read FOnDrawIcon write SetOnDrawIcon;
    property OnDrawText: TCatButtonDrawEvent read FOnDrawText write FOnDrawText;
    property OnEditing: TCatButtonEditingEvent read FOnEditing write FOnEditing;
    property OnEdited: TCatButtonEditedEvent read FOnEdited write FOnEdited;
    property OnEndDock;
    // property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnGetHint: TCatButtonGetHint read FOnGetHint write FOnGetHint;
    property OnHotButton: TCatButtonEvent read FOnHotButton write FOnHotButton;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnReorderButton: TCatButtonReorderEvent read FOnReorderButton write FOnReorderButton;
    property OnReorderCategory: TCategoryReorderEvent read FOnReorderCategory write FOnReorderCategory;
    property OnSelectedItemChange: TCatButtonEvent read FOnSelectedButtonChange write FOnSelectedButtonChange; // This is really OnSelectedButtonChange
    property OnSelectedCategoryChange: TCatButtonCategoryEvent read FOnSelectedCategoryChange write FOnSelectedCategoryChange;
    property OnStartDock;
    // property OnStartDrag;
  end;

  { TBaseItem }

  TBaseItem = class(TCollectionItem)
  strict private
    FCaption: string;
    FInterfaceData: IInterface;

  protected
    function GetBounds: TRect; virtual; abstract;
    function IsCaptionStored: Boolean; virtual;
    procedure SetCaption(const Value: string);

  protected // friend
    function GetFirstSibling: TBaseItem;
    function GetLastSibling: TBaseItem;
    function GetNextSibling(Distance: Integer = 1): TBaseItem;
    function GetPrevSibling(Distance: Integer = 1): TBaseItem;

  public
    function EditText: Boolean;
    procedure EndEdit(Cancel: Boolean);
    procedure ScrollIntoView; virtual; abstract;
    property Bounds: TRect read GetBounds;
    property InterfaceData: IInterface read FInterfaceData write FInterfaceData;
    property Caption: string read FCaption write SetCaption stored IsCaptionStored;
  end;

  { TBaseButtonItem }

  TBaseButtonItem = class(TBaseItem)
  strict private
    FActionLink: TButtonItemActionLink;
    FImageIndex: TImageIndex;
    FData: TCustomData;
    FHint: string;
    FOnClick: TNotifyEvent;
    // Добавляем новые свойства для кнопок
    FUIN: string;
    FStatus: Integer;
    FXImageIndex: TImageIndex;
    FCImageIndex: TImageIndex;
    FContactType: string;
    FNickColor: Integer;
    FNickBold: Boolean;

    // Конец добавления новых свойств
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); virtual;
    procedure DoActionChange(Sender: TObject);
    function GetAction: TBasicAction;
    function GetActionLinkClass: TButtonItemActionLinkClass; virtual;
    function GetBounds: TRect; override;
    function GetDisplayName: string; override;
    function GetNotifyTarget: TComponent; virtual; abstract;
    function IsCaptionStored: Boolean; override;
    function IsHintStored: Boolean;
    function IsImageIndexStored: Boolean;
    function IsOnClickStored: Boolean;
    procedure SetAction(const Value: TBasicAction);
    procedure SetImageIndex(const Value: TImageIndex);
    // Добавляем отображение доп. иконок
    procedure SetXImageIndex(const Value: TImageIndex);
    procedure SetCImageIndex(const Value: TImageIndex);

    // Конец добавления
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property ActionLink: TButtonItemActionLink read FActionLink write FActionLink;
    property Data: TCustomData read FData write FData;

  published
    property Action: TBasicAction read GetAction write SetAction;
    property Caption;
    property Hint: string read FHint write FHint stored IsHintStored;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex stored IsImageIndexStored;
    property OnClick: TNotifyEvent read FOnClick write FOnClick stored IsOnClickStored;
    // Добавляем новые свойства для кнопок
    property UIN: string read FUIN write FUIN;
    property Status: Integer read FStatus write FStatus default 0;
    property XImageIndex: TImageIndex read FXImageIndex write SetXImageIndex stored IsImageIndexStored;
    property CImageIndex: TImageIndex read FCImageIndex write SetCImageIndex stored IsImageIndexStored;
    property ContactType: string read FContactType write FContactType;
    property NickColor: Integer read FNickColor write FNickColor default 0;
    property NickBold: Boolean read FNickBold write FNickBold default False;
  end;

  { TButtonItem }

  TButtonItem = class(TBaseButtonItem)
  protected
    function GetBounds: TRect; override;
    function GetCategory: TButtonCategory;
    function GetCategoryButtons: TCategoryButtons;
    function GetNotifyTarget: TComponent; override;

  public
    procedure Assign(Source: TPersistent); override;
    procedure ScrollIntoView; override;
    property Category: TButtonCategory read GetCategory;

  published
    property CategoryButtons: TCategoryButtons read GetCategoryButtons;
  end;

  { TItemCollection }

  TItemCollection = class(TCollection)
  strict private
    FCategoryButtons: TCategoryButtons;

  strict protected
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;

  public
    constructor Create(const ACategoryButtons: TCategoryButtons; const ItemClass: TCollectionItemClass); overload; virtual;
    property CategoryButtons: TCategoryButtons read FCategoryButtons;
  end;

  { TButtonCollection }

  TButtonCollection = class(TItemCollection)
  strict private
    FCategory: TButtonCategory;

  protected
    function GetItem(index: Integer): TButtonItem;
    function GetOwner: TPersistent; override;
    procedure SetItem(index: Integer; const Value: TButtonItem);
    procedure Update(Item: TCollectionItem); override;

  public
    constructor Create(const ACategory: TButtonCategory);
    function Add: TButtonItem;
    function AddItem(Item: TButtonItem; index: Integer): TButtonItem;
    function Insert(index: Integer): TButtonItem;

    property Category: TButtonCategory read FCategory;
    property Items[index: Integer]: TButtonItem read GetItem write SetItem; default;
  end;

  { TButtonCategory }

  TButtonCategory = class(TBaseItem)
  strict private
    FCollapsed: Boolean;
    FColor: TColor;
    FGradientColor: TColor;
    FTextColor: TColor;
    FItems: TButtonCollection;
    { Information for caching drawing state }
    FStart: Integer;
    FEnd: Integer;
    FData: TCustomData;
    // Добавляем новые свойства для групп
    FGroupId: string;
    FGroupSelected: Boolean;
    FGroupCaption: string;
    FGroupType: string;
    FGroupImage: Integer;

    // Конец добавления
  protected
    function GetBounds: TRect; override;
    function GetCategories: TButtonCategories;
    function GetCategoryButtons: TCategoryButtons;
    procedure SetItems(const Value: TButtonCollection);
    procedure SetCollapsed(const Value: Boolean);
    procedure SetColor(const Value: TColor);
    procedure SetGradientColor(const Value: TColor);
    procedure SetIndex(Value: Integer); override;
    procedure SetTextColor(const Value: TColor);

  protected // friend
    property StartOffset: Integer read FStart write FStart;
    property EndOffset: Integer read FEnd write FEnd;

  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetButtonRect(ButtonOnly: Boolean): TRect;
    function IndexOf(const Caption: string): Integer;
    procedure ScrollIntoView; override;

    property Categories: TButtonCategories read GetCategories;
    property Bounds: TRect read GetBounds;
    property Data: TCustomData read FData write FData;

  published
    property Caption;
    property CategoryButtons: TCategoryButtons read GetCategoryButtons;
    property Color: TColor read FColor write SetColor;
    property Collapsed: Boolean read FCollapsed write SetCollapsed;
    property GradientColor: TColor read FGradientColor write SetGradientColor default ClNone;
    property Items: TButtonCollection read FItems write SetItems;
    property TextColor: TColor read FTextColor write SetTextColor default ClWindowText;
    // Добавляем новые свойства для групп
    property GroupId: string read FGroupId write FGroupId;
    property GroupSelected: Boolean read FGroupSelected write FGroupSelected default False;
    property GroupCaption: string read FGroupCaption write FGroupCaption;
    property GroupType: string read FGroupType write FGroupType;
    property GroupImage: Integer read FGroupImage write FGroupImage default 0;
  end;

  { TButtonCategories }

  TButtonCategories = class(TItemCollection)
  strict private
    FOriginalID: Integer;

  protected
    function GetItem(index: Integer): TButtonCategory;
    function GetOwner: TPersistent; override;
    function GetUpdateCount: Integer;
    function GetVisibleCount: Integer;
    procedure SetItem(index: Integer; const Value: TButtonCategory);
    procedure Update(Item: TCollectionItem); override;
    property UpdateCount: Integer read GetUpdateCount;

  public
    constructor Create(const CategoryButtons: TCategoryButtons); overload; virtual;
    function Add: TButtonCategory;
    function AddItem(Item: TButtonCategory; index: Integer): TButtonCategory;
    procedure BeginUpdate; override;
    function IndexOf(const Caption: string): Integer;
    function Insert(index: Integer): TButtonCategory;
    function ItemAt(const index: Integer): TBaseItem;
    function ItemIndex(const Caption: string): Integer;
    property Items[index: Integer]: TButtonCategory read GetItem write SetItem; default;
    property VisibleCount: Integer read GetVisibleCount;
  end;

  { TButtonItemActionLink }

  TButtonItemActionLink = class(TActionLink)
  strict private
    FClient: TBaseButtonItem;

  protected
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

  System.Runtime.InteropServices,
  System.Security.Permissions,
  System.Threading,

{$IFEND}

  Themes,
  ExtCtrls,
  Types,
  VarsUnit;

{$IF DEFINED(CLR)}

// {$R Borland.Vcl.CategoryButtons.res} { Contains the Copy DragCursor }

{$ELSE}

// {$R CategoryButtons.res}             { Contains the Copy DragCursor }

{$IFEND}

type

  { TInplaceEdit }

  TInplaceEdit = class(TCustomEdit)
  private
    FItem: TBaseItem;
    FCategoryButtons: TCategoryButtons;
    procedure CNKeydown(var message: TWMKeyDown); message CN_KEYDOWN;

  protected
    procedure DblClick; override;
    procedure DeActivate;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure BoundsChanged; virtual;
    procedure WndProc(var message: TMessage); override;
    property CategoryButtons: TCategoryButtons read FCategoryButtons;

  public
    constructor Create(AOwner: TComponent); override;
    procedure Initialize(const AItem: TBaseItem; const ABounds: TRect; AColor: TColor; const AText: string);
    property Item: TBaseItem read FItem;
  end;

constructor TInplaceEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCategoryButtons := AOwner as TCategoryButtons;
  Parent := FCategoryButtons;
  ParentCtl3D := False;
  Ctl3D := False;
  TabStop := False;
  BorderStyle := BsNone;
  DoubleBuffered := False;
end;

procedure TInplaceEdit.Initialize(const AItem: TBaseItem; const ABounds: TRect; AColor: TColor; const AText: string);
begin
  FItem := AItem;
  if AItem is TButtonItem then
    BorderStyle := BsSingle;
  with ABounds do
    SetWindowPos(Handle, HWND_TOP, Left, Top, Right - Left, Bottom - Top, SWP_SHOWWINDOW or SWP_NOREDRAW);
  BoundsChanged;
  if CategoryButtons.Focused then
    Windows.SetFocus(Handle);
  Color := AColor;
  Text := AText;
  SelectAll;
end;

procedure TInplaceEdit.CNKeydown(var message: TWMKeyDown);
begin
  inherited;
  case message.CharCode of
    VK_ESCAPE, VK_RETURN: CategoryButtons.Dispatch(message);
  end;
end;

procedure TInplaceEdit.DblClick;
begin
  CategoryButtons.DblClick;
end;

procedure TInplaceEdit.DeActivate;
begin
  Hide;
  DestroyHandle;
end;

procedure TInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  CategoryButtons.KeyDown(Key, Shift);
end;

procedure TInplaceEdit.KeyPress(var Key: Char);
begin
  CategoryButtons.KeyPress(Key);
end;

procedure TInplaceEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  CategoryButtons.KeyUp(Key, Shift);
end;

procedure TInplaceEdit.WndProc(var message: TMessage);
begin
  case message.Msg of
    WM_SETFOCUS: begin
        if (GetParentForm(Self) = nil) or GetParentForm(Self).SetFocusedControl(CategoryButtons) then
          Dispatch(message);
        Exit;
      end;
    WM_KILLFOCUS, WM_MOUSEWHEEL, WM_CANCELMODE: begin
        CategoryButtons.WndProc(message);
        Exit;
      end;
  end;
  inherited WndProc(message);
end;

procedure TInplaceEdit.BoundsChanged;
var
  R: TRect;
begin
  R := Rect(2, 2, Width - 2, Height);
  SendStructMessage(Handle, EM_SETRECTNP, 0, R);
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
end;

{ TCategoryButtons }

{$IF DEFINED(CLR)}

class constructor TCategoryButtons.Create;
// var
// LHandle: HCURSOR;
begin
  // Add our drag/copy cursor image
  { LHandle := LoadCursor(HInstance, 'CAT_DRAG_COPY'); // Do not localize
    FCursorHandle := TSafeCursorHandle.Create(LHandle);
    Screen.Cursors[crDragCopy] := LHandle; }
end;

{$IFEND}

constructor TCategoryButtons.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 100;
  Height := 100;
  ControlStyle := [CsDoubleClicks, CsCaptureMouse,
  { csDisplayDragImage, } CsClickEvents, CsPannable];
  FButtonCategories := GetButtonCategoriesClass.Create(Self);
  FBorderStyle := BsSingle;
  FButtonWidth := 24;
  FButtonHeight := 24;
  FGradientDirection := GdHorizontal;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FDoubleBuffered := True;
  // FDragImageList := TDragImageList.Create(nil);
  FButtonOptions := [BoGradientFill, BoShowCaptions, BoVerticalCategoryCaptions];

  FHotButtonColor := $00EFD3C6;
  FSelectedButtonColor := GetShadowColor(ClBtnFace, -10);
  FRegularButtonColor := GetHighlightColor(ClBtnFace, 15);
  FBackgroundGradientColor := ClNone;

  TabStop := True;
  Color := ClWindow;
  Touch.InteractiveGestures := [IgPan, IgPressAndTap];
  Touch.InteractiveGestureOptions := [IgoPanInertia, IgoPanSingleFingerHorizontal, IgoPanSingleFingerVertical, IgoPanGutter, IgoParentPassthrough];
end;

procedure TCategoryButtons.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (FBorderStyle = BsSingle) then
    begin
      Params.Style := Params.Style and not WS_BORDER;
      Params.ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
    end;
end;

destructor TCategoryButtons.Destroy;
begin
  FSelectedItem := nil;
  FFocusedItem := nil;
  FDownButton := nil;
  // FDragButton := nil;
  FHotButton := nil;
  // FreeAndNil(FDragImageList);
  FreeAndNil(FButtonCategories);
  FreeAndNil(FImageChangeLink);
  inherited;
end;

function TCategoryButtons.GetScrollOffset: Integer;
begin
  Result := FScrollBarPos * FScrollSize;
end;

function TCategoryButtons.GetButtonRect(const Item: TBaseItem): TRect;
var
  ButtonsPerRow: Integer;
  Row, Col: Integer;
  StartingPos: Integer;
  Button: TButtonItem;
  CategoryBounds, ButtonBounds: TRect;
begin
  if Item is TButtonItem then
    begin
      { Translate the current virtual position to the actual position }
      Button := Item as TButtonItem;
      StartingPos := Button.Category.StartOffset - GetScrollOffset;
      ButtonBounds := Rect(0, 0, 0, 0);
      GetCategoryBounds(Button.Category, StartingPos, CategoryBounds, ButtonBounds);
      if not IsRectEmpty(ButtonBounds) then
        begin
          if FButtonFlow = CbfVertical then
            ButtonsPerRow := CalcButtonsPerRow
          else
            ButtonsPerRow := (ButtonBounds.Right - ButtonBounds.Left) div FButtonWidth;
          Row := Button.index div ButtonsPerRow;
          Result.Top := ButtonBounds.Top + Row * FButtonHeight;
          if (FButtonFlow = CbfVertical) and (BoFullSize in FButtonOptions) then
            begin
              Result.Left := ButtonBounds.Left;
              Result.Right := ButtonBounds.Right;
            end
          else
            begin
              Col := Button.index mod ButtonsPerRow;
              Result.Left := ButtonBounds.Left + Col * FButtonWidth;
              Result.Right := Result.Left + FButtonWidth;
            end;
          Result.Bottom := Result.Top + FButtonHeight;
        end;
    end
  else
    Result := Item.Bounds;
end;

procedure TCategoryButtons.ImageListChange(Sender: TObject);
begin
  UpdateAllButtons;
end;

procedure TCategoryButtons.Notification(AComponent: TComponent; Operation: TOperation);
var
  I, J: Integer;
begin
  inherited;
  if (Operation = OpRemove) then
    begin
      if AComponent = Images then
        Images := nil
      else if AComponent is TBasicAction then
        for I := 0 to FButtonCategories.Count - 1 do
          for J := 0 to FButtonCategories[I].Items.Count - 1 do
            if AComponent = FButtonCategories[I].Items[J].Action then
              FButtonCategories[I].Items[J].Action := nil;
    end;
end;

const
  CBorderBuffer = 6;

function TCategoryButtons.CalcCategoryHeight(const Category: TButtonCategory; const ButtonsPerRow: Integer): Integer;
var
  RowCount: Integer;
begin
  if Category.Collapsed or (Category.Items = nil) or (Category.Items.Count = 0) then
    Result := FCollapsedHeight + CBorderBuffer
  else
    begin
      RowCount := Category.Items.Count div ButtonsPerRow;
      if Category.Items.Count mod ButtonsPerRow <> 0 then
        Inc(RowCount);

      Result := RowCount * FButtonHeight + CBorderBuffer;
      if not(BoVerticalCategoryCaptions in ButtonOptions) then
        Result := Result + FGutterSize;
    end;
end;

function TCategoryButtons.CalcCategoryWidth(const Category: TButtonCategory; const ButtonsPerCol: Integer): Integer;
var
  ColCount: Integer;
begin
  if Category.Collapsed or (Category.Items = nil) or (Category.Items.Count = 0) then
    Result := FCollapsedHeight + CBorderBuffer
  else
    begin
      ColCount := Category.Items.Count div ButtonsPerCol;
      if Category.Items.Count mod ButtonsPerCol <> 0 then
        Inc(ColCount);

      Result := ColCount * FButtonWidth + CBorderBuffer;
      if BoVerticalCategoryCaptions in ButtonOptions then
        Result := Result + FGutterSize;
    end;
end;

procedure TCategoryButtons.AdjustCategoryBounds(const Category: TButtonCategory; var CategoryBounds: TRect; IgnoreButtonFlow: Boolean = False);
begin
  // Adjust a the category bounds to collapsed dimensions (even if not collapsed)
  if (IgnoreButtonFlow or (FButtonFlow = CbfVertical)) and not Category.Collapsed and (Category.Items.Count > 0) then
    begin
      if (BoVerticalCategoryCaptions in ButtonOptions) then
        begin
          CategoryBounds.Right := CategoryBounds.Left + FCollapsedHeight + CBorderBuffer;
          CategoryBounds.Bottom := CategoryBounds.Bottom - 3;
        end
      else
        CategoryBounds.Bottom := CategoryBounds.Top + FCollapsedHeight + CBorderBuffer - 2
    end;
end;

procedure TCategoryButtons.GetCategoryBounds(const Category: TButtonCategory; const StartingPos: Integer; var CategoryBounds, ButtonBounds: TRect);
var
  CatHeight { , CatWidth } : Integer;
  ButtonsPerRow { , ButtonsPerCol } : Integer;
  XStart { , YStart } : Integer;
  XEnd { , YEnd } : Integer;
begin
  if FButtonFlow = CbfVertical then
    begin
      { 2 Pixel buffer on each side }
      XStart := 2;
      XEnd := ClientWidth - 2;

      ButtonsPerRow := CalcButtonsPerRow;
      CatHeight := CalcCategoryHeight(Category, ButtonsPerRow);

      // Внёс изменения

      with CategoryBounds do
        begin
          Left := XStart;
          Top := StartingPos + 1;
          Right := XEnd;
          Bottom := StartingPos + CatHeight - 1;
        end;

      if not Category.Collapsed then
        begin
         { if BoCaptionOnlyBorder in ButtonOptions then
            with CategoryBounds do
              Inc(Bottom, 3); }

          with ButtonBounds do
            begin
              Top := StartingPos + 2;
              if BoVerticalCategoryCaptions in ButtonOptions then
                Left := XStart + FGutterSize + 1
              else
                begin
                  Left := XStart;
                  Top := Top + FGutterSize;
                end;
              Right := XEnd;
              Bottom := Top + (Category.Items.Count div ButtonsPerRow) * FButtonHeight;
              if Category.Items.Count mod ButtonsPerRow <> 0 then
                Inc(Bottom, FButtonHeight);
              Inc(Top, 3);
            end;
        end;

      // Конец внесения изменений

    end
  else
    begin
      { 2 Pixel buffer on each side }
      { YStart := 2;
        YEnd := ClientHeight - 3;

        ButtonsPerCol := CalcButtonsPerCol;
        CatWidth := CalcCategoryWidth(Category, ButtonsPerCol);

        with CategoryBounds do
        begin
        Left := StartingPos + 1;
        Top := YStart;
        Right := StartingPos + CatWidth - 1;
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
        end; }
    end;
end;

const
  CDropDownSize = 31;

function TCategoryButtons.GetChevronBounds(const CategoryBounds: TRect): TRect;
begin
  Result.Left := CategoryBounds.Left + 2;
  Result.Top := CategoryBounds.Top + 2;
  Result.Right := Result.Left + CDropDownSize;
  Result.Bottom := Result.Top + CDropDownSize;
end;

function TCategoryButtons.GetCurrentCategory: TButtonCategory;
begin
  Result := nil;
  if FSelectedItem <> nil then
    begin
      if FSelectedItem.InheritsFrom(TButtonCategory) then
        Result := FSelectedItem as TButtonCategory
      else if FSelectedItem.InheritsFrom(TButtonItem) then
        Result := (FSelectedItem as TButtonItem).Category;
    end;
end;

procedure TCategoryButtons.DrawCategory(const Category: TButtonCategory; const Canvas: TCanvas; StartingPos: Integer);

procedure DrawDropDownButton(X, Y: Integer; Collapsed: Boolean);
{ const
  ChevronDirection: array[Boolean] of TScrollDirection = (sdDown, sdRight);
  ChevronXPosAdjust: array[Boolean] of Integer = (2, 0);
  ChevronYPosAdjust: array[Boolean] of Integer = (1, 3);
  var
  Middle: Integer; }

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
        Details := ThemeServices.GetElementDetails(TtGlyphClosed)
      else
        Details := ThemeServices.GetElementDetails(TtGlyphOpened);
      ThemeServices.DrawElement(Canvas.Handle, Details, Rect(X, Y, X + Width, Y + Width));
    end
  else
    begin
      Canvas.Pen.Color := ClBtnShadow;
      Canvas.Brush.Color := ClWindow;
      Canvas.Rectangle(X, Y, X + Width, Y + Height);
      Canvas.Pen.Color := ClWindowText;

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
  { if boUsePlusMinus in ButtonOptions then
    begin }
  DrawPlusMinus;
  { end
    else
    begin
    Middle := cDropDownSize div 2;
    Canvas.Pen.Color := clBtnShadow;
    DrawChevron(Canvas, ChevronDirection[Collapsed],
    Point(X + Middle - ChevronXPosAdjust[Collapsed],
    Y + Middle - ChevronYPosAdjust[Collapsed]), 3);
    end; }
end;

var
  I: Integer;
  ButtonTop, ButtonLeft, ButtonRight, ImgTop: Integer;
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
  CategoryBounds, CategoryFrameBounds, ButtonBounds, ChevronBounds: TRect;
  GradientColor, SourceColor, TempColor: TColor;
  Caption: string;
  CaptionRect: TRect;
  CategoryRealBounds: TRect;
begin
  GetCategoryBounds(Category, StartingPos, CategoryBounds, ButtonBounds);

  if FSelectedItem = Category then
    SourceColor := FSelectedButtonColor
  else if Category.Color <> ClNone then
    SourceColor := Category.Color
  else
    SourceColor := Self.Color;

  CategoryFrameBounds := CategoryBounds;
  AdjustCategoryBounds(Category, CategoryFrameBounds);
  if BoCaptionOnlyBorder in ButtonOptions then
    CategoryRealBounds := CategoryFrameBounds
  else
    CategoryRealBounds := CategoryBounds;

  if (FSelectedItem <> Category) and (BoGradientFill in FButtonOptions) then
    begin
      if Category.GradientColor <> ClNone then
        GradientColor := Category.GradientColor
      else
        GradientColor := Self.Color;

      GradientFillCanvas(Canvas, SourceColor, GradientColor, CategoryRealBounds, FGradientDirection);
    end
  else
    begin
      Canvas.Brush.Color := SourceColor;
      Canvas.FillRect(CategoryRealBounds)
    end;

  with CategoryRealBounds do
    begin
      Right := Right - 1;
      Bottom := Bottom - 1; // Внёс изменения
      // take care of the top left few pixels..
      TempColor := Self.Color;
      Canvas.Pixels[Left, Top] := TempColor;
      Canvas.Pixels[Left + 1, Top] := TempColor;
      Canvas.Pixels[Left, Top + 1] := TempColor;

      Canvas.Pixels[Left, Bottom] := TempColor;
      Canvas.Pixels[Left + 1, Bottom] := TempColor;
      Canvas.Pixels[Left, Bottom - 1] := TempColor;

      if BackgroundGradientColor <> ClNone then
        TempColor := BackgroundGradientColor;

      Canvas.Pixels[Right, Top] := TempColor;
      Canvas.Pixels[Right - 1, Top] := TempColor;
      Canvas.Pixels[Right, Top + 1] := TempColor;

      Canvas.Pixels[Right, Bottom] := TempColor;
      Canvas.Pixels[Right - 1, Bottom] := TempColor;
      Canvas.Pixels[Right, Bottom - 1] := TempColor;

      { Now draw an outline }
      Canvas.Pen.Color := GetShadowColor(SourceColor, -10);
      Canvas.Polyline([Point(Left + 2, Top), Point(Right - 2, Top), { Top line }
        Point(Right, Top + 2), { Top right curve }
        Point(Right, Bottom - 2), { Right side line }
        Point(Right - 2, Bottom), { Bottom right curve }
        Point(Left + 2, Bottom), { Bottom line }
        Point(Left, Bottom - 2), { Bottom left curve }
        Point(Left, Top + 2), { Left side line }
        Point(Left + 2, Top)]); { Top left curve }
    end;

  { if ((Category.Collapsed) and (FSelectedItem <> nil) and
    (CurrentCategory = Category)) or (FSelectedItem = Category) then
    begin
    Canvas.Brush.Color := GetShadowColor(SourceColor, -75);
    with CategoryFrameBounds do
    Canvas.FrameRect(Rect(Left + 1, Top + 1, Right, Bottom));
    end; }

  ChevronBounds := GetChevronBounds(CategoryRealBounds);

  if Category.Items.Count > 0 then
    DrawDropDownButton(ChevronBounds.Left, ChevronBounds.Top, Category.Collapsed);

  VerticalCaption := HasVerticalCaption(Category);

  { Draw the category caption. Truncating and vertical as needed. }
  Caption := Category.Caption;

  if (BoBoldCaptions in ButtonOptions) then
    Canvas.Font.Style := Canvas.Font.Style + [FsBold];

  CapWidth := Canvas.TextWidth(Caption);
  if VerticalCaption then
    CatHeight := CategoryBounds.Bottom - CategoryBounds.Top - 3 - CDropDownSize
  else
    CatHeight := CategoryBounds.Right - CategoryBounds.Left - 2 - CDropDownSize;

  CapLeft := (CatHeight - CapWidth) div 2;
  if CapLeft < 2 then
    CapLeft := 2;

  Canvas.Brush.Style := BsClear;
  Canvas.Font.Color := Category.TextColor;
  if not VerticalCaption then
    begin
      CaptionRect.Left := CategoryBounds.Left + 4 + CDropDownSize;
      CaptionRect.Top := CategoryBounds.Top + 1; // Внёс изменения
    end
  else
    begin
      CaptionRect.Left := CategoryBounds.Left + 1;
      CaptionRect.Top := CategoryBounds.Bottom - CapLeft;
      Canvas.Font.Orientation := 900;
    end;

  CaptionRect.Right := CaptionRect.Left + CatHeight;
  CaptionRect.Bottom := CaptionRect.Top + Canvas.TextHeight(Caption);
  Canvas.TextRect(CaptionRect, Caption, [TfNoClip, TfEndEllipsis]);

  if (BoBoldCaptions in ButtonOptions) then
    Canvas.Font.Style := Canvas.Font.Style - [FsBold];

  Canvas.Brush.Style := BsSolid;
  Canvas.Font.Orientation := 0;

  if not Category.Collapsed then
    begin
      { Draw the buttons }
      if (FButtonFlow = CbfVertical) and (BoFullSize in ButtonOptions) then
        ActualWidth := ClientWidth - FSideBufferSize
      else
        ActualWidth := FButtonWidth;

      ButtonStart := ButtonBounds.Left;
      ButtonTop := ButtonBounds.Top;
      ButtonLeft := ButtonStart;
      for I := 0 to Category.Items.Count - 1 do
        begin
          { Don't waste time painting clipped things }
          if (FButtonFlow = CbfVertical) and (ButtonTop > ClientHeight) then
            Break; { Done drawing }

          { Don't waste time drawing what is offscreen }
          ButtonBottom := ButtonTop + FButtonHeight;
          ButtonRight := ButtonLeft + ActualWidth + 4;
          // Make buttons narrower to leave room to draw the category border
          // around the right side.
          if VerticalCaption and not(BoCaptionOnlyBorder in ButtonOptions) then
            Dec(ButtonRight, 3);
          if (ButtonBottom >= 0) and (ButtonRight >= 0) then
            begin
              ButtonRect := Rect(ButtonLeft, ButtonTop, ButtonRight, ButtonBottom);

              Button := Category.Items[I];
              DrawState := [];

              // Внёс изменения

              { if Button = FHotButton then
                begin
                Include(DrawState, bdsHot);
                if Button = FDownButton then
                Include(DrawState, bdsDown);
                end;
                if Button = FSelectedItem then
                Include(DrawState, bdsSelected)
                else if (Button = FFocusedItem) and Focused and (FDownButton = nil) then
                Include(DrawState, bdsFocused); }

              if Button = FSelectedItem then
                Include(DrawState, BdsHot);

              // Конец внесения изменений

              if Button = FInsertTop then
                Include(DrawState, BdsInsertTop)
              else if Button = FInsertBottom then
                Include(DrawState, BdsInsertBottom)
              else if Button = FInsertRight then
                Include(DrawState, BdsInsertRight)
              else if Button = FInsertLeft then
                Include(DrawState, BdsInsertLeft);

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

    // Внёс изменения
    if (FImages <> nil) and (Category.GroupImage > -1) and (Category.GroupImage < FImages.Count) then
    begin
      ImgTop := CaptionRect.Top + ((CaptionRect.Bottom - CaptionRect.Top) - FImages.Height) div 2;
      if ImgTop < CaptionRect.Top then
        ImgTop := CaptionRect.Top;
      FImages.Draw(Canvas, 18, ImgTop, Category.GroupImage);
    end;
    // Конец внесения изменений

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

  if BackgroundGradientColor = ClNone then
    begin
      Canvas.Brush.Color := Color;
      Canvas.FillRect(ClientRect);
    end
  else
    GradientFillCanvas(Canvas, Color, BackgroundGradientColor, ClientRect, BackgroundGradientDirection);

  if (TopCategory > -1) and (TopCategory < FButtonCategories.Count) then
    begin
      { Calculate the virtual position and ending position }
      StartingPos := FButtonCategories[TopCategory].StartOffset - GetScrollOffset;
      if FButtonFlow = CbfVertical then
        EndingPos := ClientHeight
      else
        EndingPos := ClientWidth;
      for CatIndex := TopCategory to FButtonCategories.Count - 1 do
        begin
          Category := FButtonCategories[CatIndex];
          DrawCategory(Category, Canvas, StartingPos);
          StartingPos := StartingPos + Category.EndOffset - Category.StartOffset;
          { Stop drawing early, if we can }
          if StartingPos > EndingPos then
            Break;
        end;
    end;
end;

function TCategoryButtons.CalcButtonsPerRow: Integer;
begin
  if BoFullSize in ButtonOptions then
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
  CScrollBarKind: array [TCatButtonFlow] of Integer = (SB_VERT, SB_HORZ);

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
      Category.StartOffset := Y;
      Category.EndOffset := Y + CalcCategoryHeight(Category, ButtonsPerRow);
      Y := Category.EndOffset;
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
      Category.StartOffset := X;
      Category.EndOffset := X + CalcCategoryWidth(Category, ButtonsPerCol);
      X := Category.EndOffset;
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

  if FButtonFlow = CbfVertical then
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
      ScrollInfo.NMax := FScrollBarMax;

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

      ScrollInfo.CbSize := Marshal.SizeOf(TypeOf(TScrollInfo));

{$ELSE}

      ScrollInfo.CbSize := SizeOf(TScrollInfo);

{$IFEND}

      ScrollInfo.FMask := SIF_RANGE or SIF_POS or SIF_PAGE;
      ScrollInfo.NMin := 0;
      ScrollInfo.NPos := FScrollBarPos;
      ScrollInfo.NPage := FPageAmount;

      SetScrollInfo(Handle, CScrollBarKind[FButtonFlow], ScrollInfo, True);
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
      Windows.ShowScrollBar(Handle, CScrollBarKind[ButtonFlow], Visible);
    end;
end;

procedure TCategoryButtons.UpdateAllButtons;
begin
  Invalidate;
end;

procedure TCategoryButtons.UpdateButton(const Item: TBaseItem);
var
  R: TRect;
begin
  { Just invalidate one button's rect }
  if (Item <> nil) and (HandleAllocated) then
    begin
      if (Item is TButtonCategory) and (BoCaptionOnlyBorder in ButtonOptions) then
        R := GetCategoryRect(TButtonCategory(Item), True)
      else
        R := GetButtonRect(Item);
      if not IsRectEmpty(R) then
        InvalidateRect(Handle, R, False);
    end;
end;

procedure TCategoryButtons.WMVScroll(var message: TWMVScroll);
begin
  with message do
    ScrollPosChanged(TScrollCode(ScrollCode), Pos);
end;

procedure TCategoryButtons.WMEraseBkgnd(var message: TWMEraseBkgnd);
begin
  // Background is fully painted in Paint method.
  message.Result := 1;
end;

procedure TCategoryButtons.WMHScroll(var message: TWMVScroll);
begin
  with message do
    ScrollPosChanged(TScrollCode(ScrollCode), Pos);
end;

procedure TCategoryButtons.ScrollPosChanged(ScrollCode: TScrollCode; ScrollPos: Integer);
var
  OldPos: Integer;
begin
  OldPos := FScrollBarPos;
  if (ScrollCode = ScLineUp) and (FScrollBarPos > 0) then
    Dec(FScrollBarPos)
  else if (ScrollCode = ScLineDown) and (FScrollBarPos < FScrollBarMax) then
    Inc(FScrollBarPos)
  else if (ScrollCode = ScPageUp) then
    begin
      Dec(FScrollBarPos, FPageAmount);
      if FScrollBarPos < 0 then
        FScrollBarPos := 0;
    end
  else if ScrollCode = ScPageDown then
    begin
      Inc(FScrollBarPos, FPageAmount);
      if FScrollBarPos > FScrollBarMax then
        FScrollBarPos := FScrollBarMax;
    end
  else if ScrollCode in [ScPosition, ScTrack] then
    FScrollBarPos := ScrollPos
  else if ScrollCode = ScTop then
    FScrollBarPos := 0
  else if ScrollCode = ScBottom then
    FScrollBarPos := FScrollBarMax;
  if OldPos <> FScrollBarPos then
    begin
      Windows.SetScrollPos(Handle, CScrollBarKind[FButtonFlow], FScrollBarPos, True);
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

procedure TCategoryButtons.DrawButton(const Button: TButtonItem; Canvas: TCanvas; Rect: TRect; State: TButtonDrawState);
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
  if Assigned(FOnDrawButton) and (not(CsDesigning in ComponentState)) then
    FOnDrawButton(Self, Button, Canvas, Rect, State)
  else
    begin
      OrgRect := Rect;
      if Assigned(FOnBeforeDrawButton) then
        FOnBeforeDrawButton(Self, Button, Canvas, Rect, State);
      InflateRect(Rect, -1, -1);

      // Начало вноса изменений

      if Button.NickColor = 0 then
        Canvas.Font.Color := clBlack // Стандартный
      else if Button.NickColor = 1 then
        Canvas.Font.Color := clMaroon // Не в сети
      else if Button.NickColor = 2 then
        Canvas.Font.Color := clNavy // В сети
      else if Button.NickColor = 3 then
        Canvas.Font.Color := $00005000 // Видимый
      else if Button.NickColor = 4 then
        Canvas.Font.Color := clRed; // Невидимый

      if Button.NickBold then
        Canvas.Font.Style := [fsBold]
      else
        Canvas.Font.Style := [];


      // Конец вноса изменений

      if BdsHot in State then
        begin
          FillColor := FHotButtonColor;
          if BdsSelected in State then
            FillColor := GetShadowColor(FillColor, -10);
          EdgeColor := GetShadowColor(FillColor);
        end
      else if BdsSelected in State then
        begin
          FillColor := FSelectedButtonColor;
          EdgeColor := GetShadowColor(FillColor);
        end
      else
        begin
          FillColor := FRegularButtonColor;
          if (BdsFocused in State) then
            EdgeColor := GetShadowColor(FSelectedButtonColor)
          else
            EdgeColor := ClWhite; // Внёс изменения
        end;

      Canvas.Brush.Color := FillColor;
      if FillColor <> ClNone then
        begin
          Canvas.FillRect(Rect);
          { Draw the edge outline }
          Canvas.Brush.Color := EdgeColor;
          Canvas.FrameRect(Rect);
        end;

      if BdsFocused in State then
        begin
          InflateRect(Rect, -1, -1);
          Canvas.FrameRect(Rect);
        end;

      Canvas.Brush.Color := FillColor;

      { Compute the text location }
      TextLeft := Rect.Left + 1; // Внёс изменения
      RectHeight := Rect.Bottom - Rect.Top;
      TextTop := Rect.Top + (RectHeight - Canvas.TextHeight('Wg')) div 2;

      if BoFullSize in ButtonOptions then
        Inc(TextLeft, 4); // indent, slightly

      if TextTop < Rect.Top then
        TextTop := Rect.Top;
      if BdsDown in State then
        begin
          Inc(TextTop);
          Inc(TextLeft);
        end;

      { Draw the icon - prefer the event }
      TextOffset := 0;
      if Assigned(FOnDrawIcon) then
        FOnDrawIcon(Self, Button, Canvas, OrgRect, State, TextOffset)
      else if (FImages <> nil) and (Button.ImageIndex > -1) and (Button.ImageIndex < FImages.Count) then
        begin
          ImgTop := Rect.Top + (RectHeight - FImages.Height) div 2;
          if ImgTop < Rect.Top then
            ImgTop := Rect.Top;
          if BdsDown in State then
            Inc(ImgTop);

          // Добавил отображения доп. иконок

          if (FImages <> nil) and (Button.CImageIndex > -1) and (Button.CImageIndex < FImages.Count) then
            begin
              FImages.Draw(Canvas, TextLeft + Rect.Right - 27, ImgTop, Button.CImageIndex);
            end;
          if (FImages <> nil) and (Button.XImageIndex > -1) and (Button.XImageIndex < FImages.Count) then
            begin
              TextLeft := TextLeft + 17;
              FImages.Draw(Canvas, TextLeft - 18, ImgTop, Button.ImageIndex);
              FImages.Draw(Canvas, TextLeft, ImgTop, Button.XImageIndex);
            end
          else
            FImages.Draw(Canvas, TextLeft - 1, ImgTop, Button.ImageIndex);
          TextOffset := FImages.Width + 3;

          // Конец изменений

        end;

      { Show insert indications }
      if [BdsInsertLeft, BdsInsertTop, BdsInsertRight, BdsInsertBottom] * State <> [] then
        begin
          Canvas.Brush.Color := GetShadowColor(EdgeColor);
          InsertIndication := Rect;
          if BdsInsertLeft in State then
            begin
              Dec(InsertIndication.Left, 2);
              InsertIndication.Right := InsertIndication.Left + 2;
            end
          else if BdsInsertTop in State then
            begin
              Dec(InsertIndication.Top);
              InsertIndication.Bottom := InsertIndication.Top + 2;
            end
          else if BdsInsertRight in State then
            begin
              Inc(InsertIndication.Right, 2);
              InsertIndication.Left := InsertIndication.Right - 2;
            end
          else if BdsInsertBottom in State then
            begin
              Inc(InsertIndication.Bottom);
              InsertIndication.Top := InsertIndication.Bottom - 2;
            end;
          Canvas.FillRect(InsertIndication);
          Canvas.Brush.Color := FillColor;
        end;

      if BoShowCaptions in FButtonOptions then
        begin
          if FillColor = ClNone then
            Canvas.Brush.Style := BsClear;

          { Avoid clipping the image }
          Inc(TextLeft, TextOffset);
          TextRect.Left := TextLeft;
          TextRect.Right := Rect.Right - 20; // Внёс изменения
          TextRect.Top := TextTop;
          TextRect.Bottom := Rect.Bottom - 1; // Внёс изменения

          if Assigned(FOnDrawText) then
            FOnDrawText(Self, Button, Canvas, TextRect, State)
          else
            begin
              Caption := Button.Caption;
              Canvas.TextRect(TextRect, Caption, [TfEndEllipsis, TfVerticalCenter]);
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
      FCollapsedHeight := Canvas.TextHeight('Wg'); { Do not localize }
      FGutterSize := FCollapsedHeight + 1 { Border around the text } ;
      FScrollSize := FButtonHeight;

      VertInOpt := BoVerticalCategoryCaptions in ButtonOptions;
      if ((FButtonFlow = CbfVertical) and VertInOpt) or ((FButtonFlow = CbfHorizontal) and not VertInOpt) then
        FSideBufferSize := FGutterSize + 8
      else
        FSideBufferSize := 8;
    end;
end;

{$IFDEF CLR}

[UIPermission(SecurityAction.LinkDemand, Window = UIPermissionWindow.AllWindows)]

{$ENDIF}

procedure TCategoryButtons.CreateHandle;
begin
  inherited CreateHandle;
  CalcBufferSizes;
  Resize;
end;

procedure TCategoryButtons.WMMouseLeave(var message: TMessage);
begin
  FMouseInControl := False;
  if FHotButton <> nil then
    begin
      UpdateButton(FHotButton);
      FHotButton := nil;
      DoHotButton;
    end;
  { if FDragImageList.Dragging then
    begin
    FDragImageList.HideDragImage;
    RemoveInsertionPoints;
    UpdateWindow(Handle);
    FDragImageList.ShowDragImage;
    end; }
end;

procedure TCategoryButtons.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
  LastDown: TButtonItem;
  DownCategory: TButtonCategory;
begin
  inherited;
  if Button = MbLeft then
    begin
      // FDragStarted := False;
      DownCategory := GetCategoryAt(X, Y);
      FDownButton := GetButtonAt(X, Y, DownCategory);

      { Focus ourselves, when clicked, like a button would, but
        after setting the FDownButton }
      if (not Focused) and CanFocus then
        Windows.SetFocus(Handle);

      if FDownButton <> nil then
        begin
          SetSelectedItem(FDownButton);
          // FDragButton := FDownButton;
          // FDragStartPos := Point(X, Y);
          UpdateButton(FDownButton);
        end
      else if DownCategory <> nil then
        begin
          SetSelectedItem(DownCategory);
          { if GetAllowReorder then
            begin
            FDragCategory := DownCategory;
            FDragStartPos := Point(X, Y);
            end; }
        end;

      // Перенёс событие MouseUp сюда для более правильного выбора пунктов

      if Button = MbLeft then
        begin
          LastDown := FDownButton;
          FDownButton := nil;
          // FDragButton := nil;
          // FDragCategory := nil;
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
                    DownCategory.Collapsed := not DownCategory.Collapsed;
                end;
            end;
          Click;
        end;

      // Конец события MouseUp

    end;
end;

(* procedure TCategoryButtons.BeginAutoDrag;
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
  end; *)

procedure TCategoryButtons.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewHotButton, OldHotButton: TButtonItem;
  EventTrack: TTrackMouseEvent;
  // DragThreshold: Integer;
begin
  inherited;
  { Was the drag threshold met? }
  (* if (GetAllowReorder) and
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
    end; *)

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

      EventTrack.CbSize := Marshal.SizeOf(TypeOf(TTrackMouseEvent));

{$ELSE}

      EventTrack.CbSize := SizeOf(TTrackMouseEvent);

{$IFEND}

      EventTrack.DwFlags := TME_LEAVE;
      EventTrack.HwndTrack := Handle;
      EventTrack.DwHoverTime := 0;
      TrackMouseEvent(EventTrack);
    end;
end;

procedure TCategoryButtons.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
{ var
  R: TRect;
  LastDown: TButtonItem;
  DownCategory: TButtonCategory; }
begin
  inherited;
  { if (Button = mbLeft) and (not FDragStarted) then
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
    end; }
  // FDragStarted := False;
end;

function TCategoryButtons.GetButtonAt(X, Y: Integer; Category: TButtonCategory = nil): TButtonItem;
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
      if FButtonFlow = CbfVertical then
        Y := Y + GetScrollOffset { Amount hidden }
      else
        X := X + GetScrollOffset;
      GetCategoryBounds(Category, Category.StartOffset, CategoryBounds, ButtonBounds);
      if (X >= ButtonBounds.Left) and (X <= ButtonBounds.Right) and (Y >= ButtonBounds.Top) and (Y <= ButtonBounds.Bottom) then
        begin
          { Find out which button it is. }
          Row := (Y - ButtonBounds.Top) div FButtonHeight;
          if (FButtonFlow = CbfVertical) and (BoFullSize in FButtonOptions) then
            Col := 0
          else
            begin
              Col := (X - ButtonBounds.Left) div FButtonWidth;
              if ButtonBounds.Left + (Col + 1) * FButtonWidth > ButtonBounds.Right then
                Exit; { Not within the bounds }
            end;

          if FButtonFlow = CbfVertical then
            ButtonsPerRow := CalcButtonsPerRow
          else
            ButtonsPerRow := (ButtonBounds.Right - ButtonBounds.Left) div FButtonWidth;
          ResIndex := Row * ButtonsPerRow + Col;
          if ResIndex < Category.Items.Count then
            Result := Category.Items[ResIndex];
        end;
    end;
end;

procedure TCategoryButtons.DoItemClicked(const Item: TBaseItem);
var
  Button: TButtonItem;
  LOnClick: TNotifyEvent;
begin
  if Item is TButtonItem then
    begin
      Button := Item as TButtonItem;
      LOnClick := Button.OnClick;
      if Assigned(LOnClick) and (Button.Action <> nil) and not DelegatesEqual(@LOnClick, @Button.Action.OnExecute) then
        LOnClick(Self)
      else if not(CsDesigning in ComponentState) and (Button.ActionLink <> nil) then
        Button.ActionLink.Execute(Self)
      else if Assigned(LOnClick) then
        LOnClick(Self)
      else if Assigned(FOnButtonClicked) then
        FOnButtonClicked(Self, Button);
    end
  else if (Item is TButtonCategory) and Assigned(FOnCategoryClicked) then
    FOnCategoryClicked(Self, TButtonCategory(Item));
end;

procedure TCategoryButtons.DoItemNotify(Item: TCollectionItem; Action: TCollectionNotification);
begin
  if not(CsDestroying in ComponentState) and (Action in [CnDeleting, CnExtracting]) then
    begin
      if Item = SelectedItem then
        SelectedItem := nil;
      if Item = FocusedItem then
        FocusedItem := nil;
      if Item = FDownButton then
        FDownButton := nil;
      { if Item = FDragButton then
        FDragButton := nil; }
      if Item = FHotButton then
        FHotButton := nil;
    end;
end;

procedure TCategoryButtons.DoItemUpdate(Item: TCollectionItem);
begin
  if not FIgnoreUpdate then
    begin
      if Item <> nil then
        UpdateButton(Item as TButtonItem)
      else
        begin
          Resize;
          UpdateAllButtons;
        end;
    end;

end;

(* procedure TCategoryButtons.DragDrop(Source: TObject; X, Y: Integer);
  var
  TargetButton: TButtonItem;
  TargetCategory: TButtonCategory;
  begin
  if ((boAllowReorder in ButtonOptions) and ((Source = Self) or
  ((Source is TBaseDragControlObject) and
  (TBaseDragControlObject(Source).Control = Self)))) then
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
  end; *)

procedure TCategoryButtons.DoHotButton;
begin
  if Assigned(FOnHotButton) then
    FOnHotButton(Self, FHotButton);
end;

(* procedure TCategoryButtons.GenerateDragImage;
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
  end; *)

function TCategoryButtons.GetNextButtonInGroup(const StartingItem: TBaseItem; GoForward: Boolean): TBaseItem;
var
  Category: TButtonCategory;
  NextIndex: Integer;
begin
  Result := nil;
  if StartingItem <> nil then
    begin
      Category := (StartingItem as TButtonItem).Category;
      if GoForward then
        NextIndex := StartingItem.index + 1
      else
        NextIndex := StartingItem.index - 1;

      if (NextIndex > -1) and (NextIndex < Category.Items.Count) then
        Result := Category.Items[NextIndex]; { Same category, next button in it. }
    end;
end;

{ GetTargetAt: Gives you the target insertion point in the given group.
  TargetButton may be nil, while the TargetCategory is not (or, both may be nil) }
(* procedure TCategoryButtons.GetTargetAt(X, Y: Integer;
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
  if Y < (TargetCategory.StartOffset + (TargetCategory.EndOffset - TargetCategory.StartOffset) div 2) then
  if (not TargetCategory.Collapsed) then
  TargetButton := TargetCategory.Items[0]
  end
  else
  if X < (ClientWidth div 2) then
  if (not TargetCategory.Collapsed) then
  TargetButton := TargetCategory.Items[0]
  end;
  end; *)

function TCategoryButtons.HasVerticalCaption(const Category: TButtonCategory): Boolean;
begin
  Result := True;
  if FButtonFlow = CbfVertical then
    begin
      if not(BoVerticalCategoryCaptions in ButtonOptions) or Category.Collapsed or (Category.Items = nil) or (Category.Items.Count = 0) then
        Result := False
    end
  else if not(BoVerticalCategoryCaptions in ButtonOptions) and not(Category.Collapsed or (Category.Items = nil) or (Category.Items.Count = 0)) then
    Result := False;
end;

function TCategoryButtons.GetInplaceEditBounds(const Item: TBaseItem): TRect;
var
  Button: TButtonItem;
  Category: TButtonCategory;
begin
  Result := GetButtonRect(Item);
  if Item is TButtonItem then
    begin
      Button := TButtonItem(Item);
      InflateRect(Result, -3, -3);
      Inc(Result.Left, 2);
      if (FImages <> nil) and (Button.ImageIndex > -1) and (Button.ImageIndex < FImages.Count) then
        Inc(Result.Left, FImages.Width + 1);
    end
  else if Item is TButtonCategory then
    begin
      Category := TButtonCategory(Item);
      AdjustCategoryBounds(Category, Result, True);
      InflateRect(Result, -3, -1);
      Inc(Result.Top, 1);
      Inc(Result.Left, 14);
    end;
end;

procedure TCategoryButtons.CNKeydown(var message: TWMKeyDown);
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

          Col := Col + LastRow * ButtonsPerRow;

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
  if FButtonFlow = CbfVertical then
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
    Category := TButtonItem(CurrentItem).Category
  else
    Category := CurrentItem as TButtonCategory;

  ButtonsPerRow := CalcActualButtonsPerRow(Category);

  if Distance <= 0 then
    Distance := ButtonsPerRow;

  if CurrentItem is TButtonItem then
    begin
      if not Category.Collapsed then
        begin
          // Look for next or previous button first
          if GoForward then
            Result := CurrentItem.GetNextSibling(Distance)
          else
            Result := CurrentItem.GetPrevSibling(Distance);
        end;

      if (Result = nil) or Category.Collapsed then
        begin
          // If no button was found, try a category
          if GoForward then
            Result := Category.GetNextSibling
          else
            Result := Category;
        end
    end
  else if CurrentItem is TButtonCategory then
    begin
      if GoForward then
        begin
          if not Category.Collapsed and (Category.Items.Count > 0) then
            Result := Category.Items[0] as TBaseItem
          else
            Result := CurrentItem.GetNextSibling;
        end
      else
        begin
          Result := CurrentItem.GetPrevSibling;
          Category := Result as TButtonCategory;
          // Return the last button in the previous category if it isn't collapsed
          if (Result <> nil) and not Category.Collapsed and (Category.Items.Count > 0) then
            Result := Category.Items[Category.Items.Count - 1] as TBaseItem;
        end;
    end;
end;

function CtrlIsDown: Boolean;
begin
  Result := SsCtrl in KeyboardStateToShiftState;
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
  else if NewTop > FButtonCategories[FButtonCategories.Count - 1].EndOffset then
    NewTop := FButtonCategories[FButtonCategories.Count - 1].EndOffset - 1;

  { Find where this is at }
  NewCat := nil;
  for I := 0 to FButtonCategories.Count - 1 do
    begin
      if (FButtonCategories[I].Items.Count > 0) and (NewTop < FButtonCategories[I].EndOffset) then
        begin
          NewCat := FButtonCategories[I];
          Break;
        end;
    end;

  if NewCat <> nil then
    begin
      GetCategoryBounds(NewCat, NewCat.StartOffset, TempBounds, ButtonBounds);
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
  I: Integer;
  NewItem: TBaseItem;
  Button: TButtonItem;
  Category: TButtonCategory;
begin
  CurrentItem := FSelectedItem;
  if (CurrentItem = nil) and (FFocusedItem <> nil) then
    CurrentItem := FFocusedItem;
  NewItem := nil;
  case message.CharCode of
    VK_SUBTRACT: if CurrentItem is TButtonCategory then
        TButtonCategory(CurrentItem).Collapsed := True;
    VK_ADD: if CurrentItem is TButtonCategory then
        TButtonCategory(CurrentItem).Collapsed := False;
    VK_MULTIPLY: for I := 0 to Categories.Count - 1 do
        Categories[I].Collapsed := False;
    VK_DOWN: NewItem := GetNext(True);
    VK_UP: NewItem := GetNext(False);
    VK_LEFT: begin
        if CurrentItem is TButtonItem then
          begin
            Button := CurrentItem as TButtonItem;
            if CtrlIsDown and not Button.Category.Collapsed then
              Button.Category.Collapsed := True
            else if CalcActualButtonsPerRow(Button.Category) = 1 then
              NewItem := Button.Category
            else
              NewItem := GetNext(False, 1);
          end
        else if CurrentItem is TButtonCategory then
          begin
            Category := CurrentItem as TButtonCategory;
            if not Category.Collapsed then
              begin
                Category.Collapsed := True;
                NewItem := CurrentItem;
              end
            else
              NewItem := GetNext(False, 1);
          end;
      end;
    VK_RIGHT: begin
        if CurrentItem is TButtonItem then
          begin
            Button := CurrentItem as TButtonItem;
            if CtrlIsDown and Button.Category.Collapsed then
              Button.Category.Collapsed := False
            else
              NewItem := GetNext(True, 1)
          end
        else if CurrentItem is TButtonCategory then
          begin
            Category := CurrentItem as TButtonCategory;
            if Category.Collapsed then
              Category.Collapsed := False
            else
              NewItem := GetNext(True, 1);
          end;
      end;
    VK_NEXT: NewItem := ChangePage(True);
    VK_PRIOR: NewItem := ChangePage(False);
    VK_RETURN: if IsEditing then
        EndEdit(False)
      else if (CurrentItem is TButtonItem) then
        begin
          Button := CurrentItem as TButtonItem;
          if Button.Category.Collapsed then
            Button.Category.Collapsed := False;
          SelectedItem := CurrentItem;
          DoItemClicked(CurrentItem)
        end;
    VK_HOME: if Categories.Count > 0 then
        NewItem := Categories[0];
    VK_END: if Categories.Count > 0 then
        begin
          NewItem := Categories[Categories.Count - 1];
          Category := NewItem as TButtonCategory;
          if not Category.Collapsed and (Category.Items.Count > 0) then
            NewItem := Category.Items[Category.Items.Count - 1];
        end;
    VK_ESCAPE: if IsEditing then
        EndEdit(True);
  else inherited;
  end;
  if NewItem <> nil then
    begin
      UpdateButton(FHotButton);
      FHotButton := nil;
      SelectedItem := NewItem;
    end;
end;

procedure TCategoryButtons.WndProc(var message: TMessage);
var
  P: TPoint;

{$IF DEFINED(CLR)}

  MouseMsg: TWMMouse;

{$IFEND}

begin
  case message.Msg of
    WM_LBUTTONDOWN, WM_RBUTTONDOWN, WM_MBUTTONDOWN:
      // Clicking anywhere outside the inplace edit control ends editing
      if IsEditing then
        begin

{$IF DEFINED(CLR)}

          MouseMsg := TWMMouse.Create(message);
          P := ClientToScreen(Point(MouseMsg.XPos, MouseMsg.YPos));

{$ELSE}

          P := ClientToScreen(Point(TWMMouse(message).XPos, TWMMouse(message).YPos));

{$IFEND}

          if not PtInRect(FInplaceEdit.ClientRect, P) then
            EndEdit(False);
        end;
    WM_NCLBUTTONDOWN, WM_NCRBUTTONDOWN, WM_NCMBUTTONDOWN, WM_DESTROY, WM_MOUSEWHEEL, WM_CANCELMODE, WM_SIZE: if IsEditing then
        EndEdit(False);
    WM_KILLFOCUS: if IsEditing and not((THandle(message.WParam) = FInplaceEdit.Handle) or (THandle(message.WParam) = Handle)) then
        // FInplaceEdit passes this to us
        EndEdit(False);
  end;
  inherited WndProc(message);
end;

procedure TCategoryButtons.ScrollIntoView(const Item: TBaseItem);
var
  Button: TButtonItem;
begin
  if Item is TButtonItem then
    begin
      Button := Item as TButtonItem;
      if Button.Category.Collapsed then
        ScrollIntoView(Button.Category)
      else
        ScrollRectIntoView(Item.Bounds, True);
    end
  else if Item is TButtonCategory then
    ScrollRectIntoView(GetCategoryRect(TButtonCategory(Item)), True);
end;

procedure TCategoryButtons.CMHintShow(var message: TCMHintShow);
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
  message.Result := 1; { Don't show the hint }
  if message.HintInfo.HintControl = Self then
    begin
      with message.HintInfo.CursorPos do
        begin
          CurrentCat := GetCategoryAt(X, Y);
          CurrentItem := GetButtonAt(X, Y, CurrentCat);
        end;

      Handled := False;
      HintStr := '';
      if Assigned(FOnGetHint) then
        FOnGetHint(Self, CurrentItem, CurrentCat, HintStr, Handled);
      LHintInfo := message.HintInfo;
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

          // Изменения

          if not Handled then
            HintStr := '<b>' + CurrentCat.GroupCaption + '</b>';
          {if CurrentCat.GroupType > EmptyStr then
            HintStr := HintStr + '<BR>' + CurrentCat.GroupType;}

          // Конец изменений

          CatRect := GetCategoryRect(CurrentCat);
          if not CurrentCat.Collapsed then { exclude the button area on the right }
            CatRect.Right := CatRect.Left + FGutterSize;
          LHintInfo.CursorRect := CatRect;

          Handled := True;
        end;
      if Handled then
        begin
          LHintInfo.HintStr := HintStr;
          message.Result := 0; { Show the hint }
        end;

{$IF DEFINED(CLR)}

      message.HintInfo := LHintInfo;

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

{ SetInsertionButton: Call this to set the current insertion "marks".
  Call RemoveInsertionPoints to remove the "marks". }
(* procedure TCategoryButtons.SetInsertionButton(InsertionButton: TButtonItem;
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
  end; *)

procedure TCategoryButtons.DoGesture(const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  if EventInfo.GestureID = IgiPan then
    begin
      Handled := True;
      if GfBegin in EventInfo.Flags then
        FPanPoint := EventInfo.Location
      else if not(GfEnd in EventInfo.Flags) then
        begin
          if (EventInfo.Location.Y - FPanPoint.Y) > 0 then
            ScrollPosChanged(ScLineUp, (EventInfo.Location.Y - FPanPoint.Y))
          else
            ScrollPosChanged(ScLineDown, (EventInfo.Location.Y - FPanPoint.Y));
          FPanPoint := EventInfo.Location

        end;
    end;
end;

procedure TCategoryButtons.SetSelectedItem(const Value: TBaseItem);

procedure UpdateCategory(const Category: TButtonCategory);
var
  R: TRect;
begin
  if HandleAllocated then
    begin
      R := GetCategoryRect(Category);
      InvalidateRect(Handle, R, False);
    end;
end;

var
  ButtonRect: TRect;
  Button: TButtonItem;
begin
  if FSelectedItem <> Value then
    begin
      if FFocusedItem <> Value then
        UpdateButton(FFocusedItem);

      if (FSelectedItem is TButtonItem) then
        begin
          UpdateButton(FSelectedItem);
          Button := FSelectedItem as TButtonItem;
          if Button.Category.Collapsed then
            UpdateCategory(Button.Category)
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
          if (FSelectedItem is TButtonItem) then
            begin
              Button := FSelectedItem as TButtonItem;
              if Button.Category.Collapsed then
                UpdateCategory(Button.Category);
            end;
        end;
      if not(CsDestroying in ComponentState) then
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
      if FButtonCategories[CatIndex].EndOffset >= TopPos then
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
      if FButtonFlow = CbfVertical then
        CurrentPos := Y + GetScrollOffset
      else
        CurrentPos := X + GetScrollOffset;
      { Find out which category this X or Y position would lie in }
      for I := 0 to FButtonCategories.Count - 1 do
        begin
          if CurrentPos <= FButtonCategories[I].EndOffset then
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
  if FButtonFlow = CbfVertical then
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
      ScrollPosChanged(ScPosition, FScrollBarPos - Amount);
    end
  else if (RectStart > MaxSize) or (RectEnd > MaxSize) then
    begin
      // Scrolling up into view
      if (RectEnd - RectStart > MaxSize) or PlaceOnTop then
        CalcAmount(RectStart, False) { Put the start into view at the top }
      else
        CalcAmount(RectEnd - MaxSize);
      { Put the whole thing into view at the bottom }

      if FScrollBarPos + Amount > FScrollBarMax then
        ScrollPosChanged(ScPosition, FScrollBarMax)
      else
        ScrollPosChanged(ScPosition, FScrollBarPos + Amount);
    end;
end;

function TCategoryButtons.GetCategoryRect(const Category: TButtonCategory; ButtonOnly: Boolean = False): TRect;
var
  YPos: Integer;
  ButtonBounds: TRect;
begin
  Result := Rect(0, 0, 0, 0);
  YPos := Category.StartOffset - GetScrollOffset;
  GetCategoryBounds(Category, YPos, Result, ButtonBounds);
  if ButtonOnly then
    AdjustCategoryBounds(Category, Result);
end;

function TCategoryButtons.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
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
        ScrollPosChanged(ScLineUp, 0)
      else if (FScrollBarMax > 0) and (SsCtrl in Shift) then
        ScrollPosChanged(ScPageUp, 0)
      else if SsShift in Shift then
        begin
          NextButton := GetNextButton(SelectedItem, False);
          if NextButton <> nil then
            SelectedItem := NextButton;
        end;
    end;
end;

function TCategoryButtons.GetNextButton(const StartingItem: TBaseItem; GoForward: Boolean): TBaseItem;

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
  if StartingItem <> nil then
    begin
      Result := GetNextButtonInGroup(StartingItem, GoForward);
      if Result = nil then
        begin
          if GoForward then
            begin
              for I := (StartingItem as TButtonItem).Category.index + 1 to FButtonCategories.Count - 1 do
                begin
                  Result := ProcessCategory(FButtonCategories[I]);
                  if Result <> nil then
                    Break;
                end
            end
          else
            begin
              for I := (StartingItem as TButtonItem).Category.index - 1 downto 0 do
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

function TCategoryButtons.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
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
        ScrollPosChanged(ScLineDown, 0)
      else if (FScrollBarMax > 0) and (SsCtrl in Shift) then
        ScrollPosChanged(ScPageDown, 0)
      else if SsShift in Shift then
        begin
          NextButton := GetNextButton(SelectedItem, True);
          if NextButton <> nil then
            SelectedItem := NextButton;
        end;
    end;
end;

{ procedure TCategoryButtons.DoReorderCategory(const SourceCategory,
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
  end; }

procedure TCategoryButtons.SetFocusedItem(const Value: TBaseItem);
begin
  if FFocusedItem <> Value then
    begin
      FFocusedItem := Value;
      Invalidate;
    end;
end;

procedure TCategoryButtons.DoSelectedItemChanged(const Item: TBaseItem);
begin
  if (Item = nil) or (Item is TButtonItem) then
    begin
      if Assigned(FOnSelectedButtonChange) then
        FOnSelectedButtonChange(Self, TButtonItem(Item))
    end
  else if Item is TButtonCategory and Assigned(FOnSelectedCategoryChange) then
    FOnSelectedCategoryChange(Self, TButtonCategory(Item))
end;

procedure TCategoryButtons.DoCopyButton(const Button: TButtonItem; const TargetCategory: TButtonCategory; const TargetButton: TButtonItem);
var
  CopiedButton: TButtonItem;
begin
  CopiedButton := TargetCategory.Items.Add;
  if TargetButton <> nil then
    CopiedButton.index := TargetButton.index;
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
          Windows.ShowScrollBar(Handle, CScrollBarKind[OldFlow], False);
        end
      else
        begin
          { We have to resize }
          Resize;
          Invalidate;
        end;
    end;
end;

procedure TCategoryButtons.SetGradientDirection(const Value: TGradientDirection);
begin
  if FGradientDirection <> Value then
    begin
      FGradientDirection := Value;
      Invalidate;
    end;
end;

procedure TCategoryButtons.WMKillFocus(var message: TWMKillFocus);
begin
  inherited;
  if not(CsDestroying in ComponentState) then
    UpdateButton(FFocusedItem);
end;

procedure TCategoryButtons.WMSetFocus(var message: TWMSetFocus);
begin
  inherited;
  UpdateButton(FFocusedItem);
end;

procedure TCategoryButtons.CMFontchanged(var message: TMessage);
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

{ procedure TCategoryButtons.SetDragButton(const Value: TButtonItem);
  begin
  // DragButton: If a drag operation is coming from this control, it is
  //  becuase they are dragging this item, or the category. One can
  //  write to it if they want to control what button is being dragged.
  FDragButton := Value;
  FDragStarted := True;
  FDragStartPos := ScreenToClient(Mouse.CursorPos);
  end;

  procedure TCategoryButtons.DoBeginDrag(Immediate: Boolean; Threshold: Integer);
  begin
  BeginDrag(Immediate, Threshold);
  end; }

function TCategoryButtons.GetAllowReorder: Boolean;
begin
  Result := BoAllowReorder in ButtonOptions;
end;

procedure TCategoryButtons.SetBackgroundGradientColor(const Value: TColor);
begin
  if FBackgroundGradientColor <> Value then
    begin
      FBackgroundGradientColor := Value;
      Invalidate;
    end;
end;

procedure TCategoryButtons.SetBackGradientDirection(const Value: TGradientDirection);
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

{ TBaseItem }

function TBaseItem.EditText: Boolean;
begin
  Result := False;
  if (Collection is TItemCollection) then
    Result := TItemCollection(Collection).CategoryButtons.Edit(Self);
end;

procedure TBaseItem.EndEdit(Cancel: Boolean);
begin
  if (Collection is TItemCollection) then
    TItemCollection(Collection).CategoryButtons.EndEdit(Cancel);
end;

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
  if index + Distance < Collection.Count then
    Result := Collection.Items[index + Distance] as TBaseItem;
end;

function TBaseItem.GetPrevSibling(Distance: Integer): TBaseItem;
begin
  Result := nil;
  if Distance = 0 then
    Distance := 1;
  if index - Distance >= 0 then
    Result := Collection.Items[index - Distance] as TBaseItem;
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

function TCategoryButtons.IsEditing: Boolean;
begin
  Result := Assigned(FInplaceEdit) and FInplaceEdit.Visible;
end;

function TCategoryButtons.IsTouchPropertyStored(AProperty: TTouchProperty): Boolean;
begin
  Result := inherited IsTouchPropertyStored(AProperty);
  case AProperty of
    TpInteractiveGestures: Result := Touch.InteractiveGestures <> [IgPan, IgPressAndTap];
    TpInteractiveGestureOptions: Result := Touch.InteractiveGestureOptions <> [IgoPanInertia, IgoPanSingleFingerHorizontal, IgoPanSingleFingerVertical, IgoPanGutter, IgoParentPassthrough];
  end;
end;

function TCategoryButtons.CanEdit(Item: TBaseItem): Boolean;
begin
  Result := (Item <> nil);
  if Result then
    begin
      SetFocus;
      Result := Focused;
    end;
  if Result then
    begin
      // Buttons need to have visible captions and enough size to do editing
      if Item is TButtonItem then
        Result := ([BoFullSize, BoShowCaptions] * ButtonOptions) = [BoFullSize, BoShowCaptions]
        // Categories must be displayed horizontally
      else if Item is TButtonCategory then
        Result := not HasVerticalCaption(TButtonCategory(Item));
      if Result and Assigned(FOnEditing) then
        FOnEditing(Self, Item, Result);
    end;
end;

function TCategoryButtons.Edit(const Item: TBaseItem): Boolean;
begin
  Result := IsEditing;
  if not IsEditing and CanEdit(Item) then
    begin
      SelectedItem := Item;
      if not Assigned(FInplaceEdit) then
        FInplaceEdit := TInplaceEdit.Create(Self)
      else
        FInplaceEdit.Show;
      TInplaceEdit(FInplaceEdit).Initialize(Item, GetInplaceEditBounds(Item), FSelectedButtonColor, Item.Caption);
      Result := True;
    end;
end;

procedure TCategoryButtons.EndEdit(Cancel: Boolean);
var
  Item: TBaseItem;
  NewCaption: string;
begin
  if IsEditing then
    begin
      NewCaption := FInplaceEdit.Text;
      Item := TInplaceEdit(FInplaceEdit).Item;
      TInplaceEdit(FInplaceEdit).DeActivate;
      if not Cancel then
        begin
          if Assigned(FOnEdited) then
            FOnEdited(Self, Item, NewCaption);
          Item.Caption := NewCaption;
        end
      else if Assigned(FOnCancelEdit) then
        FOnCancelEdit(Self, Item);
    end;
end;

{ TBaseButtonItem }

constructor TBaseButtonItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FImageIndex := -1;
end;

destructor TBaseButtonItem.Destroy;
begin
  if FActionLink <> nil then
    FreeAndNil(FActionLink);
  inherited;
end;

procedure TBaseButtonItem.ActionChange(Sender: TObject; CheckDefaults: Boolean);
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

procedure TBaseButtonItem.DoActionChange(Sender: TObject);
begin
  if Sender = Action then
    ActionChange(Sender, False);
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
      ActionChange(Value, CsLoading in Value.ComponentState);
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
      InterfaceData := (Source as TButtonItem).InterfaceData;
    end
  else
    inherited Assign(Source);
end;

function TButtonItem.GetBounds: TRect;
begin
  if (Category = nil) or Category.Collapsed then
    Result := Rect(-1, -1, -1, -1)
  else
    Result := CategoryButtons.GetButtonRect(Self);
end;

function TButtonItem.GetCategoryButtons: TCategoryButtons;
begin
  Result := nil;
  if Category <> nil then
    Result := Category.Categories.CategoryButtons;
end;

function TButtonItem.GetCategory: TButtonCategory;
begin
  Result := nil;
  if Collection <> nil then
    Result := TButtonCollection(Collection).Category;
end;

function TButtonItem.GetNotifyTarget: TComponent;
begin
  Result := TComponent(CategoryButtons);
end;

procedure TButtonItem.ScrollIntoView;
begin
  CategoryButtons.ScrollIntoView(Self);
end;

{ TItemCollection }

constructor TItemCollection.Create(const ACategoryButtons: TCategoryButtons; const ItemClass: TCollectionItemClass);
begin
  inherited Create(ItemClass);
  FCategoryButtons := ACategoryButtons;
end;

procedure TItemCollection.Notify(Item: TCollectionItem; Action: TCollectionNotification);
begin
  inherited;
  CategoryButtons.DoItemNotify(Item, Action);
end;

{ TButtonCollection }

constructor TButtonCollection.Create(const ACategory: TButtonCategory);
begin
  inherited Create(ACategory.CategoryButtons, ACategory.CategoryButtons.GetButtonItemClass);
  FCategory := ACategory;
end;

function TButtonCollection.Add: TButtonItem;
begin
  Result := ( inherited Add as TButtonItem);
end;

function TButtonCollection.AddItem(Item: TButtonItem; index: Integer): TButtonItem;
begin
  if Item = nil then
    Result := CategoryButtons.GetButtonItemClass.Create(Self)
  else
    Result := Item;
  if Assigned(Result) then
    begin
      Result.Collection := Self;
      if index < 0 then
        index := Count - 1;
      Result.index := index;
    end;
end;

function TButtonCollection.GetItem(index: Integer): TButtonItem;
begin
  Result := inherited GetItem(index) as TButtonItem;
end;

function TButtonCollection.GetOwner: TPersistent;
begin
  Result := FCategory;
end;

function TButtonCollection.Insert(index: Integer): TButtonItem;
begin
  Result := AddItem(nil, index);
end;

procedure TButtonCollection.SetItem(index: Integer; const Value: TButtonItem);
begin
  inherited SetItem(index, Value);
end;

procedure TButtonCollection.Update(Item: TCollectionItem);
begin
  inherited;
  if (UpdateCount = 0) and (Category.Categories.UpdateCount = 0) then
    CategoryButtons.DoItemUpdate(Item);
end;

{ TButtonCategory }

var
  GLastPreset: Integer = 0;

constructor TButtonCategory.Create(Collection: TCollection);
{ const
  cMaxPresets = 10;
  cPresetColors: array[0..cMaxPresets-1] of TColor = ($00FFEAFF, $00F4F4F4, $00EAEBFF,
  $00FFEAFF, $00FFEAEA, $00EAFFFF, $00FFFFEA, $00EAEBFF, $00EBFFEA, $00FFEAEA); }
begin
  inherited Create(Collection);
  FGradientColor := ClNone;
  FTextColor := ClWindowText;
  FItems := TButtonCollection.Create(Self);

  // Внёс изменения

  { with TButtonCategories(Collection).CategoryButtons do
    FColor := cPresetColors[GLastPreset];
    Inc(GLastPreset);
    if GLastPreset >= cMaxPresets then
    GLastPreset := 0; }

  with TButtonCategories(Collection).CategoryButtons do
    FColor := V_GroupHeaderColor;

  // Конец изменений

end;

destructor TButtonCategory.Destroy;
begin
  if FItems <> nil then
    FItems.Clear;
  inherited;
  FreeAndNil(FItems);
end;

procedure TButtonCategory.Assign(Source: TPersistent);
var
  Category: TButtonCategory;
begin
  if Source is TButtonCategory then
    begin
      Category := Source as TButtonCategory;
      Caption := Category.Caption;
      Color := Category.Color;
      GradientColor := Category.GradientColor;
      TextColor := Category.TextColor;
      Collapsed := Category.Collapsed;
      Data := Category.Data;
      InterfaceData := Category.InterfaceData;
    end
  else
    inherited Assign(Source);
end;

function TButtonCategory.GetBounds: TRect;
begin
  Result := GetButtonRect(False);
end;

function TButtonCategory.GetButtonRect(ButtonOnly: Boolean): TRect;
begin
  if (Categories = nil) or (FItems = nil) then
    Result := Rect(-1, -1, -1, -1)
  else
    Result := Categories.CategoryButtons.GetCategoryRect(Self, ButtonOnly);
end;

function TButtonCategory.GetCategories: TButtonCategories;
begin
  Result := TButtonCategories(Collection);
end;

function TButtonCategory.GetCategoryButtons: TCategoryButtons;
begin
  Result := (Collection as TItemCollection).CategoryButtons;
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
  Categories.CategoryButtons.ScrollIntoView(Self);
end;

procedure TButtonCategory.SetCollapsed(const Value: Boolean);
begin
  if FCollapsed <> Value then
    begin
      FCollapsed := Value;
      Changed(True);
      if not FCollapsed then
        ScrollIntoView;
      if Assigned(Categories.CategoryButtons.OnCategoryCollapase) then
        Categories.CategoryButtons.OnCategoryCollapase(Categories.CategoryButtons, Self);
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
  if Value <> index then
    begin
      if index < Categories.Count then
        TargetCategory := Categories[Value]
      else
        TargetCategory := nil;
      inherited;
      ScrollIntoView;
      if Assigned(Categories.CategoryButtons.OnReorderCategory) then
        Categories.CategoryButtons.OnReorderCategory(Categories.CategoryButtons, Self, TargetCategory);
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

{ TButtonCategories }

constructor TButtonCategories.Create(const CategoryButtons: TCategoryButtons);
begin
  inherited Create(CategoryButtons, CategoryButtons.GetButtonCategoryClass);
  FOriginalID := -1;
end;

function TButtonCategories.Add: TButtonCategory;
begin
  Result := inherited Add as TButtonCategory;
end;

function TButtonCategories.AddItem(Item: TButtonCategory; index: Integer): TButtonCategory;
begin
  if Item = nil then
    Result := CategoryButtons.GetButtonCategoryClass.Create(Self)
  else
    Result := Item;
  if Assigned(Result) then
    begin
      Result.Collection := Self;
      if index < 0 then
        index := Count - 1;
      Result.index := index;
    end;
end;

procedure TButtonCategories.BeginUpdate;
begin
  if UpdateCount = 0 then
    if CategoryButtons.SelectedItem <> nil then
      FOriginalID := CategoryButtons.SelectedItem.ID
    else
      FOriginalID := -1;
  inherited;
end;

function TButtonCategories.GetItem(index: Integer): TButtonCategory;
begin
  Result := inherited GetItem(index) as TButtonCategory;
end;

function TButtonCategories.GetOwner: TPersistent;
begin
  Result := CategoryButtons;
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

function TButtonCategories.Insert(index: Integer): TButtonCategory;
begin
  Result := AddItem(nil, index);
end;

function TButtonCategories.ItemAt(const index: Integer): TBaseItem;
var
  I: Integer;
  ItemCount: Integer;
begin
  Result := nil;
  ItemCount := -1;
  for I := 0 to Count - 1 do
    begin
      Inc(ItemCount);
      if ItemCount = index then
        begin
          Result := Items[I];
          Break;
        end;
      if Items[I].Collapsed then
        Continue
      else
        Inc(ItemCount, Items[I].Items.Count);
      if index <= ItemCount then
        begin
          Result := Items[I].Items[index - (ItemCount - Items[I].Items.Count + 1)];
          Break;
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
  if CategoryButtons.CurrentCategory <> nil then
    begin
      CatBasedIndex := CategoryButtons.CurrentCategory.IndexOf(Caption);
      if CatBasedIndex <> -1 then
        begin
          Item := CategoryButtons.CurrentCategory.Items[CatBasedIndex];
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

procedure TButtonCategories.SetItem(index: Integer; const Value: TButtonCategory);
begin
  inherited SetItem(index, Value);
end;

function TButtonCategories.GetUpdateCount: Integer;
begin
  Result := inherited UpdateCount;
end;

procedure TButtonCategories.Update(Item: TCollectionItem);
begin
  inherited;
  CategoryButtons.DoItemUpdate(nil);
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
  Result := inherited IsCaptionLinked and (FClient.Caption = (Action as TCustomAction).Caption);
end;

function TButtonItemActionLink.IsHintLinked: Boolean;
begin
  Result := inherited IsHintLinked and (FClient.Hint = (Action as TCustomAction).Hint);
end;

function TButtonItemActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and (FClient.ImageIndex = (Action as TCustomAction).ImageIndex);
end;

function TButtonItemActionLink.IsOnExecuteLinked: Boolean;
begin
  Result := inherited IsOnExecuteLinked and (((not Assigned(FClient.OnClick)) and (not Assigned(Action.OnExecute))) or (Assigned(FClient.OnClick) and DelegatesEqual(@FClient.OnClick,
        @Action.OnExecute)));
end;

procedure TButtonItemActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then
    FClient.Caption := Value;
end;

procedure TButtonItemActionLink.SetHint(const Value: string);
begin
  if IsHintLinked then
    FClient.Hint := Value;
end;

procedure TButtonItemActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then
    FClient.ImageIndex := Value;

  // Добавил записи для доп. иконок

  if IsImageIndexLinked then
    FClient.XImageIndex := Value;
  if IsImageIndexLinked then
    FClient.CImageIndex := Value;
end;

procedure TButtonItemActionLink.SetOnExecute(Value: TNotifyEvent);
begin
  if IsOnExecuteLinked then
    FClient.OnClick := Value;
end;

{$IF NOT DEFINED(CLR)}

(* initialization
  { Add our drag/copy cursor image }
  Screen.Cursors[crDragCopy] := LoadCursor(HInstance, 'CAT_DRAG_COPY'); { Do not localize }
  finalization
  { Free the drag/copy cursor image }
  DestroyCursor(Screen.Cursors[crDragCopy]); *)

{$IFEND}

end.
