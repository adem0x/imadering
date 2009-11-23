// Изменения для проекта IMadering

{ Version 9.46 }
{ ********************************************************* }
{ *                     HTMLVIEW.PAS                      * }
{ ********************************************************* }
{
  Copyright (c) 1995-2008 by L. David Baldwin

  Permission is hereby granted, free of charge, to any person obtaining a copy of
  this software and associated documentation files (the "Software"), to deal in
  the Software without restriction, including without limitation the rights to
  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
  of the Software, and to permit persons to whom the Software is furnished to do
  so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

  Note that the source modules, HTMLGIF1.PAS, PNGZLIB1.PAS, DITHERUNIT.PAS, and
  URLCON.PAS are covered by separate copyright notices located in those modules.
}

{$I htmlcons.inc}

unit Htmlview;

interface

uses
  SysUtils,
  Windows,
  Messages,
  Classes,
  Graphics,
  Controls,
  StdCtrls,
  HTMLUn2,
  Forms,
  Dialogs,
  ExtCtrls,
  ReadHTML,
  HTMLSubs,
  StyleUn,
  Menus,
  GDIPL2A;

const
  Wm_FormSubmit = Wm_User + 100;
  Wm_MouseScroll = Wm_User + 102;
  Wm_UrlAction = Wm_User + 103;

type
  THTMLViewer = class;

  THTMLBorderStyle = (HtFocused, HtNone, HtSingle);

  TRightClickParameters = class(TObject)
    URL, Target: string;
    Image: TImageObj;
    ImageX, ImageY: Integer;
    ClickWord: WideString;
  end;

  TRightClickEvent = procedure(Sender: TObject; Parameters: TRightClickParameters) of object;
  THotSpotEvent = procedure(Sender: TObject; const SRC: string) of object;
  THotSpotClickEvent = procedure(Sender: TObject; const SRC: string; var Handled: Boolean) of object;
  TProcessingEvent = procedure(Sender: TObject; ProcessingOn: Boolean) of object;
  TImageClickEvent = procedure(Sender, Obj: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer) of object;
  TImageOverEvent = procedure(Sender, Obj: TObject; Shift: TShiftState; X, Y: Integer) of object;
  TMetaRefreshType = procedure(Sender: TObject; Delay: Integer; const URL: string) of object;
  TParseEvent = procedure(Sender: TObject; var Source: string) of object;

  HtOptionEnum = (HtOverLinksActive, HtNoLinkUnderline, HtPrintTableBackground, HtPrintBackground, HtPrintMonochromeBlack,
    HtShowDummyCaret, HtShowVScroll, HtNoWheelMouse, HtNoLinkHilite);
  ThtmlViewerOptions = set of HtOptionEnum;
  ThtProgressEvent = procedure(Sender: TObject; Stage: TProgressStage; PercentDone: Integer) of object;

  TPaintPanel = class(TCustomPanel)
  private
    FOnPaint: TNotifyEvent;
    FViewer: THTMLViewer;
    Canvas2: TCanvas;
    procedure WMEraseBkgnd(var message: TWMEraseBkgnd);
    message WM_EraseBkgnd;
    procedure WMLButtonDblClk(var message: TWMMouse);
    message WM_LButtonDblClk;
    procedure DoBackground(ACanvas: TCanvas);
    constructor CreateIt(AOwner: TComponent; Viewer: THTMLViewer);
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;

  public
    procedure Paint; override;
  end;

  T32ScrollBar = class(TScrollBar) { a 32 bit scrollbar }
  private
    FPosition: Integer;
    FMin, FMax, FPage: Integer;
    procedure SetPosition(Value: Integer);
    procedure SetMin(Value: Integer);
    procedure SetMax(Value: Integer);
    procedure CNVScroll(var message: TWMVScroll);
    message CN_VSCROLL;

  public
    property Position: Integer read FPosition write SetPosition;
    property Min: Integer read FMin write SetMin;
    property Max: Integer read FMax write SetMax;
    procedure SetParams(APosition, APage, AMin, AMax: Integer);
  end;

  ThtmlFileType = (HTMLType, TextType, ImgType, OtherType);

  THTMLViewer = class(TWinControl)
  private
    FScaleX, FScaleY: Single;
    FCodePage: Integer;
    function GetCursor: TCursor;
    procedure SetCursor(Value: TCursor);

  protected
    InCreate: Boolean;
    FOnDragDrop: TDragDropEvent;
    FOnDragOver: TDragOverEvent;
    DontDraw: Boolean;
    FTitle: string;
    FURL: string;
    FTarget: string;
    FBase, FBaseEx: string;
    FBaseTarget: string;
    FCurrentFile: string;
    FNameList: TStringList;
    FCurrentFileType: ThtmlFileType;
    FOnHotSpotCovered: THotSpotEvent;
    FOnHotSpotClick: THotSpotClickEvent;
    FOnBitmapRequest: TGetBitmapEvent;
    FOnImageRequest: TGetImageEvent;
    FOnScript: TScriptEvent;
    FOnFormSubmit: TFormSubmitEvent;
    FOnHistoryChange: TNotifyEvent;
    FOnProcessing: TProcessingEvent;
    FOnInclude: TIncludeType;
    FOnSoundRequest: TSoundType;
    FOnLink: TLinkType;
    FOnMeta: TMetaType;
    FOnMetaRefresh: TMetaRefreshType;
    FOnPanelCreate: TPanelCreateEvent;
    FOnPanelDestroy: TPanelDestroyEvent;
    FOnPanelPrint: TPanelPrintEvent;
    FRefreshURL: string;
    FRefreshDelay: Integer;
    FOnRightClick: TRightClickEvent;
    FOnImageClick: TImageClickEvent;
    FOnImageOver: TImageOverEvent;
    FOnObjectClick: TObjectClickEvent;
    FOnFileBrowse: TFileBrowseEvent;
    FOnObjectFocus: ThtObjectEvent;
    FOnObjectBlur: ThtObjectEvent;
    FOnObjectChange: ThtObjectEvent;
    FOnProgress: ThtProgressEvent;
    FHistory, FTitleHistory: TStrings;
    FPositionHistory: TFreeList;
    FHistoryIndex: Integer;
    FHistoryMaxCount: Integer;
    FFontName: TFontName;
    FPreFontName: string;
    FFontColor: TColor;
    FHotSpotColor, FVisitedColor, FOverColor: TColor;
    FVisitedMaxCount: Integer;
    FBackGround: TColor;
    FFontSize: Integer;
    FProcessing: Boolean;
    FAction, FFormTarget, FEncType, FMethod: string;
    FStringList: TStringList;
    FImageCacheCount: Integer;
    FNoSelect: Boolean;
    FScrollBars: TScrollStyle;
    FBorderStyle: THTMLBorderStyle;
    FDither: Boolean;
    FCaretPos: Integer;
    FOptions: ThtmlViewerOptions;
    SbWidth: Integer;
    ScrollWidth: Integer;
    FMaxVertical: Integer;
    MouseScrolling: Boolean;
    LeftButtonDown: Boolean;
    MiddleScrollOn: Boolean;
    MiddleY: Integer;
    Hiliting: Boolean;
    FPrintMarginLeft, FPrintMarginRight, FPrintMarginTop, FPrintMarginBottom: Double;
    FCharset: TFontCharset;
    FOnMouseDouble: TMouseEvent;
    HotSpotAction: Boolean;
    FMarginHeight, FMarginWidth: Integer;
    FServerRoot: string;
    FSectionList: TSectionList;
    FImageStream: TMemoryStream;
    FOnExpandName: TExpandNameEvent;
    HTMLTimer: TTimer;
    FOnhtStreamRequest: TGetStreamEvent;
    LocalBitmapList: Boolean;
    FDocumentSource: string;
    FOnParseBegin: TParseEvent;
    FOnParseEnd: TNotifyEvent;
    FTitleAttr: string;
    BGFixed: Boolean;
    FPrintScale: Double;
    NoJump: Boolean;
    FOnLinkDrawn: TLinkDrawnEvent;
    FLinkAttributes: TStringList;
    FLinkText: WideString;
    FLinkStart: TPoint;
    FWidthRatio: Double;
    FOnObjectTag: TObjectTagEvent;

    procedure WMSize(var message: TWMSize);
    message WM_SIZE;
    procedure ScrollTo(Y: Integer);
    procedure Scroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure Layout;
    procedure SetViewImages(Value: Boolean);
    function GetViewImages: Boolean;
    procedure SetColor(Value: TColor);
    function GetBase: string;
    procedure SetBase(Value: string);
    function GetBaseTarget: string;
    function GetTitle: string;
    function GetCurrentFile: string;
    procedure SetBorderStyle(Value: THTMLBorderStyle);
    function GetPosition: Integer;
    procedure SetPosition(Value: Integer);
    function GetScrollPos: Integer;
    procedure SetScrollPos(Value: Integer);
    function GetScrollBarRange: Integer;
    function GetHScrollPos: Integer;
    procedure SetHScrollPos(Value: Integer);
    function GetHScrollBarRange: Integer;
    procedure SetHistoryIndex(Value: Integer);
    function GetPreFontName: TFontName;
    procedure SetPreFontName(Value: TFontName);
    procedure SetFontSize(Value: Integer);
    procedure SetHotSpotColor(Value: TColor);
    procedure SetActiveColor(Value: TColor);
    procedure SetVisitedColor(Value: TColor);
    procedure SetVisitedMaxCount(Value: Integer);
    procedure SetOnBitmapRequest(Handler: TGetBitmapEvent);
    procedure SetOnImageRequest(Handler: TGetImageEvent);
    procedure SetOnScript(Handler: TScriptEvent);
    procedure SetOnFormSubmit(Handler: TFormSubmitEvent);
    function GetOurPalette: HPalette;
    procedure SetOurPalette(Value: HPalette);
    procedure SetDither(Value: Boolean);
    procedure SetCaretPos(Value: Integer);
    procedure WMGetDlgCode(var message: TMessage);
    message WM_GETDLGCODE;
    procedure BackgroundChange(Sender: TObject);
    procedure SubmitForm(Sender: TObject; const Action, Target, EncType, Method: string; Results: TStringList);
    procedure SetImageCacheCount(Value: Integer);
    procedure WMFormSubmit(var message: TMessage);
    message Wm_FormSubmit;
    procedure WMMouseScroll(var message: TMessage);
    message Wm_MouseScroll;
    procedure WMUrlAction(var message: TMessage);
    message Wm_UrlAction;
    procedure SetSelLength(Value: Integer);
    procedure SetSelStart(Value: Integer);
    function GetSelLength: Integer;
    function GetSelText: WideString;
    procedure SetNoSelect(Value: Boolean);
    procedure SetHistoryMaxCount(Value: Integer);
    procedure DrawBorder;
    procedure DoHilite(X, Y: Integer); virtual;
    procedure SetScrollBars(Value: TScrollStyle);
    procedure SetProcessing(Value: Boolean);
    procedure SetCharset(Value: TFontCharset);
    function GetFormControlList: TList;
    function GetNameList: TStringList;
    function GetLinkList: TList;
    procedure SetServerRoot(Value: string);
    procedure SetOnFileBrowse(Handler: TFileBrowseEvent);
    procedure SetOnObjectClick(Handler: TObjectClickEvent);
    procedure SetOnObjectFocus(Handler: ThtObjectEvent);
    procedure SetOnObjectBlur(Handler: ThtObjectEvent);
    procedure SetOnObjectChange(Handler: ThtObjectEvent);
    procedure FormControlEnterEvent(Sender: TObject);
    procedure HandleMeta(Sender: TObject; const HttpEq, name, Content: string);
    procedure SetOptions(Value: ThtmlViewerOptions);
    procedure DoImage(Sender: TObject; const SRC: string; var Stream: TMemoryStream);
    procedure SetOnExpandName(Handler: TExpandNameEvent);
    function GetWordAtCursor(X, Y: Integer; var St, En: Integer; var AWord: WideString): Boolean;
    procedure SetOnPanelCreate(Handler: TPanelCreateEvent);
    procedure SetOnPanelDestroy(Handler: TPanelDestroyEvent);
    procedure SetOnPanelPrint(Handler: TPanelPrintEvent);
    procedure HTMLTimerTimer(Sender: TObject);
    function GetDragDrop: TDragDropEvent;
    function GetDragOver: TDragOverEvent;
    procedure SetDragDrop(const Value: TDragDropEvent);
    procedure SetDragOver(const Value: TDragOverEvent);
    procedure HTMLDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure HTMLDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure InitLoad;
    function GetFormData: TFreeList;
    procedure SetFormData(T: TFreeList);
    function GetIDControl(const ID: string): TObject;
    function GetIDDisplay(const ID: string): Boolean;
    procedure SetIDDisplay(const ID: string; Value: Boolean);
    procedure SetPrintScale(Value: Double);

  protected
    { Protected declarations }
    PaintPanel: TPaintPanel;
    BorderPanel: TPanel;
    Sel1: Integer;

    procedure DoLogic;
    procedure DoScrollBars;
    procedure SetupAndLogic;
    function GetURL(X, Y: Integer; var UrlTarg: TUrlTarget; var FormControl: TImageFormControlObj; var ATitle: string): GuResultType;
    function GetPalette: HPalette; override;
    procedure HTMLPaint(Sender: TObject); virtual;
    procedure HTMLMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;

{$IFDEF ver120_plus}

    procedure HTMLMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint);
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;

{$ENDIF}

    procedure HTMLMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer); virtual;
    procedure HTMLMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure HTMLMouseDblClk(message: TWMMouse);
    function HotSpotClickHandled: Boolean;
    dynamic;
    procedure LoadFile(const FileName: string; Ft: ThtmlFileType); virtual;
    procedure PaintWindow(DC: HDC); override;
    procedure UpdateImageCache;
    procedure DrawBackground2(ACanvas: TCanvas; ARect: TRect; XStart, YStart, XLast, YLast: Integer; Image: TGpObject; Mask: TBitmap;
      BW, BH: Integer; BGColor: TColor);
    procedure DoBackground1(ACanvas: TCanvas; ATop, AWidth, AHeight, FullHeight: Integer);
    procedure DoBackground2(ACanvas: TCanvas; ALeft, ATop, AWidth, AHeight: Integer; AColor: TColor);
    procedure LoadString(const Source, Reference: string; Ft: ThtmlFileType);

  public
    { Public declarations }
    FrameOwner: TObject;
    VScrollBar: T32ScrollBar;
    HScrollBar: TScrollBar;
    TablePartRec: TTablePartRec;
    Visited: TStringList; { visited URLs }

    procedure AddVisitedLink(const S: string);
    procedure CheckVisitedLinks;
    procedure UrlAction;
    procedure TriggerUrlAction;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function HTMLExpandFilename(const FileName: string): string; virtual;
    procedure LoadFromFile(const FileName: string);
    procedure LoadTextFromString(const S: string);

{$IFDEF ver120_plus}  { Delphi 4 and higher }

    procedure LoadFromString(const S: AnsiString; const Reference: string = ''); overload;

{$IFDEF Delphi6_Plus}

    procedure LoadFromString(const WS: WideString; const Reference: string = ''); overload;

{$ENDIF}

    procedure LoadFromStream(const AStream: TStream; const Reference: string = '');
    procedure LoadStrings(const Strings: TStrings; const Reference: string = '');
    procedure LoadFromBuffer(Buffer: PChar; BufLenTChars: Integer; const Reference: string = '');

{$ELSE}

    procedure LoadFromString(const S: string; const Reference: string);
    procedure LoadFromStream(const AStream: TStream; const Reference: string);
    procedure LoadStrings(const Strings: TStrings; const Reference: string);
    procedure LoadFromBuffer(Buffer: PChar; BufSizeTChars: Integer; const Reference: string);

