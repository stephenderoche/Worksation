   M S B A M L   `   `   `  ����p  lLinedata.Framework.Client.NavDashBoardViewerPublisher, Version=5.1.0.0, Culture=neutral, PublicKeyToken=null}Cclr-namespace:Linedata.Framework.Client.NavDashBoardViewerPublisher5Linedata.Framework.Client.NavDashBoardViewerPublisher  5
      U    OLinedata.Framework.Client.NavDashBoardViewerPublisher.RoboViewerPublisherVisual   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35a ]DevExpress.Xpf.Core.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aW SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      ?dxe5http://schemas.devexpress.com/winfx/2008/xaml/editors  5      c _System.Windows.Interactivity, Version=4.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35Bi:http://schemas.microsoft.com/expression/2010/interactivity  5      ;dx2http://schemas.devexpress.com/winfx/2008/xaml/core  5      f bDevExpress.Xpf.Grid.v17.2.Core, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aa ]DevExpress.Xpf.Grid.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a>dxg2http://schemas.devexpress.com/winfx/2008/xaml/grid   5	      QlocalCclr-namespace:Linedata.Framework.Client.NavDashBoardViewerPublisher   5
      -   5        $
��auto��5      $
��auto��6-   .��5      � $��Stretch=�6   $
��auto��6'   
�������$
��Auto��6G   $��Stretch=�6U   .+�5   
   %  DevExpress.Xpf.Grid.GridControl  -   5           Name$  	RoboDrift��5      )  #DevExpress.Xpf.Grid.DataControlBase   AutoGenerateColumns$ AddNew=�5   :   #   EnableSmartColumnsGeneration .  $��SemiBold"�5   0      SelectionMode$	 Row=�6F      AllowLiveDataShaping$
 TrueX�6]   $��0,20,0,0q�5      $��Stretch=�6-   !   HorizontalContentAlignment$ Stretch=�6K   9  3DevExpress.Xpf.Grid.DataControlSerializationOptions   AddNewColumns .    RemoveOldColumns .     ItemsSource 5      �� *Table1+	   View	 5      #  DevExpress.Xpf.Grid.TableView  5      -   5        $��viewRoboDrift��5   q   %
   AllowConditionalFormattingMenu
 . &   DevExpress.Xpf.Grid.GridViewBase   ShowGroupPanel .     	AutoWidth .  &   DevExpress.Xpf.Grid.DataViewBase   NavigationStyle$	 Row=�5   "      FormatConditions 5      3  -DevExpress.Xpf.Grid.ColorScaleFormatCondition  5      -  'DevExpress.Xpf.Grid.FormatConditionBase   
Expression$ [Int]��68      PredefinedFormatName$ RedWhiteBlueColorScale��6K   5"      5'      &	   DevExpress.Xpf.Core.SimpleButton	  5(   
   -   5        $��Print��5(      $
��Left=�6*   $��
820,0,0,62q�6F   $��80��6Z   $��20��6e   $	��Top=�6�   %
  DevExpress.Xpf.Editors.TextEdit
  5)   
   $
��Left=�6   $��0,0,0,0q�62   $��75��6C   )  #DevExpress.Xpf.Editors.TextEditBase   Text$ 	From Date��6N   $��Calibri)�6_   $��20��6t   $	��Top=�6�   %  DevExpress.Xpf.Editors.DateEdit  5*   
   -   5          Name$ start��5+   U   $
��Left=�6   $��75,0,0,0q�6   $	��Top=�61   $	��150��6I   $��Calibri)�6d   $��14(�6y   $��20��6�   %  DevExpress.Xpf.Editors.BaseEdit   	EditValue 5*      �� *Parameters.StartDate+ �� Mode$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�5+   �   
  5,   
   $
��Left=�6   $��	225,0,0,0q�62   $��75��6E   $ To Date��6P   $��Calibri)�6_   $��20��6t   $	��Top=�6�     5-   
   -   5        $	 end��5.   Z   $
��Left=�6   $��300.358,0,0,0q�6   $	��Top=�66   $	��150��6N   $��Calibri)�6g   $��14(�6|   $��20��6�   $��1��6�    5-      �� *Parameters.EndDate+$ TwoWay=�$ PropertyChanged=�5.   �   )  #DevExpress.Xpf.Editors.ComboBoxEdit  5/   
   -   5          Name$ cmboFollower��5/   *  $
��Left=�6w   $��	460,0,0,0q�6�   $	��Top=�6�   $	��150��6�   $��Calibri Black)�6�   $��14(�6�   $��20��6�    6   �� *Parameters.Follower+$ TwoWay=�$ PropertyChanged=�   Items. 51      -  'DevExpress.Xpf.Editors.ComboBoxEditItem  $��Account Widget��6#     52      $��LongView��6#     53      $
��Self��6#   54      �� 55   
   -   5         ��Name$ txtAccount1��57   (   $
��Left=�6   $��Calibri)�6�   $��14(�6�   $	��200��6�   $��	615,0,0,0q�6�   $��20��6�   $	��Top=�6�   ��55      �� *Parameters.AccountName+$ TwoWay=�$ PropertyChanged=�57   �   5;      5<      