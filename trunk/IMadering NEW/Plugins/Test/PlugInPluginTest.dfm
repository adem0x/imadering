object PluginTest: TPluginTest
  OldCreateOrder = False
  Author = 'Edward Tolmachev'
  Commands = <
    item
      Name = 'Command_Plugin_Menu_Icon'
      ShortCut = 0
    end
    item
      Name = 'Command_Show_Test'
      ShortCut = 0
      OnExecute = PluginTestCommands0Execute
    end
    item
      Name = 'Command_Menu_Separator'
      ShortCut = 0
    end
    item
      Name = 'Command_Show_Setting'
      ShortCut = 0
    end>
  Description = 'Test plugin'
  Copyright = 'Project IMadering'
  PluginVersion = '1.0'
  OnPluginMessage = JvPlugInPluginMessage
  OnPluginMessageWithObj = JvPlugInPluginMessageWithObj
  OnInitialize = JvPlugInInitialize
  OnConfigure = JvPlugInConfigure
  Height = 150
  Width = 215
  object Image_List: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Left = 88
    Top = 48
  end
end