{$ENDIF}

    procedure LoadTextFile(const FileName: string);
    procedure LoadImageFile(const FileName: string);
    procedure LoadTextStrings(Strings: TStrings);
    procedure LoadStream(const URL: string; AStream: TMemoryStream; Ft: ThtmlFileType);
    function PositionTo(Dest: string): Boolean;
    function Find(const S: WideString; MatchCase: Boolean): Boolean;
    function FindEx(const S: WideString; MatchCase, Reverse: Boolean): Boolean;
    procedure Clear; virtual;
    procedure CopyToClipboard;
    procedure SelectAll;
    procedure ClearHistory;
    procedure Reload;
    procedure BumpHistory(const FileName, Title: string; OldPos: Integer; OldFormData: TFreeList; Ft: ThtmlFileType);
    function GetSelTextBuf(Buffer: PWideChar; BufSize: Integer): Integer;
    function InsertImage(const SRC: string; Stream: TMemoryStream): Boolean;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure Repaint; override;
    function FindSourcePos(DisplayPos: Integer): Integer;
    function FindDisplayPos(SourcePos: Integer; Prev: Boolean): Integer;
    function DisplayPosToXy(DisplayPos: Integer; var X, Y: Integer): Boolean;
    function PtInObject(X, Y: Integer; var Obj: TObject): Boolean;
    { X, Y, are client coord }
    procedure SetStringBitmapList(BitmapList: TStringBitmapList);
    function XYToDisplayPos(X, Y: Integer): Integer;
    procedure ReplaceImage(const NameID: string; NewImage: TStream);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Reformat;
    procedure HtProgress(Percent: Integer);
    procedure HtProgressEnd;
    procedure HtProgressInit;
    function FullDisplaySize(FormatWidth: Integer): TSize;
    function MakeBitmap(YTop, FormatWidth, Width, Height: Integer): TBitmap;
    procedure ControlMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    function GetCharAtPos(Pos: Integer; var Ch: WideChar; var Font: TFont): Boolean;
    function GetTextByIndices(AStart, ALast: Integer): WideString;

    property DocumentTitle: string read GetTitle;
    property URL: string read FURL write FURL;
    property Base: string read GetBase write SetBase;
    property BaseTarget: string read GetBaseTarget;
    property Position: Integer read GetPosition write SetPosition;
    property VScrollBarPosition: Integer read GetScrollPos write SetScrollPos;
    property VScrollBarRange: Integer read GetScrollBarRange;
    property HScrollBarPosition: Integer read GetHScrollPos write SetHScrollPos;
    property HScrollBarRange: Integer read GetHScrollBarRange;
    property CurrentFile: string read GetCurrentFile;
    property History: TStrings read FHistory;
    property TitleHistory: TStrings read FTitleHistory;
    property HistoryIndex: Integer read FHistoryIndex write SetHistoryIndex;
    property Processing: Boolean read FProcessing;
    property SelStart: Integer read FCaretPos write SetSelStart;
    property SelLength: Integer read GetSelLength write SetSelLength;
    property SelText: WideString read GetSelText;
    property Target: string read FTarget write FTarget;
    property Palette: HPalette read GetOurPalette write SetOurPalette;
    property Dither: Boolean read FDither write SetDither default True;
    property CaretPos: Integer read FCaretPos write SetCaretPos;
    property FormControlList: TList read GetFormControlList;
    property NameList: TStringList read GetNameList;
    property LinkList: TList read GetLinkList;
    property SectionList: TSectionList read FSectionList;
    property OnExpandName: TExpandNameEvent read FOnExpandName write SetOnExpandName;
    property FormData: TFreeList read GetFormData write SetFormData;
    property DocumentSource: string read FDocumentSource;
    property MaxVertical: Integer read FMaxVertical;
    property TitleAttr: string read FTitleAttr;
    property IDDisplay[const ID: string]: Boolean read GetIDDisplay write SetIDDisplay;
    property IDControl[const ID: string]: TObject read GetIDControl;
    property OnLinkDrawn: TLinkDrawnEvent read FOnLinkDrawn write FOnLinkDrawn;
    property LinkAttributes: TStringList read FLinkAttributes;
    property LinkText: WideString read FLinkText write FLinkText;
    property LinkStart: TPoint read FLinkStart;
    property CodePage: Integer read FCodePage write FCodePage;

  published
    { Published declarations }
    property OnHotSpotCovered: THotSpotEvent read FOnHotSpotCovered write FOnHotSpotCovered;
    property OnHotSpotClick: THotSpotClickEvent read FOnHotSpotClick write FOnHotSpotClick;
    property OnBitmapRequest: TGetBitmapEvent read FOnBitmapRequest write SetOnBitmapRequest;
    property OnImageRequest: TGetImageEvent read FOnImageRequest write SetOnImageRequest;
    property OnScript: TScriptEvent read FOnScript write SetOnScript;
    property OnFormSubmit: TFormSubmitEvent read FOnFormSubmit write SetOnFormSubmit;
    property OnHistoryChange: TNotifyEvent read FOnHistoryChange write FOnHistoryChange;
    property OnProgress: ThtProgressEvent read FOnProgress write FOnProgress;
    property ViewImages: Boolean read GetViewImages write SetViewImages default True;
    property Enabled;
    property TabStop;
    property TabOrder;
    property Align;
    property name;
    property Tag;
    property PopupMenu;
    property ShowHint;

{$IFDEF ver120_plus}

    property Anchors;

{$ENDIF}

    property Height default 150;
    property Width default 150;
    property DefBackground: TColor read FBackGround write SetColor default ClBtnFace;
    property BorderStyle: THTMLBorderStyle read FBorderStyle write SetBorderStyle;
    property Visible;
    property HistoryMaxCount: Integer read FHistoryMaxCount write SetHistoryMaxCount;
    property DefFontName: TFontName read FFontName write FFontName;
    property DefPreFontName: TFontName read GetPreFontName write SetPreFontName;
    property DefFontSize: Integer read FFontSize write SetFontSize default 12;
    property DefFontColor: TColor read FFontColor write FFontColor default ClBtnText;
    property DefHotSpotColor: TColor read FHotSpotColor write SetHotSpotColor default ClBlue;
    property DefVisitedLinkColor: TColor read FVisitedColor write SetVisitedColor default ClPurple;
    property DefOverLinkColor: TColor read FOverColor write SetActiveColor default ClBlue;
    property VisitedMaxCount: Integer read FVisitedMaxCount write SetVisitedMaxCount default 50;
    property ImageCacheCount: Integer read FImageCacheCount write SetImageCacheCount default 5;
    property NoSelect: Boolean read FNoSelect write SetNoSelect;
    property ScrollBars: TScrollStyle read FScrollBars write SetScrollBars default SsBoth;
    property CharSet: TFontCharset read FCharset write SetCharset;
    property MarginHeight: Integer read FMarginHeight write FMarginHeight default 5;
    property MarginWidth: Integer read FMarginWidth write FMarginWidth default 10;
    property ServerRoot: string read FServerRoot write SetServerRoot;
    property PrintMarginLeft: Double read FPrintMarginLeft write FPrintMarginLeft;
    property PrintMarginRight: Double read FPrintMarginRight write FPrintMarginRight;
    property PrintMarginTop: Double read FPrintMarginTop write FPrintMarginTop;
    property PrintMarginBottom: Double read FPrintMarginBottom write FPrintMarginBottom;
    property PrintScale: Double read FPrintScale write SetPrintScale;
    property HtOptions: ThtmlViewerOptions read FOptions write SetOptions default[HtPrintTableBackground, HtPrintMonochromeBlack];

    property OnMouseMove;
    property OnMouseUp;
    property OnMouseDown;

{$IFDEF ver120_plus}

    property OnMouseWheel;

{$ENDIF}

    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnEnter;
    property OnExit;
    property OnProcessing: TProcessingEvent read FOnProcessing write FOnProcessing;
    property OnInclude: TIncludeType read FOnInclude write FOnInclude;
    property OnSoundRequest: TSoundType read FOnSoundRequest write FOnSoundRequest;
    property OnMeta: TMetaType read FOnMeta write FOnMeta;
    property OnLink: TLinkType read FOnLink write FOnLink;
    property OnMetaRefresh: TMetaRefreshType read FOnMetaRefresh write FOnMetaRefresh;
    property OnImageClick: TImageClickEvent read FOnImageClick write FOnImageClick;
    property OnImageOver: TImageOverEvent read FOnImageOver write FOnImageOver;
    property OnFileBrowse: TFileBrowseEvent read FOnFileBrowse write SetOnFileBrowse;
    property OnObjectClick: TObjectClickEvent read FOnObjectClick write SetOnObjectClick;
    property OnObjectFocus: ThtObjectEvent read FOnObjectFocus write SetOnObjectFocus;
    property OnObjectBlur: ThtObjectEvent read FOnObjectBlur write SetOnObjectBlur;
    property OnObjectChange: ThtObjectEvent read FOnObjectChange write SetOnObjectChange;
    property OnRightClick: TRightClickEvent read FOnRightClick write FOnRightClick;
    property OnMouseDouble: TMouseEvent read FOnMouseDouble write FOnMouseDouble;
    property OnPanelCreate: TPanelCreateEvent read FOnPanelCreate write SetOnPanelCreate;
    property OnPanelDestroy: TPanelDestroyEvent read FOnPanelDestroy write SetOnPanelDestroy;
    property OnPanelPrint: TPanelPrintEvent read FOnPanelPrint write SetOnPanelPrint;
    property OnDragDrop: TDragDropEvent read GetDragDrop write SetDragDrop;
    property OnDragOver: TDragOverEvent read GetDragOver write SetDragOver;
    property OnhtStreamRequest: TGetStreamEvent read FOnhtStreamRequest write FOnhtStreamRequest;
    property OnParseBegin: TParseEvent read FOnParseBegin write FOnParseBegin;
    property OnParseEnd: TNotifyEvent read FOnParseEnd write FOnParseEnd;
    property OnObjectTag: TObjectTagEvent read FOnObjectTag write FOnObjectTag;
    property Cursor: TCursor read GetCursor write SetCursor default CrIBeam;
  end;

implementation

uses
  Clipbrd,
  Htmlgif2;

const
  ScrollGap = 20;

type
  PositionObj = class(TObject)
    Pos: Integer;
    FileType: ThtmlFileType;
    FormData: TFreeList;
    destructor Destroy; override;
  end;

constructor THTMLViewer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InCreate := True;
  ControlStyle := [CsAcceptsControls, CsCaptureMouse, CsClickEvents, CsSetCaption, CsDoubleClicks];
  Height := 150;
  Width := 150;
  SetCursor(CrIBeam);
  FPrintMarginLeft := 2.0;
  FPrintMarginRight := 2.0;
  FPrintMarginTop := 2.0;
  FPrintMarginBottom := 2.0;
  FPrintScale := 1.0;
  FCharset := DEFAULT_CHARSET;
  FMarginHeight := 5;
  FMarginWidth := 10;

  BorderPanel := TPanel.Create(Self);
  BorderPanel.BevelInner := BvNone;
  BorderPanel.BevelOuter := BvNone;
  BorderPanel.Ctl3D := False;
  BorderPanel.Align := AlClient;
  BorderPanel.ParentCtl3D := False;

{$IFDEF delphi7_plus}

  BorderPanel.ParentBackground := False;

{$ENDIF}

  BorderPanel.Parent := Self;

  PaintPanel := TPaintPanel.CreateIt(Self, Self);
  PaintPanel.ParentFont := False;
  PaintPanel.Parent := Self;
  PaintPanel.Top := 1;
  PaintPanel.Left := 1;
  PaintPanel.BevelOuter := BvNone;
  PaintPanel.BevelInner := BvNone;
  PaintPanel.Ctl3D := False;

  PaintPanel.OnPaint := HTMLPaint;
  PaintPanel.OnMouseDown := HTMLMouseDown;
  PaintPanel.OnMouseMove := HTMLMouseMove;
  PaintPanel.OnMouseUp := HTMLMouseUp;

  VScrollBar := T32ScrollBar.Create(Self);
  VScrollBar.Kind := SbVertical;
  VScrollBar.SmallChange := 16;
  VScrollBar.Visible := False;
  VScrollBar.TabStop := False;
  SbWidth := VScrollBar.Width;
  VScrollBar.Parent := Self;

  HScrollBar := TScrollBar.Create(Self);
  HScrollBar.Kind := SbHorizontal;
  HScrollBar.SmallChange := 15;
  HScrollBar.OnScroll := Scroll;
  HScrollBar.Visible := False;
  HScrollBar.TabStop := False;
  HScrollBar.Parent := Self;
  HScrollBar.Width := SbWidth;

  FScrollBars := SsBoth;

  FSectionList := TSectionList.Create(Self, PaintPanel);
  FSectionList.ControlEnterEvent := FormControlEnterEvent;
  FSectionList.OnBackgroundChange := BackgroundChange;
  FSectionList.ShowImages := True;
  FNameList := FSectionList.IDNameList;

  DefBackground := ClBtnFace;
  DefFontColor := ClBtnText;
  DefHotSpotColor := ClBlue;
  DefOverLinkColor := ClBlue;
  DefVisitedLinkColor := ClPurple;
  FVisitedMaxCount := 50;
  DefFontSize := 12;
  DefFontName := 'Times New Roman';
  DefPreFontName := 'Courier New';
  SetImageCacheCount(5);
  SetOptions([HtPrintTableBackground, HtPrintMonochromeBlack]);

  FHistory := TStringList.Create;
  FPositionHistory := TFreeList.Create;
  FTitleHistory := TStringList.Create;
  FDither := True;

  Visited := TStringList.Create;
  HTMLTimer := TTimer.Create(Self);
  HTMLTimer.Enabled := False;
  HTMLTimer.Interval := 200;
  HTMLTimer.OnTimer := HTMLTimerTimer;
  FLinkAttributes := TStringList.Create;
  InCreate := False;
end;

destructor THTMLViewer.Destroy;
begin
  if LocalBitmapList then
    begin
      FSectionList.Clear;
      FSectionList.BitmapList.Free;
    end;
  FSectionList.Free;
  FHistory.Free;
  FPositionHistory.Free;
  FTitleHistory.Free;
  Visited.Free;
  HTMLTimer.Free;
  FLinkAttributes.Free;
  inherited Destroy;
end;

procedure THTMLViewer.SetupAndLogic;
begin
  FTitle := ReadHTML.Title;
  if ReadHTML.Base <> '' then
    FBase := ReadHTML.Base
  else
    FBase := FBaseEx;
  FBaseTarget := ReadHTML.BaseTarget;
  if Assigned(FOnParseEnd) then
    FOnParseEnd(Self);
  try
    DontDraw := True;
    { Load the background bitmap if any and if ViewImages set }
    FSectionList.GetBackgroundBitmap;

    DoLogic;

  finally
    DontDraw := False;
  end;
end;

procedure THTMLViewer.LoadFile(const FileName: string; Ft: ThtmlFileType);
var
  I: Integer;
  Dest, FName, OldFile: string;
  SBuffer: string;
  FS: TFileStream;
  Tmp: AnsiString;
begin
  IOResult; { eat up any pending errors }
  FName := FileName;
  I := Pos('#', FName);
  if I > 0 then
    begin
      Dest := Copy(FName, I + 1, Length(FName) - I); { positioning information }
      FName := Copy(FName, 1, I - 1);
    end
  else
    Dest := '';
  FRefreshDelay := 0;
  try
    SetProcessing(True);
    if not FileExists(FName) then
      raise (EInOutError.Create('Can''t locate file: ' + FName));
    FSectionList.ProgressStart := 75;
    HtProgressInit;
    DontDraw := True;
    InitLoad;
    CaretPos := 0;
    Sel1 := -1;
    try
      OldFile := FCurrentFile;
      FCurrentFile := ExpandFileName(FName);
      FCurrentFileType := Ft;
      if Ft in [HTMLType, TextType] then
        begin
          FS := TFileStream.Create(FName, FmOpenRead or FmShareDenyWrite);
          try
            SetLength(Tmp, FS.Size);
            FS.ReadBuffer(Tmp[1], FS.Size);
            FDocumentSource := Tmp;
          finally
            FS.Free;
          end;
        end
      else
        FDocumentSource := '';
      if Assigned(FOnParseBegin) then
        FOnParseBegin(Self, FDocumentSource);
      if Ft = HTMLType then
        begin
          if Assigned(FOnSoundRequest) then
            FOnSoundRequest(Self, '', 0, True);
          ParseHTMLString(FDocumentSource, FSectionList, FOnInclude, FOnSoundRequest, HandleMeta, FOnLink);
        end
      else if Ft = TextType then
        ParseTextString(FDocumentSource, FSectionList)
      else
        begin
          SBuffer := '<img src="' + FName + '">';
          ParseHTMLString(SBuffer, FSectionList, nil, nil, nil, nil);
        end;
    finally
      SetupAndLogic;
      CheckVisitedLinks;
      if (Dest <> '') and PositionTo(Dest) then
        { change position, if applicable }
      else if FCurrentFile <> OldFile then
        begin
          ScrollTo(0);
          HScrollBar.Position := 0;
        end;
      { else if same file leave position alone }
      DontDraw := False;
      PaintPanel.Invalidate;
    end;
  finally
    HtProgressEnd;
    SetProcessing(False);
  end;
  if (FRefreshDelay > 0) and Assigned(FOnMetaRefresh) then
    FOnMetaRefresh(Self, FRefreshDelay, FRefreshURL);
end;

procedure THTMLViewer.LoadFromFile(const FileName: string);
var
  OldFile, OldTitle: string;
  OldPos: Integer;
  OldType: ThtmlFileType;
  OldFormData: TFreeList;
begin
  if FProcessing then
    Exit;
  if FileName <> '' then
    begin
      OldFile := FCurrentFile;
      OldTitle := FTitle;
      OldPos := Position;
      OldType := FCurrentFileType;
      OldFormData := GetFormData;
      try
        LoadFile(FileName, HTMLType);
        if (OldFile <> FCurrentFile) or (OldType <> FCurrentFileType) then
          BumpHistory(OldFile, OldTitle, OldPos, OldFormData, OldType)
        else
          OldFormData.Free;
      except
        OldFormData.Free;
        raise ;
      end;
    end;
end;

{ ----------------ThtmlViewer.LoadTextFile }
procedure THTMLViewer.LoadTextFile(const FileName: string);
var
  OldFile, OldTitle: string;
  OldPos: Integer;
  OldType: ThtmlFileType;
  OldFormData: TFreeList;
begin
  if FProcessing then
    Exit;
  if FileName <> '' then
    begin
      OldFile := FCurrentFile;
      OldTitle := FTitle;
      OldPos := Position;
      OldType := FCurrentFileType;
      OldFormData := GetFormData;
      try
        LoadFile(FileName, TextType);
        if (OldFile <> FCurrentFile) or (OldType <> FCurrentFileType) then
          BumpHistory(OldFile, OldTitle, OldPos, OldFormData, OldType)
        else
          OldFormData.Free;
      except
        OldFormData.Free;
        raise ;
      end;
    end;
