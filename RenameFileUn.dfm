object Form1: TForm1
  Left = 192
  Top = 116
  Width = 870
  Height = 640
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object DirViewPanel: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 582
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    OnResize = DirViewPanelResize
    object DirPanel: TPanel
      Left = 0
      Top = 0
      Width = 185
      Height = 582
      Align = alClient
      Alignment = taLeftJustify
      BevelInner = bvLowered
      BevelOuter = bvNone
      BorderWidth = 1
      TabOrder = 0
      OnResize = DirPanelResize
      object DirectoryListBox: TDirectoryListBox
        Left = 2
        Top = 2
        Width = 181
        Height = 551
        Align = alTop
        DirLabel = Label1
        FileList = FileListBox
        ItemHeight = 16
        TabOrder = 1
      end
      object DriveComboBox: TDriveComboBox
        Left = 2
        Top = 558
        Width = 183
        Height = 19
        DirList = DirectoryListBox
        TabOrder = 0
        TextCase = tcUpperCase
      end
    end
  end
  object Splitter: TPanel
    Left = 185
    Top = 0
    Width = 2
    Height = 582
    Cursor = crHSplit
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    OnMouseDown = SplitterMouseDown
    OnMouseMove = SplitterMouseMove
    OnMouseUp = SplitterMouseUp
  end
  object FileListPanel: TPanel
    Left = 187
    Top = 0
    Width = 667
    Height = 582
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    OnResize = FileListPanelResize
    object ListViewCaption: TPanel
      Left = 0
      Top = 0
      Width = 667
      Height = 21
      Align = alTop
      Alignment = taLeftJustify
      BevelInner = bvLowered
      BevelOuter = bvNone
      BorderWidth = 1
      TabOrder = 0
      object Label1: TLabel
        Left = 2
        Top = 2
        Width = 663
        Height = 17
        Align = alClient
        Caption = 'D:\...\Rename File\RenameFile'
      end
    end
    object Notebook: TNotebook
      Left = 0
      Top = 21
      Width = 667
      Height = 434
      Align = alClient
      Color = clBtnFace
      ParentColor = False
      TabOrder = 1
      object TPage
        Left = 0
        Top = 0
        Caption = 'ListViewPage'
        object FileListBox: TFileListBox
          Left = 0
          Top = 0
          Width = 667
          Height = 434
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
          OnChange = FileListBoxChange
        end
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 455
      Width = 667
      Height = 127
      Align = alBottom
      Alignment = taLeftJustify
      BevelInner = bvLowered
      BevelOuter = bvNone
      BorderWidth = 1
      TabOrder = 2
      object GroupBox1: TGroupBox
        Left = 2
        Top = 2
        Width = 663
        Height = 123
        Align = alClient
        Caption = 'Replace'
        TabOrder = 0
        object txOldEdit: TEdit
          Left = 10
          Top = 24
          Width = 177
          Height = 21
          Enabled = False
          TabOrder = 0
          Text = '*.*'
        end
        object ChangeForButton: TButton
          Left = 208
          Top = 24
          Width = 137
          Height = 29
          Caption = 'Change for'
          Enabled = False
          TabOrder = 1
          OnClick = ChangeForButtonClick
        end
        object txNewEdit: TEdit
          Left = 368
          Top = 24
          Width = 249
          Height = 21
          TabOrder = 2
          OnChange = txNewEditChange
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 582
    Width = 854
    Height = 19
    Panels = <>
  end
end