end;

{ ----------------ThtmlViewer.LoadImageFile }
procedure THTMLViewer.LoadImageFile(const FileName: string);
var
  OldFile, OldTitle: string;
  OldPos: Integer;
  OldType: ThtmlFileType;
  OldFormData: TFreeList;

begin
  if FProcessing then
    Exit;
  if FileName <> '' then
    begin
      OldFile := FCurrentFile;
      OldTitle := FTitle;
      OldPos := Position;
      OldType := FCurrentFileType;
      OldFormData := GetFormData;
      try
        LoadFile(FileName, ImgType);
        if (OldFile <> FCurrentFile) or (OldType <> FCurrentFileType) then
          BumpHistory(OldFile, OldTitle, OldPos, OldFormData, OldType)
        else
          OldFormData.Free;
      except
        OldFormData.Free;
        raise ;
      end;
    end;
end;

{ ----------------THtmlViewer.LoadStrings }
procedure THTMLViewer.LoadStrings(const Strings: TStrings; const Reference: string);
begin
  LoadString(Strings.Text, Reference, HTMLType);
  if (FRefreshDelay > 0) and Assigned(FOnMetaRefresh) then
    FOnMetaRefresh(Self, FRefreshDelay, FRefreshURL);
end;

{ ----------------THtmlViewer.LoadTextStrings }
procedure THTMLViewer.LoadTextStrings(Strings: TStrings);
begin
  LoadString(Strings.Text, '', TextType);
end;

{ ----------------ThtmlViewer.LoadFromBuffer }
procedure THTMLViewer.LoadFromBuffer(Buffer: PChar; BufLenTChars: Integer; const Reference: string);
var
  S: string;
begin
  SetLength(S, BufLenTChars);
  Move(Buffer^, S[1], BufLenTChars * SizeOf(Char));
  LoadFromString(S, Reference); // Изменил
  if (FRefreshDelay > 0) and Assigned(FOnMetaRefresh) then
    FOnMetaRefresh(Self, FRefreshDelay, FRefreshURL);
end;

{ ----------------ThtmlViewer.LoadTextFromString }
procedure THTMLViewer.LoadTextFromString(const S: string);
begin
  LoadString(S, '', TextType);
end;

{ ----------------ThtmlViewer.LoadFromString }
procedure THTMLViewer.LoadFromString(const S: AnsiString; const Reference: string);
begin
  LoadString(S, Reference, HTMLType);
  if (FRefreshDelay > 0) and Assigned(FOnMetaRefresh) then
    FOnMetaRefresh(Self, FRefreshDelay, FRefreshURL);
end;

{$IFDEF Delphi6_Plus}

procedure THTMLViewer.LoadFromString(const WS: WideString; const Reference: string);
begin
  LoadFromString(#$EF + #$BB + #$BF + UTF8Encode(WS), Reference);
end;

{$ENDIF}

{ ----------------ThtmlViewer.LoadString }
procedure THTMLViewer.LoadString(const Source, Reference: string; Ft: ThtmlFileType);
var
  I: Integer;
  Dest, FName, OldFile: string;
begin
  if FProcessing then
    Exit;
  SetProcessing(True);
  FRefreshDelay := 0;
  FName := Reference;
  I := Pos('#', FName);
  if I > 0 then
    begin
      Dest := Copy(FName, I + 1, Length(FName) - I); { positioning information }
      FName := Copy(FName, 1, I - 1);
    end
  else
    Dest := '';
  DontDraw := True;
  try
    OldFile := FCurrentFile;
    FCurrentFile := ExpandFileName(FName);
    FCurrentFileType := Ft;
    FSectionList.ProgressStart := 75;
    HtProgressInit;
    InitLoad;
    CaretPos := 0;
    Sel1 := -1;
    if Assigned(FOnSoundRequest) then
      FOnSoundRequest(Self, '', 0, True);
    FDocumentSource := Source;
    if Assigned(FOnParseBegin) then
      FOnParseBegin(Self, FDocumentSource);
    if Ft = HTMLType then
      ParseHTMLString(FDocumentSource, FSectionList, FOnInclude, FOnSoundRequest, HandleMeta, FOnLink)
    else
      ParseTextString(FDocumentSource, FSectionList);
    SetupAndLogic;
    //CheckVisitedLinks;
    if (Dest <> '') and PositionTo(Dest) then { change position, if applicable }
    else if (FCurrentFile = '') or (FCurrentFile <> OldFile) then
      begin
        ScrollTo(0);
        HScrollBar.Position := 0;
      end;
    { else if same file leave position alone }
    PaintPanel.Invalidate;
  finally
    HtProgressEnd;
    SetProcessing(False);
    DontDraw := False;
  end;
end;

{ ----------------ThtmlViewer.LoadFromStream }
procedure THTMLViewer.LoadFromStream(const AStream: TStream; const Reference: string);
var
  Stream: TMemoryStream;
  S: string;
begin
  Stream := TMemoryStream.Create;
  try
    Stream.LoadFromStream(AStream);
    SetLength(S, Stream.Size div SizeOf(Char));
    Move(Stream.Memory^, S[1], Stream.Size); // don't use * SizeOf(Char) here
    LoadString(S, Reference, HTMLType);
    if (FRefreshDelay > 0) and Assigned(FOnMetaRefresh) then
      FOnMetaRefresh(Self, FRefreshDelay, FRefreshURL);
  finally
    Stream.Free;
  end;
end;

procedure THTMLViewer.DoImage(Sender: TObject; const SRC: string; var Stream: TMemoryStream);
begin
  Stream := FImageStream;
end;

{ ----------------ThtmlViewer.LoadStream }
procedure THTMLViewer.LoadStream(const URL: string; AStream: TMemoryStream; Ft: ThtmlFileType);
var
  SaveOnImageRequest: TGetImageEvent;
  SBuffer: string;
begin
  if FProcessing or not Assigned(AStream) then
    Exit;
  SetProcessing(True);
  FRefreshDelay := 0;
  DontDraw := True;
  try
    FSectionList.ProgressStart := 75;
    HtProgressInit;
    InitLoad;
    CaretPos := 0;
    Sel1 := -1;

    if Ft in [HTMLType, TextType] then
      begin
        SetLength(FDocumentSource, AStream.Size div SizeOf(Char));
        Move(AStream.Memory^, FDocumentSource[1], AStream.Size);
        // don't use * SizeOf(Char) here
      end
    else
      FDocumentSource := '';
    if Assigned(FOnParseBegin) then
      FOnParseBegin(Self, FDocumentSource);
    if Ft = HTMLType then
      begin
        if Assigned(FOnSoundRequest) then
          FOnSoundRequest(Self, '', 0, True);
        ParseHTMLString(FDocumentSource, FSectionList, FOnInclude, FOnSoundRequest, HandleMeta, FOnLink);
        SetupAndLogic;
      end
    else if Ft = TextType then
      begin
        ParseTextString(FDocumentSource, FSectionList);
        SetupAndLogic;
      end
    else
      begin
        SaveOnImageRequest := FOnImageRequest;
        SetOnImageRequest(DoImage);
        FImageStream := AStream;
        SBuffer := '<img src="' + URL + '">';
        try
          ParseHTMLString(SBuffer, FSectionList, nil, nil, nil, nil);
          SetupAndLogic;
        finally
          SetOnImageRequest(SaveOnImageRequest);
        end;
      end;
    ScrollTo(0);
    HScrollBar.Position := 0;
    PaintPanel.Invalidate;
    FCurrentFile := URL;
  finally
    HtProgressEnd;
    DontDraw := False;
    SetProcessing(False);
  end;
  if (FRefreshDelay > 0) and Assigned(FOnMetaRefresh) then
    FOnMetaRefresh(Self, FRefreshDelay, FRefreshURL);
end;

{ ----------------ThtmlViewer.DoScrollBars }
procedure THTMLViewer.DoScrollBars;
var
  VBar, VBar1, HBar: Boolean;
  Wid, HWidth, WFactor, WFactor2, VHeight: Integer;
  ScrollInfo: TScrollInfo;

begin
  ScrollWidth := IntMin(ScrollWidth, MaxHScroll);
  if FBorderStyle = HtNone then
    begin
      WFactor := 0;
      PaintPanel.Top := 0;
      PaintPanel.Left := 0;
      BorderPanel.Visible := False;
    end
  else
    begin
      WFactor := 1;
      PaintPanel.Top := 1;
      PaintPanel.Left := 1;
      BorderPanel.Visible := False;
      BorderPanel.Visible := True;
    end;
  WFactor2 := 2 * WFactor;

  VBar := False;
  VBar1 := False;
  if (not(HtShowVScroll in HtOptions) and (FMaxVertical <= Height - WFactor2) and (ScrollWidth <= Width - WFactor2)) or
    (FScrollBars = SsNone) then
    { there are no scrollbars }
    HBar := False
  else if FScrollBars in [SsBoth, SsVertical] then
    begin { assume a vertical scrollbar }
      VBar1 := (FMaxVertical >= Height - WFactor2) or
        ((FScrollBars in [SsBoth, SsHorizontal]) and (FMaxVertical >= Height - WFactor2 - SbWidth) and
          (ScrollWidth > Width - SbWidth - WFactor2));
      HBar := (FScrollBars in [SsBoth, SsHorizontal]) and
        ((ScrollWidth > Width - WFactor2) or ((VBar1 or (HtShowVScroll in FOptions)) and (ScrollWidth > Width - SbWidth - WFactor2)));
      VBar := VBar1 or (HtShowVScroll in HtOptions);
    end
  else
    { there is no vertical scrollbar }
    HBar := (FScrollBars = SsHorizontal) and (ScrollWidth > Width - WFactor2);

  if VBar or ((HtShowVScroll in FOptions) and (FScrollBars in [SsBoth, SsVertical])) then
    Wid := Width - SbWidth
  else
    Wid := Width;
  PaintPanel.Width := Wid - WFactor2;
  if HBar then
    begin
      PaintPanel.Height := Height - WFactor2 - SbWidth;
      VHeight := Height - SbWidth - WFactor2;
    end
  else
    begin
      PaintPanel.Height := Height - WFactor2;
      VHeight := Height - WFactor2;
    end;
  HWidth := IntMax(ScrollWidth, Wid - WFactor2);
  HScrollBar.Visible := HBar;
  HScrollBar.LargeChange := IntMax(1, Wid - 20);
  HScrollBar.SetBounds(WFactor, Height - SbWidth - WFactor, Wid - WFactor, SbWidth);
  VScrollBar.SetBounds(Width - SbWidth - WFactor, WFactor, SbWidth, VHeight);
  VScrollBar.LargeChange := PaintPanel.Height - VScrollBar.SmallChange;
  if HtShowVScroll in FOptions then
    begin
      VScrollBar.Visible := (FScrollBars in [SsBoth, SsVertical]);
      VScrollBar.Enabled := VBar1;
    end
  else
    VScrollBar.Visible := VBar;

  HScrollBar.Max := IntMax(0, HWidth);
  VScrollBar.SetParams(VScrollBar.Position, PaintPanel.Height + 1, 0, FMaxVertical);
  ScrollInfo.CbSize := SizeOf(ScrollInfo);
  ScrollInfo.FMask := SIF_PAGE;
  ScrollInfo.NPage := Wid;
  SetScrollInfo(HScrollBar.Handle, SB_CTL, ScrollInfo, True);
end;

{ ----------------ThtmlViewer.DoLogic }
procedure THTMLViewer.DoLogic;
var
  Wid, WFactor: Integer;

function HasVScrollbar: Boolean;
begin
  Result := (FMaxVertical > Height - WFactor) or ((FScrollBars in [SsBoth, SsHorizontal]) and (FMaxVertical >= Height - WFactor - SbWidth)
      and (ScrollWidth > Width - SbWidth - WFactor));
end;

function HasVScrollbar1: Boolean;
begin
  Result := (FMaxVertical > Height - WFactor) or ((FScrollBars in [SsBoth, SsHorizontal]) and (FMaxVertical >= Height - WFactor - SbWidth)
      and (ScrollWidth > Width - WFactor));
end;

function FSectionListDoLogic(Width: Integer): Integer;
var
  Curs: Integer;
begin
  Curs := 0;
  ScrollWidth := 0;
  Result := FSectionList.DoLogic(PaintPanel.Canvas, 0, Width, ClientHeight - WFactor, 0, ScrollWidth, Curs);
end;

begin
  HandleNeeded;
  try
    DontDraw := True;
    if FBorderStyle = HtNone then
      WFactor := 0
    else
      WFactor := 2;
    Wid := Width - WFactor;
    if FScrollBars in [SsBoth, SsVertical] then
      begin
        if not(HtShowVScroll in FOptions) and (Length(FDocumentSource) < 10000) then
          begin { see if there is a vertical scrollbar with full width }
            FMaxVertical := FSectionListDoLogic(Wid);
            if HasVScrollbar then { yes, there is vertical scrollbar, allow for it }
              begin
                FMaxVertical := FSectionListDoLogic(Wid - SbWidth);
                if not HasVScrollbar1 then
                  FMaxVertical := FSectionListDoLogic(Wid);
              end;
          end
        else { assume a vertical scrollbar }
          FMaxVertical := FSectionListDoLogic(Wid - SbWidth);
      end
    else { there is no vertical scrollbar }
      FMaxVertical := FSectionListDoLogic(Wid);

    DoScrollBars;
  finally
    DontDraw := False;
  end;
end;

procedure THTMLViewer.HTMLPaint(Sender: TObject);
var
  ARect: TRect;
begin
  if not DontDraw then
    begin
      ARect := Rect(0, 1, PaintPanel.Width, PaintPanel.Height);
      FSectionList.Draw(PaintPanel.Canvas2, ARect, MaxHScroll, -HScrollBar.Position, 0, 0, 0);
    end;
end;

procedure THTMLViewer.WMSize(var message: TWMSize);
begin
  inherited;
  if InCreate then
    Exit;
  if not FProcessing then
    Layout
  else
    DoScrollBars;
  if FMaxVertical < PaintPanel.Height then
    Position := 0
  else
    ScrollTo(VScrollBar.Position); { keep aligned to limits }
  with HScrollBar do
    Position := IntMin(Position, Max - PaintPanel.Width);
end;

procedure THTMLViewer.Scroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
{ only the horizontal scrollbar comes here }
begin
  ScrollPos := IntMin(ScrollPos, HScrollBar.Max - PaintPanel.Width);
  PaintPanel.Invalidate;
end;

procedure THTMLViewer.ScrollTo(Y: Integer);
begin
  Y := IntMin(Y, FMaxVertical - PaintPanel.Height);
  Y := IntMax(Y, 0);
  VScrollBar.Position := Y;
  FSectionList.SetYOffset(Y);
  Invalidate;
end;

procedure THTMLViewer.Layout;
var
  OldPos: Integer;
begin
  if FProcessing then
    Exit;
  SetProcessing(True);
  try
    OldPos := Position;
    FSectionList.ProgressStart := 0;
    HtProgressInit;
    DoLogic;
    Position := OldPos; { return to old position after width change }
  finally
    HtProgressEnd;
    SetProcessing(False);
  end;
end;

function THTMLViewer.HotSpotClickHandled: Boolean;
var
  Handled: Boolean;
begin
  Handled := False;
  if Assigned(FOnHotSpotClick) then
    FOnHotSpotClick(Self, URL, Handled);
  Result := Handled;
end;

procedure THTMLViewer.TriggerUrlAction;
begin
  PostMessage(Handle, Wm_UrlAction, 0, 0);
end;

procedure THTMLViewer.WMUrlAction(var message: TMessage);
begin
  UrlAction;
end;

procedure THTMLViewer.UrlAction;
var
  S, Dest: string;
  Ext: string;
  I: Integer;
  OldPos: Integer;
begin
  if not HotSpotClickHandled then
    begin
      OldPos := Position;
      S := URL;
      I := Pos('#', S); { # indicates a position within the document }
      if I = 1 then
        begin
          if PositionTo(S) then { no filename with this one }
            begin
              BumpHistory(FCurrentFile, FTitle, OldPos, nil, FCurrentFileType);
              AddVisitedLink(FCurrentFile + S);
            end;
        end
      else
        begin
          if I >= 1 then
            begin
              Dest := System.Copy(S, I, Length(S) - I + 1); { local destination }
              S := System.Copy(S, 1, I - 1); { the file name }
            end
          else
            Dest := ''; { no local destination }
          S := HTMLExpandFilename(S);
          Ext := Uppercase(ExtractFileExt(S));
          if (Ext = '.HTM') or (Ext = '.HTML') then
            begin { an html file }
              if S <> FCurrentFile then
                begin
                  LoadFromFile(S + Dest);
                  AddVisitedLink(S + Dest);
                end
              else if PositionTo(Dest) then { file already loaded, change position }
                begin
                  BumpHistory(FCurrentFile, FTitle, OldPos, nil, HTMLType);
                  AddVisitedLink(S + Dest);
                end;
            end
          else if (Ext = '.BMP') or (Ext = '.GIF') or (Ext = '.JPG') or (Ext = '.JPEG') or (Ext = '.PNG') then
            LoadImageFile(S);
        end;
      { Note: Self may not be valid here }
    end;
end;

{ ----------------ThtmlViewer.AddVisitedLink }
procedure THTMLViewer.AddVisitedLink(const S: string);
var
  I, J: Integer;
  S1, UrlTmp: string;
begin
  if Assigned(FrameOwner) or (FVisitedMaxCount = 0) then
    Exit; { TFrameViewer will take care of visited links }
  I := Visited.IndexOf(S);
  if I = 0 then
    Exit
  else if I < 0 then
    begin
      for J := 0 to SectionList.LinkList.Count - 1 do
        with TFontObj(SectionList.LinkList[J]) do
          begin
            UrlTmp := URL;
            if Length(UrlTmp) > 0 then
              begin
                if URL[1] = '#' then
                  S1 := FCurrentFile + UrlTmp
                else
                  S1 := HTMLExpandFilename(UrlTmp);
                if CompareText(S, S1) = 0 then
                  Visited := True;
              end;
          end;
    end
  else
    Visited.Delete(I); { thus moving it to the top }
  Visited.Insert(0, S);
  for I := Visited.Count - 1 downto FVisitedMaxCount do
    Visited.Delete(I);
end;

{ ----------------ThtmlViewer.CheckVisitedLinks }
procedure THTMLViewer.CheckVisitedLinks;
var
  I, J: Integer;
  S, S1: string;
begin
  if FVisitedMaxCount = 0 then
    Exit;
  for I := 0 to Visited.Count - 1 do
    begin
      S := Visited[I];
      for J := 0 to SectionList.LinkList.Count - 1 do
        with TFontObj(SectionList.LinkList[J]) do
          begin
            if (URL <> '') and (URL[1] = '#') then
              S1 := FCurrentFile + URL
            else
              S1 := HTMLExpandFilename(URL);
            if CompareText(S, S1) = 0 then
              Visited := True;
          end;
    end;
end;

{ ----------------ThtmlViewer.HTMLMouseDown }
procedure THTMLViewer.HTMLMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  XR, CaretHt: Integer;
  YR: Integer;
  InText: Boolean;
  Dummy: TUrlTarget;
  DummyFC: TImageFormControlObj;
  DummyTitle: string;
begin
  inherited MouseDown(Button, Shift, X, Y);

  SetFocus;
  HotSpotAction := False;
  if MiddleScrollOn then
    begin
      MiddleScrollOn := False;
      PaintPanel.Cursor := Cursor;
      MouseScrolling := False;
    end
  else if (Button = MbMiddle) and not(HtNoWheelMouse in HtOptions) then
    { comment this out to disable mouse middle button scrolling }
    begin
      MiddleScrollOn := True;
      MiddleY := Y;
      PaintPanel.Cursor := UpDownCursor;
    end
  else if (Button = MbLeft) then
    begin
      LeftButtonDown := True;
      if not(HtNoLinkHilite in FOptions) or not(GuUrl in GetURL(X, Y, Dummy, DummyFC, DummyTitle)) then
        Hiliting := True;
      with FSectionList do
        begin
          Sel1 := FindCursor(PaintPanel.Canvas, X, Y + YOff, XR, YR, CaretHt, InText);
          if Sel1 > -1 then
            begin
              if (SelB <> SelE) or (SsShift in Shift) then
                InvalidateRect(PaintPanel.Handle, nil, True);
              if (SsShift in Shift) then
                if Sel1 < CaretPos then
                  begin
                    SelE := CaretPos;
                    SelB := Sel1;
                  end
                else
                  begin
                    SelB := CaretPos;
                    SelE := Sel1;
                  end
                else
                  begin
                    SelB := Sel1;
                    SelE := Sel1;
                    CaretPos := Sel1;
                  end;
            end;
          LButtonDown(True); { signal to TSectionList }
        end;
    end;
end;

procedure THTMLViewer.HTMLTimerTimer(Sender: TObject);
var
  Pt: TPoint;
begin
  if GetCursorPos(Pt) and (WindowFromPoint(Pt) <> PaintPanel.Handle) then
    begin
      SectionList.CancelActives;
      HTMLTimer.Enabled := False;
      if FURL <> '' then
        begin
          FURL := '';
          FTarget := '';
          if Assigned(FOnHotSpotCovered) then
            FOnHotSpotCovered(Self, '');
        end;
    end;
end;

function THTMLViewer.PtInObject(X, Y: Integer; var Obj: TObject): Boolean;
{ X, Y, are client coord } { css }
var
  IX, IY: Integer;
begin
  Result := PtInRect(ClientRect, Point(X, Y)) and FSectionList.PtInObject(X, Y + FSectionList.YOff, Obj, IX, IY);
end;

procedure THTMLViewer.ControlMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  Dummy: TUrlTarget;
  DummyFC: TImageFormControlObj;
begin
  if Sender is TFormControlObj then
    with TFormControlObj(Sender), TheControl do
      begin
        FTitleAttr := Title;
        if FTitleAttr = '' then
          begin
            Dummy := nil;
            GetURL(X + Left, Y + Top, Dummy, DummyFC, FTitleAttr);
            if Assigned(Dummy) then
              Dummy.Free;
          end;
        inherited MouseMove(Shift, X, Y);
      end;
end;

function THTMLViewer.GetTextByIndices(AStart, ALast: Integer): WideString;
var
  SaveSelB: Integer;
  SaveSelE: Integer;
begin
  if (AStart >= 0) and (ALast >= 0) and (ALast > AStart) then
    with FSectionList do
      begin
        SaveSelB := SelB;
        SaveSelE := SelE;
        SelB := Self.FindDisplayPos(AStart, False);
        SelE := Self.FindDisplayPos(ALast, False);
        Result := GetSelText;
        DisplayPosToXy(SelB, FLinkStart.X, FLinkStart.Y);
        Dec(FLinkStart.Y, VScrollBar.Position);
        SelB := SaveSelB;
        SelE := SaveSelE;
      end
    else
      Result := '';
end;

{ ----------------ThtmlViewer.HTMLMouseMove }
procedure THTMLViewer.HTMLMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  UrlTarget: TUrlTarget;
  URL, Target: string;
  FormControl: TImageFormControlObj;
  Obj: TObject;
  IX, IY: Integer;
  XR, CaretHt: Integer;
  YR: Integer;
  InText: Boolean;
  NextCursor: TCursor;
  GuResult: GuResultType;
begin
  inherited MouseMove(Shift, X, Y);

  if MiddleScrollOn then
    begin
      if not MouseScrolling and (Abs(Y - MiddleY) > ScrollGap) then
        begin
          MouseScrolling := True;
          PostMessage(Handle, Wm_MouseScroll, 0, 0);
        end;
      Exit;
    end;

  UrlTarget := nil;
  URL := '';
  NextCursor := CrArrow;
  FTitleAttr := '';
  GuResult := GetURL(X, Y, UrlTarget, FormControl, FTitleAttr);
  if GuUrl in GuResult then
    begin
      NextCursor := crHandPoint;
      URL := UrlTarget.URL;
      Target := UrlTarget.Target;
      FLinkAttributes.Text := UrlTarget.Attr;
      FLinkText := GetTextByIndices(UrlTarget.Start, UrlTarget.Last);
      UrlTarget.Free;
    end;
  if GuControl in GuResult then
    NextCursor := crHandPoint;
  if (Assigned(FOnImageClick) or Assigned(FOnImageOver)) and FSectionList.PtInObject(X, Y + FSectionList.YOff, Obj, IX, IY) then
    begin
      if NextCursor <> crHandPoint then { in case it's also a Link }
        NextCursor := CrArrow;
      if Assigned(FOnImageOver) then
        FOnImageOver(Self, Obj, Shift, IX, IY);
    end
  else if (FSectionList.FindCursor(PaintPanel.Canvas, X, Y + FSectionList.YOff, XR, YR, CaretHt, InText) >= 0) and InText and
    (NextCursor <> crHandPoint) then
    NextCursor := Cursor;

  PaintPanel.Cursor := NextCursor;

  if ((NextCursor = crHandPoint) or (SectionList.ActiveImage <> nil)) then
    HTMLTimer.Enabled := True
  else
    HTMLTimer.Enabled := False;

  if (URL <> FURL) or (Target <> FTarget) then
    begin
      FURL := URL;
      FTarget := Target;
      if Assigned(FOnHotSpotCovered) then
        FOnHotSpotCovered(Self, URL);
    end;
  if (SsLeft in Shift) and not MouseScrolling and ((Y <= 0) or (Y >= Self.Height)) then
    begin
      MouseScrolling := True;
      PostMessage(Handle, Wm_MouseScroll, 0, 0);
    end;
  if (SsLeft in Shift) and not FNoSelect then
    DoHilite(X, Y);
end;

procedure THTMLViewer.HTMLMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  UrlTarget: TUrlTarget;
  FormControl: TImageFormControlObj;
  Obj: TObject;
  IX, IY: Integer;
  InImage, TmpLeft: Boolean;
  Parameters: TRightClickParameters;
  AWord: WideString;
  St, En: Integer;
  GuResult: GuResultType;
  I, ThisID: Integer;
  ParentForm: TCustomForm;
begin
  if MiddleScrollOn then
    begin
      { cancel unless it's middle button and has moved }
      if (Button <> MbMiddle) or (Y <> MiddleY) then
        begin
          MiddleScrollOn := False;
          PaintPanel.Cursor := Cursor;
        end;
      Exit;
    end;

  inherited MouseUp(Button, Shift, X, Y);

  if Assigned(FOnImageClick) or Assigned(FOnRightClick) then
    begin
      InImage := FSectionList.PtInObject(X, Y + FSectionList.YOff, Obj, IX, IY);
      if Assigned(FOnImageClick) and InImage then
        FOnImageClick(Self, Obj, Button, Shift, IX, IY);
      if (Button = MbRight) and Assigned(FOnRightClick) then
        begin
          Parameters := TRightClickParameters.Create;
          try
            if InImage then
              begin
                Parameters.Image := Obj as TImageObj;
                Parameters.ImageX := IX;
                Parameters.ImageY := IY;
              end;
            if GuUrl in GetURL(X, Y, UrlTarget, FormControl, FTitleAttr) then
              begin
                Parameters.URL := UrlTarget.URL;
                Parameters.Target := UrlTarget.Target;
                UrlTarget.Free;
              end;
            if GetWordAtCursor(X, Y, St, En, AWord) then
              Parameters.ClickWord := AWord;
            HTMLTimer.Enabled := False;
            FOnRightClick(Self, Parameters);
          finally
            HTMLTimer.Enabled := True;
            Parameters.Free;
          end;
        end;
    end;

  if (Button = MbLeft) and not(SsShift in Shift) then
    begin
      MouseScrolling := False;
      DoHilite(X, Y);
      Hiliting := False;
      FSectionList.LButtonDown(False);
      TmpLeft := LeftButtonDown;
      LeftButtonDown := False;
      if TmpLeft and (FSectionList.SelE <= FSectionList.SelB) then
        begin
          GuResult := GetURL(X, Y, UrlTarget, FormControl, FTitleAttr);
          if GuControl in GuResult then
            FormControl.ImageClick(nil)
          else if GuUrl in GuResult then
            begin
              FURL := UrlTarget.URL;
              FTarget := UrlTarget.Target;
              FLinkAttributes.Text := UrlTarget.Attr;
              FLinkText := GetTextByIndices(UrlTarget.Start, UrlTarget.Last);
              ThisID := UrlTarget.ID;
              for I := 0 to LinkList.Count - 1 do
                with TFontObj(LinkList.Items[I]) do
                  if (ThisID = UrlTarget.ID) and Assigned(TabControl) then
                    begin
                      ParentForm := GetParentForm(TabControl);
                      if Assigned(ParentForm) and TabControl.CanFocus then
                        begin
                          NoJump := True;
                          { keep doc from jumping position on mouse click }
                          try
                            ParentForm.ActiveControl := TabControl;
                          finally
                            NoJump := False;
                          end;
                        end;
                      Break;
                    end;
              UrlTarget.Free;
              HotSpotAction := True; { prevent double click action }
              UrlAction;
              { Note:  Self pointer may not be valid after URLAction call (TFrameViewer, HistoryMaxCount=0) }
            end;
        end;
    end;
end;

{ ----------------ThtmlViewer.HTMLMouseWheel }

{$IFDEF ver120_plus}

procedure THTMLViewer.HTMLMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint);
var
  Lines: Integer;
begin
  Lines := Mouse.WheelScrollLines;
  if Lines > 0 then
    if WheelDelta > 0 then
      VScrollBarPosition := VScrollBarPosition - (Lines * 16)
    else
      VScrollBarPosition := VScrollBarPosition + (Lines * 16)
    else
      VScrollBarPosition := VScrollBarPosition - WheelDelta div 2;
end;

function THTMLViewer.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos);
  if not Result and not(HtNoWheelMouse in HtOptions) then
    begin
      HTMLMouseWheel(Self, Shift, WheelDelta, MousePos);
      Result := True;
    end;
end;

{$ENDIF}

{ ----------------ThtmlViewer.XYToDisplayPos }
function THTMLViewer.XYToDisplayPos(X, Y: Integer): Integer;
var
  InText: Boolean;
  XR, YR, CaretHt: Integer;
begin
  with SectionList do
    Result := FindCursor(PaintPanel.Canvas, X, Y + YOff, XR, YR, CaretHt, InText);
  if not InText then
    Result := -1;
end;

{ ----------------ThtmlViewer.GetCharAtPos }
function THTMLViewer.GetCharAtPos(Pos: Integer; var Ch: WideChar; var Font: TFont): Boolean;
var
  Obj: TObject;
  FO: TFontObj;
  index: Integer;
begin
  Result := FSectionList.GetChAtPos(Pos, Ch, Obj);
  if Result and (Obj is TSection) then
    with TSection(Obj) do
      begin
        FO := Fonts.GetFontObjAt(Pos - StartCurs, index);
        Font := FO.TheFont;
      end;
end;

{ ----------------ThtmlViewer.GetWordAtCursor }
function THTMLViewer.GetWordAtCursor(X, Y: Integer; var St, En: Integer; var AWord: WideString): Boolean;
var
  XR, X1, CaretHt: Integer;
  YR, Y1: Integer;
  Obj: TObject;
  Ch: WideChar;
  InText: Boolean;
  Tmp: WideString;

function AlphaNum(Ch: WideChar): Boolean;
begin
  Result := (Ch in [WideChar('a') .. WideChar('z'), WideChar('A') .. WideChar('Z'), WideChar('0') .. WideChar('9')]) or (Ch >= #192);
end;

function GetCh(Pos: Integer): WideChar;
var
  Ch: WideChar;
  Obj1: TObject;
begin
  Result := ' ';
  if not FSectionList.GetChAtPos(Pos, Ch, Obj1) or (Obj1 <> Obj) then
    Exit;
  Result := Ch;
end;

begin
  Result := False;
  AWord := '';
  with FSectionList do
    begin
      InText := False;
      CaretPos := FindCursor(PaintPanel.Canvas, X, Y + YOff, XR, YR, CaretHt, InText);
      CursorToXy(PaintPanel.Canvas, CaretPos, X1, Y1);
      if InText then { else cursor is past end of row }
        begin
          En := CaretPos;
          St := En - 1;
          if GetChAtPos(En, Ch, Obj) and AlphaNum(Ch) then
            begin
              AWord := Ch;
              Result := True;
              Inc(En);
              Ch := GetCh(En);
              while AlphaNum(Ch) do
                begin
                  Tmp := Ch; { Delphi 3 needs this nonsense }
                  AWord := AWord + Tmp;
                  Inc(En);
                  Ch := GetCh(En);
                end;
              if St >= 0 then
                begin
                  Ch := GetCh(St);
                  while (St >= 0) and AlphaNum(Ch) do
                    begin
                      System.Insert(Ch, AWord, 1);
                      Dec(St);
                      if St >= 0 then
                        Ch := GetCh(St);
                    end;
                end;
            end;
        end;
    end;
end;

{ ----------------ThtmlViewer.HTMLMouseDblClk }
procedure THTMLViewer.HTMLMouseDblClk(message: TWMMouse);
var
  St, En: Integer;
  AWord: WideString;
begin
  FSectionList.LButtonDown(True);
  if FProcessing or HotSpotAction then
    Exit;
  if not FNoSelect and GetWordAtCursor(message.XPos, message.YPos, St, En, AWord) then
    begin
      FSectionList.SelB := St + 1;
      FSectionList.SelE := En;
      FCaretPos := St + 1;
      InvalidateRect(PaintPanel.Handle, nil, True);
    end;
  if Assigned(FOnMouseDouble) then
    with message do
      FOnMouseDouble(Self, MbLeft, KeysToShiftState(Keys), XPos, YPos);
end;

procedure THTMLViewer.DoHilite(X, Y: Integer);
var
  Curs, YR, YWin: Integer;
  XR, CaretHt: Integer;
  InText: Boolean;
begin
  if Hiliting and (Sel1 >= 0) then
    with FSectionList do
      begin
        YWin := IntMin(IntMax(0, Y), Height);
        Curs := FindCursor(PaintPanel.Canvas, X, YWin + YOff, XR, YR, CaretHt, InText);
        if (Curs >= 0) and not FNoSelect then
          begin
            if Curs > Sel1 then
              begin
                SelE := Curs;
                SelB := Sel1;
              end
            else
              begin
                SelB := Curs;
                SelE := Sel1;
              end;
            InvalidateRect(PaintPanel.Handle, nil, True);
          end;
        CaretPos := Curs;
      end;
end;

{ ----------------ThtmlViewer.WMMouseScroll }
procedure THTMLViewer.WMMouseScroll(var message: TMessage);
const
  Ticks: DWord = 0;
var
  Pos: Integer;
  Pt: TPoint;
begin
  GetCursorPos(Pt);
  Ticks := 0;
  with VScrollBar do
    begin
      Pt := PaintPanel.ScreenToClient(Pt);
      while MouseScrolling and (LeftButtonDown and ((Pt.Y <= 0) or (Pt.Y > Self.Height))) or
        (MiddleScrollOn and (Abs(Pt.Y - MiddleY) > ScrollGap)) do
        begin
          if GetTickCount > Ticks + 100 then
            begin
              Ticks := GetTickCount;
              Pos := Position;
              if LeftButtonDown then
                begin
                  if Pt.Y < -15 then
                    Pos := Position - SmallChange * 8
                  else if Pt.Y <= 0 then
                    Pos := Position - SmallChange
                  else if Pt.Y > Self.Height + 15 then
                    Pos := Position + SmallChange * 8
                  else
                    Pos := Position + SmallChange;
                end
              else
                begin { MiddleScrollOn }
                  if Pt.Y - MiddleY < -3 * ScrollGap then
                    Pos := Position - 32
                  else if Pt.Y - MiddleY < -ScrollGap then
                    Pos := Position - 8
                  else if Pt.Y - MiddleY > 3 * ScrollGap then
                    Pos := Position + 32
                  else if Pt.Y - MiddleY > ScrollGap then
                    Pos := Position + 8;
                  if Pos < Position then
                    PaintPanel.Cursor := UpOnlyCursor
                  else if Pos > Position then
                    PaintPanel.Cursor := DownOnlyCursor;
                end;
              Pos := IntMax(0, IntMin(Pos, FMaxVertical - PaintPanel.Height));
              FSectionList.SetYOffset(Pos);
              SetPosition(Pos);
              DoHilite(Pt.X, Pt.Y);
              PaintPanel.Invalidate;
              GetCursorPos(Pt);
              Pt := PaintPanel.ScreenToClient(Pt);
            end;
          Application.ProcessMessages;
          Application.ProcessMessages;
          Application.ProcessMessages;
          Application.ProcessMessages;
        end;
    end;
  MouseScrolling := False;
  if MiddleScrollOn then
    PaintPanel.Cursor := UpDownCursor;
end;

function THTMLViewer.PositionTo(Dest: string): Boolean;
var
  I: Integer;
  Obj: TObject;
begin
  Result := False;
  if Dest = '' then
    Exit;
  if Dest[1] = '#' then
    System.Delete(Dest, 1, 1);
  I := FNameList.IndexOf(Uppercase(Dest));
  if I > -1 then
    begin
      Obj := FNameList.Objects[I];
      if (Obj is TIDObject) then
        ScrollTo(TIDObject(Obj).YPosition);

      HScrollBar.Position := 0;
      Result := True;
      AddVisitedLink(FCurrentFile + '#' + Dest);
    end;
end;

function THTMLViewer.GetURL(X, Y: Integer; var UrlTarg: TUrlTarget; var FormControl: TImageFormControlObj; var ATitle: string)
  : GuResultType;
begin
  Result := FSectionList.GetURL(PaintPanel.Canvas, X, Y + FSectionList.YOff, UrlTarg, FormControl, ATitle);
end;

procedure THTMLViewer.SetViewImages(Value: Boolean);
var
  OldPos: Integer;
  // OldCursor: TCursor; // Изменил
begin
  if (Value <> FSectionList.ShowImages) and not FProcessing then
    begin
      // OldCursor := Screen.Cursor; // Изменил
      try
        // Screen.Cursor := CrHourGlass; // Изменил
        SetProcessing(True);
        FSectionList.ShowImages := Value;
        if FSectionList.Count > 0 then
          begin
            FSectionList.GetBackgroundBitmap; { load any background bitmap }
            OldPos := Position;
            DoLogic;
            Position := OldPos;
            Invalidate;
          end;
      finally
        // Screen.Cursor := OldCursor; // Изменил
        SetProcessing(False);
      end;
    end;
end;

{ ----------------ThtmlViewer.InsertImage }
function THTMLViewer.InsertImage(const SRC: string; Stream: TMemoryStream): Boolean;
var
  OldPos: Integer;
  Reformat: Boolean;
begin
  Result := False;
  if FProcessing then
    Exit;
  try
    SetProcessing(True);
    FSectionList.InsertImage(SRC, Stream, Reformat);
    FSectionList.GetBackgroundBitmap; { in case it's the one placed }
    if Reformat then
      if FSectionList.Count > 0 then
        begin
          FSectionList.GetBackgroundBitmap; { load any background bitmap }
          OldPos := Position;
          DoLogic;
          Position := OldPos;
        end;
    Invalidate;
  finally
    SetProcessing(False);
    Result := True;
  end;
end;

function THTMLViewer.GetBase: string;
begin
  Result := FBase;
end;

procedure THTMLViewer.SetBase(Value: string);
begin
  FBase := Value;
  FBaseEx := Value;
end;

function THTMLViewer.GetBaseTarget: string;
begin
  Result := FBaseTarget;
end;

function THTMLViewer.GetTitle: string;
begin
  Result := FTitle;
end;

function THTMLViewer.GetCurrentFile: string;
begin
  Result := FCurrentFile;
end;

function THTMLViewer.GetViewImages: Boolean;
begin
  Result := FSectionList.ShowImages;
end;

procedure THTMLViewer.SetColor(Value: TColor);
begin
  if FProcessing then
    Exit;
  FBackGround := Value;
  FSectionList.Background := Value;
  PaintPanel.Color := Value;
  Invalidate;
end;

procedure THTMLViewer.SetBorderStyle(Value: THTMLBorderStyle);
begin
  if Value <> FBorderStyle then
    begin
      FBorderStyle := Value;
      DrawBorder;
    end;
end;

procedure THTMLViewer.KeyDown(var Key: Word; Shift: TShiftState);
var
  Pos: Integer;
  OrigPos: Integer;
  TheChange: Integer;
begin
  inherited KeyDown(Key, Shift);
  if Shift <> [] then
    Exit;
  if MiddleScrollOn then
    begin
      MiddleScrollOn := False;
      PaintPanel.Cursor := Cursor;
      Exit;
    end;
  with VScrollBar do
    if Key in [VK_PRIOR, VK_NEXT, VK_UP, VK_DOWN, VK_HOME, VK_END] then
      begin
        Pos := Position;
        OrigPos := Pos;
        case Key of
          VK_PRIOR: Dec(Pos, LargeChange);
          VK_NEXT: Inc(Pos, LargeChange);
          VK_UP: Dec(Pos, SmallChange);
          VK_DOWN: Inc(Pos, SmallChange);
          VK_HOME: Pos := 0;
          VK_END: Pos := FMaxVertical;
        end;
        if Pos < 0 then
          Pos := 0;
        Pos := IntMax(0, IntMin(Pos, FMaxVertical - PaintPanel.Height));

        Position := Pos;
        FSectionList.SetYOffset(Pos);

        TheChange := OrigPos - Pos;
        if not BGFixed and (Abs(TheChange) = SmallChange) then
          begin { update only the scrolled part }
            ScrollWindow(PaintPanel.Handle, 0, TheChange, nil, nil);
            PaintPanel.Update;
          end
        else
          PaintPanel.Invalidate;
      end;

  with HScrollBar do
    if Key in [VK_LEFT, VK_RIGHT] then
      begin
        Pos := Position;
        case Key of
          VK_LEFT: Dec(Pos, SmallChange);
          VK_RIGHT: Inc(Pos, SmallChange);
        end;
        if Pos < 0 then
          Pos := 0;
        Pos := IntMin(Pos, Max - PaintPanel.Width);
        Position := Pos;
        PaintPanel.Invalidate;
      end;
end;

procedure THTMLViewer.WMGetDlgCode(var message: TMessage);
begin
  message.Result := DLGC_WantArrows; { else don't get the arrow keys }
end;

function THTMLViewer.GetPosition: Integer;
var
  index: Integer;
  TopPos, Pos: Integer;
  S: TSectionBase;
begin
  Pos := Integer(VScrollBar.Position);
  S := FSectionList.FindSectionAtPosition(Pos, TopPos, index);
  if Assigned(S) then
    Result := Integer(index + 1) shl 16 + ((Pos - TopPos) and $FFFF)
  else
    Result := Pos;
  { Hiword is section # plus 1, Loword is displacement from top of section
    HiWord = 0 is top of display }
end;

procedure THTMLViewer.SetPosition(Value: Integer);
var
  TopPos: Integer;
begin
  if HiWord(Value) = 0 then
    ScrollTo(LoWord(Value))
  else if (HiWord(Value) - 1 < FSectionList.PositionList.Count) then
    begin
      TopPos := TSectionBase(FSectionList.PositionList[HiWord(Value) - 1]).YPosition;
      ScrollTo(TopPos + LoWord(Value));
    end;
end;

function THTMLViewer.GetScrollPos: Integer;
begin
  Result := VScrollBar.Position;
end;

procedure THTMLViewer.SetScrollPos(Value: Integer);
begin
  if Value < 0 then
    Value := 0;
  Value := IntMin(Value, FMaxVertical - PaintPanel.Height);
  if Value <> GetScrollPos then
    ScrollTo(Value);
end;

function THTMLViewer.GetScrollBarRange: Integer;
begin
  Result := FMaxVertical - PaintPanel.Height;
end;

function THTMLViewer.GetHScrollPos: Integer;
begin
  Result := HScrollBar.Position;
end;

procedure THTMLViewer.SetHScrollPos(Value: Integer);
begin
  if Value < 0 then
    Value := 0;
  Value := IntMin(Value, HScrollBar.Max - PaintPanel.Width);
  HScrollBar.Position := Value;
  Invalidate;
end;

function THTMLViewer.GetHScrollBarRange: Integer;
begin
  Result := HScrollBar.Max - PaintPanel.Width;
end;

function THTMLViewer.GetPalette: HPalette;
begin
  if ThePalette <> 0 then
    Result := ThePalette
  else
    Result := inherited GetPalette;
  Invalidate;
end;

function THTMLViewer.HTMLExpandFilename(const FileName: string): string;
var
  Tmp: string;
begin
  { pass http: and other protocols except for file:/// }
  if (Pos('://', FileName) > 1) and (Pos('file://', Lowercase(FileName)) = 0) then
    Result := FileName
  else
    begin
      Result := HTMLServerToDos(Trim(FileName), FServerRoot);

      if Pos('\', Result) = 1 then
        Result := ExpandFileName(Result)
      else if (Pos(':', Result) <> 2) and (Pos('\\', Result) <> 1) then
        if CompareText(FBase, 'DosPath') = 0 then { let Dos find the path }
        else if FBase <> '' then
          begin
            Tmp := ExtractFilePath(HTMLToDos(FBase));
            Result := ExpandFileName(Tmp + Result)
          end
        else
          Result := ExpandFileName(ExtractFilePath(FCurrentFile) + Result);
    end;
end;

{ ----------------ThtmlViewer.BumpHistory }
procedure THTMLViewer.BumpHistory(const FileName, Title: string; OldPos: Integer; OldFormData: TFreeList; Ft: ThtmlFileType);
var
  I: Integer;
  PO: PositionObj;
  SameName: Boolean;
begin
  SameName := FileName = FCurrentFile;
  if (FHistoryMaxCount > 0) and (FCurrentFile <> '') and ((not SameName) or (FCurrentFileType <> Ft) or (OldPos <> Position)) then
    with FHistory do
      begin
        if (Count > 0) and (FileName <> '') then
          begin
            Strings[FHistoryIndex] := FileName;
            with PositionObj(FPositionHistory[FHistoryIndex]) do
              begin
                Pos := OldPos;
                FileType := Ft;
                if not SameName then { only stored when documents changed }
                  FormData := OldFormData
                else
                  OldFormData.Free;
              end;
            FTitleHistory[FHistoryIndex] := Title;
            for I := 0 to FHistoryIndex - 1 do
              begin
                Delete(0);
                FTitleHistory.Delete(0);
                PositionObj(FPositionHistory[0]).Free;
                FPositionHistory.Delete(0);
              end;
          end;
        FHistoryIndex := 0;
        Insert(0, FCurrentFile);
        PO := PositionObj.Create;
        PO.Pos := Position;
        PO.FileType := FCurrentFileType;
        FPositionHistory.Insert(0, PO);
        FTitleHistory.Insert(0, FTitle);
        if Count > FHistoryMaxCount then
          begin
            Delete(FHistoryMaxCount);
            FTitleHistory.Delete(FHistoryMaxCount);
            PositionObj(FPositionHistory[FHistoryMaxCount]).Free;
            FPositionHistory.Delete(FHistoryMaxCount);
          end;
        if Assigned(FOnHistoryChange) then
          FOnHistoryChange(Self);
      end
    else
      OldFormData.Free;
end;

procedure THTMLViewer.SetHistoryIndex(Value: Integer);
var
  I: Integer;

function GetLowestSameFileIndex(Start: Integer): Integer;
begin
  Result := Start;
  while (Result > 0) and (FHistory[Result - 1] = FCurrentFile) do
    Dec(Result);
end;

begin
  with FHistory do
    if (Value <> FHistoryIndex) and (Value >= 0) and (Value < Count) and not FProcessing then
      begin
        if FCurrentFile <> '' then
          begin { save the current information }
            Strings[FHistoryIndex] := FCurrentFile;
            with PositionObj(FPositionHistory[FHistoryIndex]) do
              begin
                Pos := Position;
                FileType := FCurrentFileType;
                I := GetLowestSameFileIndex(FHistoryIndex);
                PositionObj(FPositionHistory[I]).FormData := GetFormData;
              end;
            FTitleHistory[FHistoryIndex] := FTitle;
          end;
        with PositionObj(FPositionHistory[Value]) do
          begin { reestablish the new desired history position }
            if (FCurrentFile <> Strings[Value]) or (FCurrentFileType <> FileType) then
              Self.LoadFile(Strings[Value], FileType);
            Position := Pos;
            I := GetLowestSameFileIndex(Value);
            with PositionObj(FPositionHistory[I]) do
              begin
                SetFormData(FormData); { reload the forms if any }
                FormData.Free;
                FormData := nil;
              end;
          end;
        FHistoryIndex := Value;
        if Assigned(FOnHistoryChange) then
          FOnHistoryChange(Self);
      end;
end;

procedure THTMLViewer.SetHistoryMaxCount(Value: Integer);
begin
  if (Value = FHistoryMaxCount) or (Value < 0) then
    Exit;
  if Value < FHistoryMaxCount then
    ClearHistory;
  FHistoryMaxCount := Value;
end;

procedure THTMLViewer.ClearHistory;
var
  CountWas: Integer;
begin
  CountWas := FHistory.Count;
  FHistory.Clear;
  FTitleHistory.Clear;
  FPositionHistory.Clear;
  FHistoryIndex := 0;
  FCurrentFile := '';
  if (CountWas > 0) and Assigned(FOnHistoryChange) then
    FOnHistoryChange(Self);
end;

function THTMLViewer.GetPreFontName: TFontName;
begin
  Result := FPreFontName;
end;

procedure THTMLViewer.SetPreFontName(Value: TFontName);
begin
  if CompareText(Value, FSectionList.PreFontName) <> 0 then
    begin
      FPreFontName := Value;
      FSectionList.PreFontName := Value;
    end;
end;

procedure THTMLViewer.SetFontSize(Value: Integer);
begin
  FFontSize := Value;
end;

procedure THTMLViewer.SetCharset(Value: TFontCharset);
begin
  FCharset := Value;
end;

function THTMLViewer.GetFormControlList: TList;
begin
  Result := FSectionList.FormControlList;
end;

function THTMLViewer.GetNameList: TStringList;
begin
  Result := FNameList;
end;

function THTMLViewer.GetLinkList: TList;
begin
  Result := FSectionList.LinkList;
end;

procedure THTMLViewer.SetHotSpotColor(Value: TColor);
begin
  FHotSpotColor := Value;
  FSectionList.HotSpotColor := Value;
end;

procedure THTMLViewer.SetVisitedColor(Value: TColor);
begin
  FVisitedColor := Value;
  FSectionList.LinkVisitedColor := Value;
end;

procedure THTMLViewer.SetActiveColor(Value: TColor);
begin
  FOverColor := Value;
  FSectionList.LinkActiveColor := Value;
end;

procedure THTMLViewer.SetVisitedMaxCount(Value: Integer);
var
  I: Integer;
begin
  Value := IntMax(Value, 0);
  if Value <> FVisitedMaxCount then
    begin
      FVisitedMaxCount := Value;
      if FVisitedMaxCount = 0 then
        begin
          Visited.Clear;
          for I := 0 to SectionList.LinkList.Count - 1 do
            TFontObj(LinkList[I]).Visited := False;
          Invalidate;
        end
      else
        begin
          FVisitedMaxCount := Value;
          for I := Visited.Count - 1 downto FVisitedMaxCount do
            Visited.Delete(I);
        end;
    end;
end;

function THTMLViewer.GetCursor: TCursor;
begin
  Result := inherited Cursor;
end;

procedure THTMLViewer.SetCursor(Value: TCursor);
begin
  if Value = OldThickIBeamCursor then { no longer used }
    Value := CrIBeam;
  inherited Cursor := Value;
end;

function THTMLViewer.FullDisplaySize(FormatWidth: Integer): TSize;
var
  Curs: Integer;
  CopyList: TSectionList;
begin
  Result.Cx := 0; { error return }
  Result.Cy := 0;
  if FormatWidth > 0 then
    begin
      CopyList := TSectionList.CreateCopy(FSectionList);
      try
        Curs := 0;
        Result.Cy := CopyList.DoLogic(PaintPanel.Canvas, 0, FormatWidth, 300, 0, Result.Cx, Curs);
      finally
        CopyList.Free;
      end;
    end;
end;

{ ----------------CalcBackgroundLocationAndTiling }
procedure CalcBackgroundLocationAndTiling(const PRec: PtPositionRec; ARect: TRect; XOff, YOff, IW, IH, BW, BH: Integer;
  var X, Y, X2, Y2: Integer);

{ PRec has the CSS information on the background image, it's starting location and
  whether it is tiled in x, y, neither, or both.
  ARect is the cliprect, no point in drawing tiled images outside it.
  XOff, YOff are offsets which allow for the fact that the viewable area may not be at 0,0.
  IW, IH are the total width and height of the document if you could see it all at once.
  BW, BH are bitmap dimensions used to calc tiling.
  X, Y are the position (window coordinates) where the first background iamge will be drawn.
  X2, Y2 are tiling limits.  X2 and Y2 may be such that 0, 1, or many images will
  get drawn.  They're calculated so that only images within ARect are drawn.
}
var
  I: Integer;
  P: array [1 .. 2] of Integer;
begin
  { compute the location of the prime background image. Tiling can go either way
    from this image }
  P[1] := 0;
  P[2] := 0;
  for I := 1 to 2 do { I = 1 is X info, I = 2 is Y info }
    with PRec[I] do
      begin
        case PosType of
          PTop: P[I] := -YOff;
          PCenter: if I = 1 then
              P[1] := IW div 2 - BW div 2 - XOff
            else
              P[2] := IH div 2 - BH div 2 - YOff;
          PBottom: P[I] := IH - BH - YOff;
          PLeft: P[I] := -XOff;
          PRight: P[I] := IW - BW - XOff;
          PPercent: if I = 1 then
              P[1] := ((IW - BW) * Value) div 100 - XOff
            else
              P[2] := ((IH - BH) * Value div 100) - YOff;
          PDim: if I = 1 then
              P[I] := Value - XOff
            else
              P[I] := Value - YOff;
        end;
      end;

  { Calculate the tiling keeping it within the cliprect boundaries }
  X := P[1];
  Y := P[2];
  if PRec[2].RepeatD then
    begin { y repeat }
      { figure a starting point for tiling.  This will be less that one image height
        outside the cliprect }
      if Y < ARect.Top then
        Y := Y + ((ARect.Top - Y) div BH) * BH
      else if Y > ARect.Top then
        Y := Y - ((Y - ARect.Top) div BH) * BH - BH;
      Y2 := ARect.Bottom;
    end
  else
    begin { a single image or row }
      Y2 := Y; { assume it's not in the cliprect and won't be output }
      if not((Y > ARect.Bottom) or (Y + BH < ARect.Top)) then
        Inc(Y2); { it is in the clip rect, show it }
    end;
  if PRec[1].RepeatD then
    begin { x repeat }
      { figure a starting point for tiling.  This will be less that one image width
        outside the cliprect }
      if X < ARect.Left then
        X := X + ((ARect.Left - X) div BW) * BW
      else if X > ARect.Left then
        X := X - ((X - ARect.Left) div BW) * BW - BW;
      X2 := ARect.Right;
    end
  else
    begin { single image or column }
      X2 := X; { assume it's not in the cliprect and won't be output }
      if not((X > ARect.Right) or (X + BW < ARect.Left)) then
        Inc(X2); { it is in the clip rect, show it }
    end;
end;

{ ----------------DrawBackground }
procedure DrawBackground(ACanvas: TCanvas; ARect: TRect; XStart, YStart, XLast, YLast: Integer; Image: TGpObject; Mask: TBitmap;
  AniGif: TGifImage; BW, BH: Integer; BGColor: TColor);
{ draw the background color and any tiled images on it }
{ ARect, the cliprect, drawing outside this will not show but images may overhang
  XStart, YStart are first image position already calculated for the cliprect and parameters.
  XLast, YLast   Tiling stops here.
  BW, BH  bitmap dimensions.
}
var
  X, Y: Integer;
  OldBrush: HBrush;
  OldPal: HPalette;
  DC: HDC;
  OldBack, OldFore: TColor;
  Bitmap: TBitmap;
  Graphics: TGpGraphics;
begin
  DC := ACanvas.Handle;
  if DC <> 0 then
    begin
      OldPal := SelectPalette(DC, ThePalette, False);
      RealizePalette(DC);
      ACanvas.Brush.Color := BGColor or PalRelative;
      OldBrush := SelectObject(DC, ACanvas.Brush.Handle);
      OldBack := SetBkColor(DC, ClWhite);
      OldFore := SetTextColor(DC, ClBlack);
      try
        ACanvas.FillRect(ARect); { background color }
        if Assigned(AniGif) then { tile the animated gif }
          begin
            Y := YStart;
            while Y < YLast do
              begin
                X := XStart;
                while X < XLast do
                  begin
                    AniGif.Draw(ACanvas, X, Y, BW, BH);
                    Inc(X, BW);
                  end;
                Inc(Y, BH);
              end;
          end
        else if Assigned(Image) then { tile the bitmap }
          if Image is TBitmap then
            begin
              Bitmap := TBitmap(Image);
              Y := YStart;
              while Y < YLast do
                begin
                  X := XStart;
                  while X < XLast do
                    begin
                      if Mask = nil then
                        BitBlt(DC, X, Y, BW, BH, Bitmap.Canvas.Handle, 0, 0, SRCCOPY)
                      else
                        begin
                          BitBlt(DC, X, Y, BW, BH, Bitmap.Canvas.Handle, 0, 0, SrcInvert);
                          BitBlt(DC, X, Y, BW, BH, Mask.Canvas.Handle, 0, 0, SrcAnd);
                          BitBlt(DC, X, Y, BW, BH, Bitmap.Canvas.Handle, 0, 0, SrcPaint);
                        end;
                      Inc(X, BW);
                    end;
                  Inc(Y, BH);
                end;
            end

{$IFNDEF NoMetafile}

          else if Image is ThtMetafile then
            begin
              Y := YStart;
              try
                while Y < YLast do
                  begin
                    X := XStart;
                    while X < XLast do
                      begin
                        ACanvas.Draw(X, Y, ThtMetafile(Image));
                        Inc(X, BW);
                      end;
                    Inc(Y, BH);
                  end;
              except
              end;
            end

{$ENDIF}

          else
            begin
              Y := YStart;
              Graphics := TGpGraphics.Create(DC);
              try
                while Y < YLast do
                  begin
                    X := XStart;
                    while X < XLast do
                      begin
                        Graphics.DrawImage(TGpImage(Image), X, Y, BW, BH);
                        Inc(X, BW);
                      end;
                    Inc(Y, BH);
                  end;
              except
              end;
              Graphics.Free;
            end;
      finally
        SelectObject(DC, OldBrush);
        SelectPalette(DC, OldPal, False);
        RealizePalette(DC);
        SetBkColor(DC, OldBack);
        SetTextColor(DC, OldFore);
      end;
    end;
end;

{ ----------------ThtmlViewer.DrawBackground2 }
procedure THTMLViewer.DrawBackground2(ACanvas: TCanvas; ARect: TRect; XStart, YStart, XLast, YLast: Integer; Image: TGpObject;
  Mask: TBitmap; BW, BH: Integer; BGColor: TColor);
{ Called by DoBackground2 (Print and PrintPreview) }
{ draw the background color and any tiled images on it }
{ ARect, the cliprect, drawing outside this will not show but images may overhang
  XStart, YStart are first image position already calculated for the cliprect and parameters.
  XLast, YLast   Tiling stops here.
  BW, BH  Image dimensions.
}
var
  X, Y: Integer;
  OldBrush: HBrush;
  OldPal: HPalette;
  DC: HDC;
  OldBack, OldFore: TColor;
  Bitmap: TBitmap;
begin
  DC := ACanvas.Handle;
  if DC <> 0 then
    begin
      OldPal := SelectPalette(DC, ThePalette, False);
      RealizePalette(DC);
      ACanvas.Brush.Color := BGColor or PalRelative;
      OldBrush := SelectObject(DC, ACanvas.Brush.Handle);
      OldBack := SetBkColor(DC, ClWhite);
      OldFore := SetTextColor(DC, ClBlack);
      try
        ACanvas.FillRect(ARect); { background color }
        if Assigned(Image) then { tile the Image }
          if Image is TBitmap then
            begin
              Bitmap := TBitmap(Image);
              Y := YStart;
              while Y < YLast do
                begin
                  X := XStart;
                  while X < XLast do
                    begin
                      if Mask = nil then
                        PrintBitmap(ACanvas, X, Y, BW, BH, Bitmap.Handle)
                      else
                        begin
                          PrintTransparentBitmap3(ACanvas, X, Y, BW, BH, Bitmap, Mask, 0, Bitmap.Height);
                        end;
                      Inc(X, BW);
                    end;
                  Inc(Y, BH);
                end;
            end

{$IFNDEF NoMetafile}

          else if Image is ThtMetafile then
            begin
              Y := YStart;
              try
                while Y < YLast do
                  begin
                    X := XStart;
                    while X < XLast do
                      begin
                        ACanvas.Draw(X, Y, ThtMetafile(Image));
                        Inc(X, BW);
                      end;
                    Inc(Y, BH);
                  end;
              except
              end;
            end

{$ENDIF}

          else
            begin
              Y := YStart;
              try
                while Y < YLast do
                  begin
                    X := XStart;
                    while X < XLast do
                      begin
                        StretchPrintGpImageOnColor(ACanvas, TGpImage(Image), X, Y, BW, BH, BGColor);
                        Inc(X, BW);
                      end;
                    Inc(Y, BH);
                  end;
              except
              end;
            end;
      finally
        SelectObject(DC, OldBrush);
        SelectPalette(DC, OldPal, False);
        RealizePalette(DC);
        SetBkColor(DC, OldBack);
        SetTextColor(DC, OldFore);
      end;
    end;
end;

procedure THTMLViewer.DoBackground1(ACanvas: TCanvas; ATop, AWidth, AHeight, FullHeight: Integer);
var
  ARect: TRect;
  Image: TGpObject;
  Mask: TBitmap;
  PRec: PtPositionRec;
  BW, BH, X, Y, X2, Y2, IW, IH, XOff, YOff: Integer;
  Fixed: Boolean;

begin
  ARect := Rect(0, 0, AWidth, AHeight);
  Image := FSectionList.BackgroundBitmap;
  if FSectionList.ShowImages and Assigned(Image) then
    begin
      Mask := FSectionList.BackgroundMask;
      BW := GetImageWidth(Image);
      BH := GetImageHeight(Image);
      PRec := FSectionList.BackgroundPRec;
      Fixed := PRec[1].Fixed;
      if Fixed then
        begin { fixed background }
          XOff := 0;
          YOff := 0;
          IW := AWidth;
          IH := AHeight;
        end
      else
        begin { scrolling background }
          XOff := 0;
          YOff := ATop;
          IW := AWidth;
          IH := FullHeight;
        end;

      { Calculate where the tiled background images go }
      CalcBackgroundLocationAndTiling(PRec, ARect, XOff, YOff, IW, IH, BW, BH, X, Y, X2, Y2);

      DrawBackground(ACanvas, ARect, X, Y, X2, Y2, Image, Mask, nil, BW, BH, PaintPanel.Color);
    end
  else
    begin { no background image, show color only }
      DrawBackground(ACanvas, ARect, 0, 0, 0, 0, nil, nil, nil, 0, 0, PaintPanel.Color);
    end;
end;

procedure THTMLViewer.DoBackground2(ACanvas: TCanvas; ALeft, ATop, AWidth, AHeight: Integer; AColor: TColor);
{ called by Print and PrintPreview }
var
  ARect: TRect;
  Image: TGpObject;
  Mask: TBitmap;
  PRec: PtPositionRec;
  BW, BH, X, Y, X2, Y2, IW, IH, XOff, YOff: Integer;
  NewBitmap, NewMask: TBitmap;

begin
  ARect := Rect(ALeft, ATop, ALeft + AWidth, ATop + AHeight);
  Image := FSectionList.BackgroundBitmap;
  if FSectionList.ShowImages and Assigned(Image) then
    begin
      Mask := FSectionList.BackgroundMask;
      BW := GetImageWidth(Image);
      BH := GetImageHeight(Image);
      PRec := FSectionList.BackgroundPRec;
      XOff := -ALeft;
      YOff := -ATop;
      IW := AWidth;
      IH := AHeight;

      { Calculate where the tiled background images go }
      CalcBackgroundLocationAndTiling(PRec, ARect, XOff, YOff, IW, IH, BW, BH, X, Y, X2, Y2);

      if (BW = 1) or (BH = 1) then
        begin { this is for people who try to tile 1 pixel images }
          NewBitmap := EnlargeImage(Image, X2 - X, Y2 - Y);
          try
            if Assigned(Mask) then
              NewMask := TBitmap(EnlargeImage(Mask, X2 - X, Y2 - Y))
            else
              NewMask := nil;
            try
              DrawBackground2(ACanvas, ARect, X, Y, X2, Y2, NewBitmap, NewMask, NewBitmap.Width, NewBitmap.Height, AColor);
            finally
              NewMask.Free;
            end;
          finally
            NewBitmap.Free;
          end;
        end
      else
        DrawBackground2(ACanvas, ARect, X, Y, X2, Y2, Image, Mask, BW, BH, AColor);
    end
  else
    begin { no background image, show color only }
      DrawBackground2(ACanvas, ARect, 0, 0, 0, 0, nil, nil, 0, 0, AColor);
    end;
end;

function THTMLViewer.MakeBitmap(YTop, FormatWidth, Width, Height: Integer): TBitmap;
var
  CopyList: TSectionList;
  Dummy: Integer;
  Curs: Integer;
  DocHeight: Integer;
begin
  Result := nil;
  if FProcessing or (FSectionList.Count = 0) then
    Exit;
  { if Height > 4000 then
    raise EExcessiveSizeError.Create('Vertical Height exceeds 4000'); }
  CopyList := TSectionList.CreateCopy(FSectionList);
  try
    Result := TBitmap.Create;
    try
      Result.HandleType := BmDIB;
      Result.PixelFormat := Pf24Bit;
      Result.Width := Width;
      Result.Height := Height;
      Curs := 0;
      DocHeight := CopyList.DoLogic(Result.Canvas, 0, FormatWidth, Height, 300, Dummy, Curs);
      DoBackground1(Result.Canvas, YTop, Width, Height, DocHeight);

      CopyList.SetYOffset(IntMax(0, YTop));
      CopyList.Draw(Result.Canvas, Rect(0, 0, Width, Height), MaxHScroll, 0, 0, 0, 0);
    except
      Result.Free;
      Result := nil;
    end;
  finally
    CopyList.Free;
  end;
end;

procedure THTMLViewer.BackgroundChange(Sender: TObject);
begin
  PaintPanel.Color := (Sender as TSectionList).Background or PalRelative;
end;

procedure THTMLViewer.SetOnBitmapRequest(Handler: TGetBitmapEvent);
begin
  FOnBitmapRequest := Handler;
  FSectionList.GetBitmap := Handler;
end;

procedure THTMLViewer.SetOnImageRequest(Handler: TGetImageEvent);
begin
  FOnImageRequest := Handler;
  FSectionList.GetImage := Handler;
end;

procedure THTMLViewer.SetOnExpandName(Handler: TExpandNameEvent);
begin
  FOnExpandName := Handler;
  FSectionList.ExpandName := Handler;
end;

procedure THTMLViewer.SetOnScript(Handler: TScriptEvent);
begin
  FOnScript := Handler;
  FSectionList.ScriptEvent := Handler;
end;

procedure THTMLViewer.SetOnFileBrowse(Handler: TFileBrowseEvent);
begin
  FOnFileBrowse := Handler;
  FSectionList.FileBrowse := Handler;
end;

procedure THTMLViewer.SetOnObjectClick(Handler: TObjectClickEvent);
begin
  FOnObjectClick := Handler;
  FSectionList.ObjectClick := Handler;
end;

procedure THTMLViewer.SetOnObjectFocus(Handler: ThtObjectEvent);
begin
  FOnObjectFocus := Handler;
  FSectionList.ObjectFocus := Handler;
end;

procedure THTMLViewer.SetOnObjectBlur(Handler: ThtObjectEvent);
begin
  FOnObjectBlur := Handler;
  FSectionList.ObjectBlur := Handler;
end;

procedure THTMLViewer.SetOnObjectChange(Handler: ThtObjectEvent);
begin
  FOnObjectChange := Handler;
  FSectionList.ObjectChange := Handler;
end;

procedure THTMLViewer.SetOnPanelCreate(Handler: TPanelCreateEvent);
begin
  FOnPanelCreate := Handler;
  FSectionList.PanelCreateEvent := Handler;
end;

procedure THTMLViewer.SetOnPanelDestroy(Handler: TPanelDestroyEvent);
begin
  FOnPanelDestroy := Handler;
  FSectionList.PanelDestroyEvent := Handler;
end;

procedure THTMLViewer.SetOnPanelPrint(Handler: TPanelPrintEvent);
begin
  FOnPanelPrint := Handler;
  FSectionList.PanelPrintEvent := Handler;
end;

procedure THTMLViewer.SetOnFormSubmit(Handler: TFormSubmitEvent);
begin
  FOnFormSubmit := Handler;
  if Assigned(Handler) then
    FSectionList.SubmitForm := SubmitForm
  else
    FSectionList.SubmitForm := nil;
end;

procedure THTMLViewer.SubmitForm(Sender: TObject; const Action, Target, EncType, Method: string; Results: TStringList);
begin
  if Assigned(FOnFormSubmit) then
    begin
      FAction := Action;
      FMethod := Method;
      FFormTarget := Target;
      FEncType := EncType;
      FStringList := Results;
      PostMessage(Handle, Wm_FormSubmit, 0, 0);
    end;
end;

procedure THTMLViewer.WMFormSubmit(var message: TMessage);
begin
  FOnFormSubmit(Self, FAction, FFormTarget, FEncType, FMethod, FStringList);
end; { user disposes of the TStringList }

function THTMLViewer.Find(const S: WideString; MatchCase: Boolean): Boolean;
begin
  Result := FindEx(S, MatchCase, False);
end;

function THTMLViewer.FindEx(const S: WideString; MatchCase, Reverse: Boolean): Boolean;

var
  Curs: Integer;
  X: Integer;
  Y, Pos: Integer;
  S1: WideString;
begin
  Result := False;
  if S = '' then
    Exit;
  with FSectionList do
    begin
      if MatchCase then
        S1 := S
      else
        S1 := WideLowerCase1(S);
      if Reverse then
        Curs := FindStringR(CaretPos, S1, MatchCase)
      else
        Curs := FindString(CaretPos, S1, MatchCase);
      if Curs >= 0 then
        begin
          Result := True;
          SelB := Curs;
          SelE := Curs + Length(S);
          if Reverse then
            CaretPos := SelB
          else
            CaretPos := SelE;
          if CursorToXy(PaintPanel.Canvas, Curs, X, Y) then
            begin
              Pos := VScrollBarPosition;
              if (Y < Pos) or (Y > Pos + ClientHeight - 20) then
                VScrollBarPosition := (Y - ClientHeight div 2);

              Pos := HScrollBarPosition;
              if (X < Pos) or (X > Pos + ClientWidth - 50) then
                HScrollBarPosition := (X - ClientWidth div 2);
              Invalidate;
            end;
        end;
    end;
end;

procedure THTMLViewer.FormControlEnterEvent(Sender: TObject);

var
  Y, Pos: Integer;
begin
  if Sender is TFormControlObj then
    begin
      Y := TFormControlObj(Sender).YValue;
      Pos := VScrollBarPosition;
      if (Y < Pos) or (Y > Pos + ClientHeight - 20) then
        begin
          VScrollBarPosition := (Y - ClientHeight div 2);
          Invalidate;
        end;
    end
  else if Sender is TFontObj and not NoJump then
    begin
      Y := TFontObj(Sender).YValue;
      Pos := VScrollBarPosition;
      if (Y < Pos) then
        VScrollBarPosition := Y
      else if (Y > Pos + ClientHeight - 30) then
        VScrollBarPosition := (Y - ClientHeight div 2);
      Invalidate;
    end
end;

procedure THTMLViewer.SelectAll;
begin
  with FSectionList do
    if (Count > 0) and not FNoSelect then
      begin
        SelB := 0;
        with TSectionBase(Items[Count - 1]) do
          SelE := StartCurs + Len;
        Invalidate;
      end;
end;

{ ----------------ThtmlViewer.InitLoad }
procedure THTMLViewer.InitLoad;
begin
  if not Assigned(FSectionList.BitmapList) then
    begin
      FSectionList.BitmapList := TStringBitmapList.Create;
      FSectionList.BitmapList.Sorted := True;
      FSectionList.BitmapList.SetCacheCount(FImageCacheCount);
      LocalBitmapList := True;
    end;
  FSectionList.Clear;
  UpdateImageCache;
  FSectionList.SetFonts(FFontName, FPreFontName, FFontSize, FFontColor, FHotSpotColor, FVisitedColor, FOverColor, FBackGround,
    HtOverLinksActive in FOptions, not(HtNoLinkUnderline in FOptions), FCharset, FMarginHeight, FMarginWidth);
end;

{ ----------------ThtmlViewer.Clear }
procedure THTMLViewer.Clear;
{ Note: because of Frames do not clear history list here }
begin
  if FProcessing then
    Exit;
  HTMLTimer.Enabled := False;
  FSectionList.Clear;
  if LocalBitmapList then
    FSectionList.BitmapList.Clear;
  FSectionList.SetFonts(FFontName, FPreFontName, FFontSize, FFontColor, FHotSpotColor, FVisitedColor, FOverColor, FBackGround,
    HtOverLinksActive in FOptions, not(HtNoLinkUnderline in FOptions), FCharset, FMarginHeight, FMarginWidth);
  FBase := '';
  FBaseEx := '';
  FBaseTarget := '';
  FTitle := '';
  VScrollBar.Max := 0;
  VScrollBar.Visible := False;
  VScrollBar.Height := PaintPanel.Height;
  HScrollBar.Visible := False;
  CaretPos := 0;
  Sel1 := -1;
  if Assigned(FOnSoundRequest) then
    FOnSoundRequest(Self, '', 0, True);
  Invalidate;
end;

procedure THTMLViewer.PaintWindow(DC: HDC);
begin
  PaintPanel.Repaint;
  BorderPanel.Repaint;
  VScrollBar.Repaint;
  HScrollBar.Repaint;
end;

procedure THTMLViewer.CopyToClipboard;

const
  StartFrag = '<!--StartFragment-->';
  EndFrag = '<!--EndFragment-->';
  DocType = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">'#13#10;

var
  Leng: Integer;
  StSrc, EnSrc: Integer;
  HTML: AnsiString;
  Format: UINT;

procedure CopyFormatToClipBoard(const Source: AnsiString; Format: UINT);

// Put SOURCE on the clipboard, using FORMAT as the clipboard format
// Based on http://www.lorriman.com/programming/cf_html.html
var
  GMem: HGLOBAL;
  Lp: PAnsichar;
begin
  Clipboard.Open;
  try
    // an extra "1" for the null terminator
    GMem := Globalalloc(GMEM_DDESHARE + GMEM_MOVEABLE, Length(Source) + 1);
    Lp := Globallock(GMem);
    Copymemory(Lp, PAnsichar(Source), Length(Source) + 1);
    Globalunlock(GMem);
    SetClipboarddata(Format, GMem);
  finally
    Clipboard.Close;
  end
end;

function GetHeader(const HTML: string): string;

const
  Version = 'Version:1.0'#13#10;
  StartHTML = 'StartHTML:';
  EndHTML = 'EndHTML:';
  StartFragment = 'StartFragment:';
  EndFragment = 'EndFragment:';
  SourceURL = 'SourceURL:';
  NumberLengthAndCR = 10;

  // Let the compiler determine the description length.
  PreliminaryLength = Length(Version) + Length(StartHTML) + Length(EndHTML) + Length(StartFragment) + Length(EndFragment)
    + 4 * NumberLengthAndCR + 2;

  { 2 for last CRLF }
var
  URLString: string;
  StartHTMLIndex, EndHTMLIndex, StartFragmentIndex, EndFragmentIndex: Integer;
begin
  if CurrentFile = '' then
    URLString := SourceURL + 'unsaved:///ThtmlViewer.htm'
  else if Pos('://', CurrentFile) > 0 then
    URLString := SourceURL + CurrentFile { already has protocol }
  else
    URLString := SourceURL + 'file://' + CurrentFile;
  StartHTMLIndex := PreliminaryLength + Length(URLString);
  EndHTMLIndex := StartHTMLIndex + Length(HTML);
  StartFragmentIndex := StartHTMLIndex + Pos(StartFrag, HTML) + Length(StartFrag) - 1;
  EndFragmentIndex := StartHTMLIndex + Pos(EndFrag, HTML) - 1;

  Result := Version + SysUtils.Format('%s%.8d', [StartHTML, StartHTMLIndex]) + #13#10 + SysUtils.Format('%s%.8d', [EndHTML, EndHTMLIndex])
    + #13#10 + SysUtils.Format('%s%.8d', [StartFragment, StartFragmentIndex]) + #13#10 + SysUtils.Format
    ('%s%.8d', [EndFragment, EndFragmentIndex]) + #13#10 + URLString + #13#10;
end;

function Truncate(const S: string): string;

var
  I: Integer;
begin
  I := Pos(EndFrag, S);
  Result := S;
  if I > 0 then
    Result := Copy(Result, 1, I + Length(EndFrag) - 1);
end;

procedure RemoveTag(const Tag: AnsiString);

{ remove all the tags that look like "<tag .....>" }
var
  I: Integer;
  L: AnsiString;
  C: Ansichar;
begin
  L := Lowercase(HTML);
  I := Pos(Tag, L);
  while (I > 0) do
    begin
      Delete(HTML, I, Length(Tag));
      repeat
        if I <= Length(HTML) then
          C := HTML[I]
        else
          C := #0;
        Delete(HTML, I, 1);
      until C in ['>', #0];
      L := Lowercase(HTML);
      I := Pos(Tag, L);
    end;
end;

procedure MessUp(const S: string);

var
  I: Integer;
  L: string;
begin
  L := Lowercase(HTML);
  I := Pos(S, L);
  while (I > 0) do
    begin
      Delete(HTML, I, 1);
      L := Lowercase(HTML);
      I := Pos(S, L);
    end;
end;

function ConvertToUTF8(const S: AnsiString): AnsiString;

var
  Len, Len1: Integer;
  WS: WideString;
begin
  if CodePage = CP_UTF8 then
    begin
      Result := S;
      Exit;
    end;
  Len := Length(S);
  SetLength(WS, Len);
  Len := MultibyteToWideChar(CodePage, 0, PAnsichar(S), Len, PWideChar(WS), Len);
  Len1 := 4 * Len;
  SetLength(Result, Len1);
  Len1 := WideCharToMultibyte(CP_UTF8, 0, PWideChar(WS), Len, PAnsichar(Result), Len1, nil, nil);
  SetLength(Result, Len1);
end;

procedure InsertDefaultFontInfo;

var
  I: Integer;
  S, L: AnsiString;
  HeadFound: Boolean;
begin
  L := Lowercase(HTML);
  I := Pos('<head>', L);
  HeadFound := I > 0;
  if not HeadFound then
    I := Pos('<html>', L);
  if I <= 0 then
    I := 1;
  S := '<style> body {font-size: ' + IntToStr(DefFontSize) + 'pt; font-family: "' + DefFontName + '"; }</style>';
  if not HeadFound then
    S := '<head>' + S + '</head>';
  Insert(S, HTML, I);
end;

procedure BackupToContent;

var
  C: Ansichar;
  I: Integer;

procedure GetC; { reads characters backwards }
begin
  if I - 1 > StSrc then
    begin
      Dec(I);
      C := HTML[I];
    end
  else
    C := #0;
end;

begin
  I := EnSrc;
  repeat
    repeat { skip past white space }
      GetC;
    until C in [#0, '!' .. #255];
    if C = '>' then
      repeat { read thru a tag }
        repeat
          GetC;
        until C in [#0, '<'];
        GetC;
      until C <> '>';
      until C in [#0, '!' .. #255]; { until found some content }
    if C = #0 then
      Dec(I);
    HTML := Copy(HTML, 1, I); { truncate the tags }
  end;

  begin
    Leng := FSectionList.GetSelLength;
    if Leng = 0 then
      Exit;
    FSectionList.CopyToClipboardA(Leng + 1);

    HTML := DocumentSource;
    StSrc := FindSourcePos(FSectionList.SelB) + 1;
    EnSrc := FindSourcePos(FSectionList.SelE);
    if EnSrc < 0 then
      { check to see if end selection is at end of document }
      begin
        EnSrc := Length(HTML);
        if HTML[EnSrc] = '>' then
          begin
            HTML := HTML + ' ';
            Inc(EnSrc);
          end;
      end
    else
      EnSrc := EnSrc + 1;
    { Truncate beyond EnSrc }
    HTML := Copy(HTML, 1, EnSrc - 1);
    { Also remove any tags on the end }
    BackupToContent;
    { insert the StartFrag string }
    Insert(StartFrag, HTML, StSrc);
    { Remove all Meta tags, in particular the ones that specify language, but others
      seem to cause problems also }
    RemoveTag('<meta');
    { Remove <!doctype> in preparation to having one added }
    RemoveTag('<!doctype');
    { page-break-... stylesheet properties cause a hang in Word -- mess them up }
    MessUp('page-break-');
    { Add in default font information which wouldn't be in the HTML }
    InsertDefaultFontInfo;
    { Convert character set to UTF-8 }
    HTML := ConvertToUTF8(HTML);
    { Add Doctype tag at start }
    HTML := DocType + HTML;
    { Append the EndFrag string }
    HTML := HTML + EndFrag;
    { Add the header to start }
    HTML := GetHeader(HTML) + HTML;

    Format := RegisterClipboardFormat('HTML Format');
    { not sure this is necessary }
    CopyFormatToClipBoard(HTML, Format);
  end;

  function THTMLViewer.GetSelTextBuf(Buffer: PWideChar; BufSize: Integer): Integer;
  begin
    if BufSize <= 0 then
      Result := 0
    else
      Result := FSectionList.GetSelTextBuf(Buffer, BufSize);
  end;

  function THTMLViewer.GetSelText: WideString;
  var
    Len: Integer;
  begin
    Len := FSectionList.GetSelLength;
    if Len > 0 then
      begin
        SetString(Result, nil, Len);
        FSectionList.GetSelTextBuf(Pointer(Result), Len + 1);
      end
    else
      Result := '';
  end;

  function THTMLViewer.GetSelLength: Integer;
  begin
    with FSectionList do
      if FCaretPos = SelB then
        Result := SelE - SelB
      else
        Result := SelB - SelE;
  end;

  procedure THTMLViewer.SetSelLength(Value: Integer);
  begin
    with FSectionList do
      begin
        if Value >= 0 then
          begin
            SelB := FCaretPos;
            SelE := FCaretPos + Value;
          end
        else
          begin
            SelE := FCaretPos;
            SelB := FCaretPos + Value;
          end;
        Invalidate;
      end;
  end;

  procedure THTMLViewer.SetSelStart(Value: Integer);
  begin
    with FSectionList do
      begin
        FCaretPos := Value;
        SelB := Value;
        SelE := Value;
        Invalidate;
      end;
  end;

  procedure THTMLViewer.SetNoSelect(Value: Boolean);
  begin
    if Value <> FNoSelect then
      begin
        FNoSelect := Value;
        if Value = True then
          begin
            FSectionList.SelB := -1;
            FSectionList.SelE := -1;
            Repaint;
          end;
      end;
  end;

  procedure THTMLViewer.UpdateImageCache;
  begin
    FSectionList.BitmapList.BumpAndCheck;
  end;

  procedure THTMLViewer.SetImageCacheCount(Value: Integer);
  begin
    Value := IntMax(0, Value);
    Value := IntMin(20, Value);
    if Value <> FImageCacheCount then
      begin
        FImageCacheCount := Value;
        if Assigned(FSectionList.BitmapList) then
          FSectionList.BitmapList.SetCacheCount(FImageCacheCount);
      end;
  end;

  procedure THTMLViewer.SetStringBitmapList(BitmapList: TStringBitmapList);
  begin
    FSectionList.BitmapList := BitmapList;
    LocalBitmapList := False;
  end;

  procedure THTMLViewer.DrawBorder;
  begin
    if (Focused and (FBorderStyle = HtFocused)) or (FBorderStyle = HtSingle) or (CsDesigning in ComponentState) then
      BorderPanel.BorderStyle := BsSingle
    else
      BorderPanel.BorderStyle := BsNone;
  end;

  procedure THTMLViewer.DoEnter;
  begin
    inherited DoEnter;
    DrawBorder;
  end;

  procedure THTMLViewer.DoExit;
  begin
    inherited DoExit;
    DrawBorder;
  end;

  procedure THTMLViewer.SetScrollBars(Value: TScrollStyle);
  begin
    if (Value <> FScrollBars) then
      begin
        FScrollBars := Value;
        if not(CsLoading in ComponentState) and HandleAllocated then
          begin
            SetProcessing(True);
            try
              DoLogic;
            finally
              SetProcessing(False);
            end;
            Invalidate;
          end;
      end;
  end;

  { ----------------ThtmlViewer.Reload }
  procedure THTMLViewer.Reload; { reload the last file }
  var
    Pos: Integer;
  begin
    if FCurrentFile <> '' then
      begin
        Pos := Position;
        if FCurrentFileType = HTMLType then
          LoadFromFile(FCurrentFile)
        else if FCurrentFileType = TextType then
          LoadTextFile(FCurrentFile)
        else
          LoadImageFile(FCurrentFile);
        Position := Pos;
      end;
  end;

  { ----------------ThtmlViewer.GetOurPalette: }
  function THTMLViewer.GetOurPalette: HPalette;
  begin
    if ColorBits = 8 then
      Result := CopyPalette(ThePalette)
    else
      Result := 0;
  end;

  { ----------------ThtmlViewer.SetOurPalette }
  procedure THTMLViewer.SetOurPalette(Value: HPalette);
  var
    NewPalette: HPalette;
  begin
    if (Value <> 0) and (ColorBits = 8) then
      begin
        NewPalette := CopyPalette(Value);
        if NewPalette <> 0 then
          begin
            if ThePalette <> 0 then
              DeleteObject(ThePalette);
            ThePalette := NewPalette;
            if FDither then
              SetGlobalPalette(ThePalette);
          end;
      end;
  end;

  { ----------------ThtmlViewer.SetDither }
  procedure THTMLViewer.SetDither(Value: Boolean);
  begin
    if (Value <> FDither) and (ColorBits = 8) then
      begin
        FDither := Value;
        if Value then
          SetGlobalPalette(ThePalette)
        else
          SetGlobalPalette(0);
      end;
  end;

  procedure THTMLViewer.SetCaretPos(Value: Integer);
  begin
    if Value >= 0 then
      begin
        FCaretPos := Value;
      end;
  end;

  function THTMLViewer.FindSourcePos(DisplayPos: Integer): Integer;
  begin
    Result := FSectionList.FindSourcePos(DisplayPos);
  end;

  function THTMLViewer.FindDisplayPos(SourcePos: Integer; Prev: Boolean): Integer;
  begin
    Result := FSectionList.FindDocPos(SourcePos, Prev);
  end;

  function THTMLViewer.DisplayPosToXy(DisplayPos: Integer; var X, Y: Integer): Boolean;
  begin
    Result := FSectionList.CursorToXy(PaintPanel.Canvas, DisplayPos, X, Integer(Y)); { integer() req'd for delphi 2 }
  end;

  { ----------------ThtmlViewer.SetProcessing }
  procedure THTMLViewer.SetProcessing(Value: Boolean);
  begin
    if FProcessing <> Value then
      begin
        FProcessing := Value;
        if Assigned(FOnProcessing) and not(CsLoading in ComponentState) then
          FOnProcessing(Self, FProcessing);
      end;
  end;

  procedure THTMLViewer.SetServerRoot(Value: string);
  begin
    Value := Trim(Value);
    if (Length(Value) >= 1) and (Value[Length(Value)] = '\') then
      SetLength(Value, Length(Value) - 1);
    FServerRoot := Value;
  end;

  procedure THTMLViewer.HandleMeta(Sender: TObject; const HttpEq, name, Content: string);
  var
    DelTime, I: Integer;
  begin
    if Assigned(FOnMeta) then
      FOnMeta(Self, HttpEq, name, Content);
    if Assigned(FOnMetaRefresh) then
      if CompareText(Lowercase(HttpEq), 'refresh') = 0 then
        begin
          I := Pos(';', Content);
          if I > 0 then
            DelTime := StrToIntDef(Copy(Content, 1, I - 1), -1)
          else
            DelTime := StrToIntDef(Content, -1);
          if DelTime < 0 then
            Exit
          else if DelTime = 0 then
            DelTime := 1;
          I := Pos('url=', Lowercase(Content));
          if I > 0 then
            FRefreshURL := Copy(Content, I + 4, Length(Content) - I - 3)
          else
            FRefreshURL := '';
          FRefreshDelay := DelTime;
        end;
  end;

  procedure THTMLViewer.SetOptions(Value: ThtmlViewerOptions);
  begin
    if Value <> FOptions then
      begin
        FOptions := Value;
        if Assigned(FSectionList) then
          with FSectionList do
            begin
              LinksActive := HtOverLinksActive in FOptions;
              PrintTableBackground := (HtPrintTableBackground in FOptions) or (HtPrintBackground in FOptions);
              PrintBackground := HtPrintBackground in FOptions;
              PrintMonoBlack := HtPrintMonochromeBlack in FOptions;
              ShowDummyCaret := HtShowDummyCaret in FOptions;
            end;
      end;
  end;

  procedure THTMLViewer.Repaint;
  var
    I: Integer;
  begin
    for I := 0 to FormControlList.Count - 1 do
      with TFormControlObj(FormControlList.Items[I]) do
        if Assigned(TheControl) then
          TheControl.Hide;
    BorderPanel.BorderStyle := BsNone;
    inherited Repaint;
  end;

  function THTMLViewer.GetDragDrop: TDragDropEvent;
  begin
    Result := FOnDragDrop;
  end;

  procedure THTMLViewer.SetDragDrop(const Value: TDragDropEvent);
  begin
    FOnDragDrop := Value;
    if Assigned(Value) then
      PaintPanel.OnDragDrop := HTMLDragDrop
    else
      PaintPanel.OnDragDrop := nil;
  end;

  procedure THTMLViewer.HTMLDragDrop(Sender, Source: TObject; X, Y: Integer);
  begin
    if Assigned(FOnDragDrop) then
      FOnDragDrop(Self, Source, X, Y);
  end;

  function THTMLViewer.GetDragOver: TDragOverEvent;
  begin
    Result := FOnDragOver;
  end;

  procedure THTMLViewer.SetDragOver(const Value: TDragOverEvent);
  begin
    FOnDragOver := Value;
    if Assigned(Value) then
      PaintPanel.OnDragOver := HTMLDragOver
    else
      PaintPanel.OnDragOver := nil;
  end;

  procedure THTMLViewer.HTMLDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
  begin
    if Assigned(FOnDragOver) then
      FOnDragOver(Self, Source, X, Y, State, Accept);
  end;

  function THTMLViewer.GetFormData: TFreeList;
  begin
    if Assigned(SectionList) then
      Result := SectionList.GetFormControlData
    else
      Result := nil;
  end;

  procedure THTMLViewer.SetFormData(T: TFreeList);
  begin
    if Assigned(SectionList) and Assigned(T) then
      with SectionList do
        begin
          ObjectClick := nil;
          SetFormControlData(T);
          ObjectClick := FOnObjectClick;
        end;
  end;

  procedure THTMLViewer.ReplaceImage(const NameID: string; NewImage: TStream);
  var
    I: Integer;
    OldPos: Integer;
  begin
    if FNameList.Find(NameID, I) then
      if FNameList.Objects[I] is TImageObj then
        begin
          TImageObj(FNameList.Objects[I]).ReplaceImage(NewImage);
          if not TImageObj(FNameList.Objects[I]).ImageKnown then
            if FSectionList.Count > 0 then
              begin
                FSectionList.GetBackgroundBitmap; { load any background bitmap }
                OldPos := Position;
                DoLogic;
                Position := OldPos;
              end;
        end;
  end;

  function THTMLViewer.GetIDControl(const ID: string): TObject;
  var
    I: Integer;
    Obj: TObject;
  begin
    Result := nil;
    with FSectionList.IDNameList do
      if Find(ID, I) then
        begin
          Obj := Objects[I];
          if (Obj is TFormControlObj) then
            begin
              if (Obj is THiddenFormControlObj) then
                Result := Obj
              else
                Result := TFormControlObj(Obj).TheControl;
            end
          else if (Obj is TImageObj) then
            Result := Obj;
        end;
  end;

  function THTMLViewer.GetIDDisplay(const ID: string): Boolean;
  var
    I: Integer;
    Obj: TObject;
  begin
    Result := False;
    with FSectionList.IDNameList do
      if Find(ID, I) then
        begin
          Obj := Objects[I];
          if (Obj is TBlock) then
            Result := not TBlock(Obj).DisplayNone;
        end;
  end;

  procedure THTMLViewer.SetIDDisplay(const ID: string; Value: Boolean);
  var
    I: Integer;
    Obj: TObject;
  begin
    with FSectionList.IDNameList do
      if Find(ID, I) then
        begin
          Obj := Objects[I];
          if (Obj is TBlock) and (TBlock(Obj).DisplayNone = Value) then
            begin
              FSectionList.HideControls;
              TBlock(Obj).DisplayNone := not Value;
            end;
        end;
  end;

  procedure THTMLViewer.SetPrintScale(Value: Double);
  begin
    if Value > 4.0 then
      FPrintScale := 4.0
    else if Value < 0.25 then
      FPrintScale := 0.25
    else
      FPrintScale := Value;
  end;

  procedure THTMLViewer.Reformat;
  var
    Pt: TPoint;
  begin
    Layout;
    Update;
    GetCursorPos(Pt);
    SetCursorPos(Pt.X, Pt.Y); { trigger a mousemove to keep cursor correct }
  end;

  procedure THTMLViewer.HtProgressInit;
  begin
    if Assigned(FOnProgress) then
      FOnProgress(Self, PsStarting, 0);
  end;

  procedure THTMLViewer.HtProgress(Percent: Integer);
  begin
    if Assigned(FOnProgress) then
      FOnProgress(Self, PsRunning, Percent);
  end;

  procedure THTMLViewer.HtProgressEnd;
  begin
    if Assigned(FOnProgress) then
      FOnProgress(Self, PsEnding, 100);
  end;

  { ----------------TPaintPanel.CreateIt }
  constructor TPaintPanel.CreateIt(AOwner: TComponent; Viewer: THTMLViewer);

  begin
    inherited Create(AOwner);
    FViewer := Viewer;
  end;

  { ----------------TPaintPanel.Paint }
  procedure TPaintPanel.Paint;
  var
    MemDC: HDC;
    ABitmap: HBitmap;
    ARect: TRect;
    OldPal: HPalette;
  begin
    if FViewer.DontDraw or (Canvas2 <> nil) then
      Exit;
    FViewer.DrawBorder;
    OldPal := 0;
    Canvas.Font := Font;
    Canvas.Brush.Color := Color;
    ARect := Canvas.ClipRect;
    Canvas2 := TCanvas.Create; { paint on a memory DC }
    try
      MemDC := CreateCompatibleDC(Canvas.Handle);
      ABitmap := 0;
      try
        with ARect do
          begin
            ABitmap := CreateCompatibleBitmap(Canvas.Handle, Right - Left, Bottom - Top);
            if (ABitmap = 0) and (Right - Left + Bottom - Top <> 0) then
              raise EOutOfResources.Create('Out of Resources');
            try
              SelectObject(MemDC, ABitmap);
              SetWindowOrgEx(MemDC, Left, Top, nil);
              Canvas2.Handle := MemDC;
              DoBackground(Canvas2);
              if Assigned(FOnPaint) then
                FOnPaint(Self);
              OldPal := SelectPalette(Canvas.Handle, ThePalette, False);
              RealizePalette(Canvas.Handle);
              BitBlt(Canvas.Handle, Left, Top, Right - Left, Bottom - Top, MemDC, Left, Top, SRCCOPY);
            finally
              if OldPal <> 0 then
                SelectPalette(MemDC, OldPal, False);
              Canvas2.Handle := 0;
            end;
          end;
      finally
        DeleteDC(MemDC);
        DeleteObject(ABitmap);
      end;
    finally
      FreeAndNil(Canvas2);
    end;
  end;

  procedure TPaintPanel.DoBackground(ACanvas: TCanvas);
  var
    ARect: TRect;
    Image: TGpObject;
    Mask, NewBitmap, NewMask: TBitmap;
    PRec: PtPositionRec;
    BW, BH, X, Y, X2, Y2, IW, IH, XOff, YOff: Integer;
    AniGif: TGifImage;

  begin
    with FViewer do
      begin
        if FSectionList.Printing then
          Exit; { no background }

        ARect := Canvas.ClipRect;
        Image := FSectionList.BackgroundBitmap;
        if FSectionList.ShowImages and Assigned(Image) then
          begin
            Mask := FSectionList.BackgroundMask;
            BW := GetImageWidth(Image);
            BH := GetImageHeight(Image);
            PRec := FSectionList.BackgroundPRec;
            BGFixed := PRec[1].Fixed;
            if BGFixed then
              begin { fixed background }
                XOff := 0;
                YOff := 0;
                IW := Self.ClientRect.Right;
                IH := Self.ClientRect.Bottom;
              end
            else
              begin { scrolling background }
                XOff := HScrollBar.Position;
                YOff := FSectionList.YOff;
                IW := HScrollBar.Max;
                IH := IntMax(MaxVertical, Self.ClientRect.Bottom);
              end;

            { Calculate where the tiled background images go }
            CalcBackgroundLocationAndTiling(PRec, ARect, XOff, YOff, IW, IH, BW, BH, X, Y, X2, Y2);

            if (BW = 1) or (BH = 1) then
              begin { this is for people who try to tile 1 pixel images }
                NewBitmap := EnlargeImage(Image, X2 - X, Y2 - Y); // as TBitmap;
                try
                  if Assigned(Mask) then
                    NewMask := TBitmap(EnlargeImage(Mask, X2 - X, Y2 - Y))
                  else
                    NewMask := nil;
                  try
                    DrawBackground(ACanvas, ARect, X, Y, X2, Y2, NewBitmap, NewMask, nil, NewBitmap.Width, NewBitmap.Height, Self.Color);
                  finally
                    NewMask.Free;
                  end;
                finally
                  NewBitmap.Free;
                end;
              end
            else { normal situation }
              begin
                AniGif := FSectionList.BackgroundAniGif;
                DrawBackground(ACanvas, ARect, X, Y, X2, Y2, Image, Mask, AniGif, BW, BH, Self.Color);
              end;
          end
        else
          begin { no background image, show color only }
            BGFixed := False;
            DrawBackground(ACanvas, ARect, 0, 0, 0, 0, nil, nil, nil, 0, 0, Self.Color);
          end;
      end;
  end;

  procedure TPaintPanel.WMEraseBkgnd(var message: TWMEraseBkgnd);
  begin
    message.Result := 1; { it's erased }
  end;

  { ----------------TPaintPanel.WMLButtonDblClk }
  procedure TPaintPanel.WMLButtonDblClk(var message: TWMMouse);
  begin
    if message.Keys and MK_LButton <> 0 then
      THTMLViewer(FViewer).HTMLMouseDblClk(message);
  end;

  { ----------------T32ScrollBar.SetParams }
  procedure T32ScrollBar.SetParams(APosition, APage, AMin, AMax: Integer);
  var
    ScrollInfo: TScrollInfo;
  begin
    if (APosition <> FPosition) or (APage <> FPage) or (AMin <> FMin) or (AMax <> FMax) then
      with ScrollInfo do
        begin
          CbSize := SizeOf(ScrollInfo);
          FMask := SIF_ALL;
          if HtShowVScroll in (Owner as THTMLViewer).FOptions then
            FMask := FMask or SIF_DISABLENOSCROLL;
          NPos := APosition;
          NPage := APage;
          NMin := AMin;
          NMax := AMax;
          SetScrollInfo(Handle, SB_CTL, ScrollInfo, True);
          FPosition := APosition;
          FPage := APage;
          FMin := AMin;
          FMax := AMax;
        end;
  end;

  procedure T32ScrollBar.SetPosition(Value: Integer);
  var
    SavePos: Integer;
  begin
    SavePos := FPosition;
    SetParams(Value, FPage, FMin, FMax);
    if FPosition <> SavePos then
      Change;
  end;

  procedure T32ScrollBar.SetMin(Value: Integer);
  begin
    SetParams(FPosition, FPage, Value, FMax);
  end;

  procedure T32ScrollBar.SetMax(Value: Integer);
  begin
    SetParams(FPosition, FPage, FMin, Value);
  end;

  procedure T32ScrollBar.CNVScroll(var message: TWMVScroll);
  var
    SPos: Integer;
    ScrollInfo: TScrollInfo;
    OrigPos: Integer;
    TheChange: Integer;
  begin
    with THTMLViewer(Parent) do
      begin
        ScrollInfo.CbSize := SizeOf(ScrollInfo);
        ScrollInfo.FMask := SIF_ALL;
        GetScrollInfo(Self.Handle, SB_CTL, ScrollInfo);
        if TScrollCode(message.ScrollCode) = ScTrack then
          begin
            OrigPos := ScrollInfo.NPos;
            SPos := ScrollInfo.NTrackPos;
          end
        else
          begin
            SPos := ScrollInfo.NPos;
            OrigPos := SPos;
            case TScrollCode(message.ScrollCode) of
              ScLineUp: Dec(SPos, SmallChange);
              ScLineDown: Inc(SPos, SmallChange);
              ScPageUp: Dec(SPos, LargeChange);
              ScPageDown: Inc(SPos, LargeChange);
              ScTop: SPos := 0;
              ScBottom: SPos := (FMaxVertical - PaintPanel.Height);
            end;
          end;
        SPos := IntMax(0, IntMin(SPos, (FMaxVertical - PaintPanel.Height)));

        Self.SetPosition(SPos);

        FSectionList.SetYOffset(SPos);
        if BGFixed then
          PaintPanel.Invalidate
        else
          begin { scroll background }
            TheChange := OrigPos - SPos;
            ScrollWindow(PaintPanel.Handle, 0, TheChange, nil, nil);
            PaintPanel.Update;
          end;
      end;
  end;

  { PositionObj }

  destructor PositionObj.Destroy;
  begin
    FormData.Free;
    inherited;
  end;

end.
