   M S B A M L   `   `   `  ����O  Kmscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e0891&clr-namespace:System;assembly=mscorlibSystem  5
      M IGenericGrid.Client, Version=5.1.0.0, Culture=neutral, PublicKeyToken=null7 clr-namespace:GenericGrid.ClientGenericGrid.Client 5      5   /GenericGrid.Client.View.GenericGridViewerVisual   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35a ]DevExpress.Xpf.Core.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aW SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      ?dxe5http://schemas.devexpress.com/winfx/2008/xaml/editors  5      c _System.Windows.Interactivity, Version=4.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35Bi:http://schemas.microsoft.com/expression/2010/interactivity  5      ;dx2http://schemas.devexpress.com/winfx/2008/xaml/core  5      f bDevExpress.Xpf.Grid.v17.2.Core, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aa	 ]DevExpress.Xpf.Grid.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a>dxg2http://schemas.devexpress.com/winfx/2008/xaml/grid  	 5	      2sys&clr-namespace:System;assembly=mscorlib  	 5
      .local clr-namespace:GenericGrid.Client  	 5      ]
 YDevExpress.Mvvm.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aAdxmvvm2http://schemas.devexpress.com/winfx/2008/xaml/mvvm 
  5      -   5        $
��auto��5      $
��auto��6-     � 	Resources  5      * 	 $DevExpress.Xpf.Grid.GridColumnHeader �� 
TargetType �� Property �� Value   maxHeaderHeight��%|   '        &	  J     �� 5   
   "  6   .�5      ��  � ��
 ��·�6+   5      X�5   
   40Q�5      5       .��5!      � $��Stretch=�6   $
��auto��6'   
�������$
��Auto��6G   $��Stretch=�6U     5"   
     renameColumnHeaderTemplate%  DevExpress.Xpf.Editors.TextEdit%  DevExpress.Xpf.Editors.BaseEdit   	EditValue �� Path �� RelativeSource �� Mode �� AncestorType	 �� 	Converter,  &GenericGrid.Client.VisibilityConverter
 �� Mode �� TextAlignment �� ElementName3  -GenericGrid.Client.ReverseVisibilityConverter  
wrapHeader��%�  &	       7   &	 +    7   �� 5$      .R�5%      � .+�5&        $��textEdit��5.      -   5        
���   � 5'      �� $ DataContext.Header� �� $ FindAncestor=�$ dxg:HeaderContentControlL�y�5*      �� $@ :DataContext.(local:ColumnBehavior.IsRenameEditorActivated)� �� $ FindAncestor=�$ dxg:HeaderContentControlL�	   $
 TwoWay=�5/      �� 50      $��Center=�51      8��  $
��Wrap=�54   F   $ Center=�6Z   ��52      �� y�53      �� $ 
Visibility�$ textEdit��	   54   Z   57      58      �� 59      .R�5:      �� 8��  $
��Wrap=�6Z   $ Center=�6n   ��6   �� 6n   5;      5<       � RowDefinitions 5>   
   �� 5?      $��0 �6   �� 5@      $��* �6   .+�5C   
   �� -   5         ��Name$ 	lblborder��5D      $��1��5C      $	��top=�6$   $��7��6=   
���   �$
��Bold"�5D      $��Center=�6)   $��Stretch=�6M   �� 5F   
   -   5        $��	lblheader��5F     $��1��6m   $��Center=�6z   $	��Top=�6�   $��0,10,0,0q�6�   $��Calibri Black)�6�   $��18(�6�   ���	#FF0072C6$
��auto��6  $��27��6   ��6   �� $ Parameters.Report�$
 TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�6   % 	 DevExpress.Xpf.Grid.GridControl  5K   
   -   5          Name$ 	_dataGrid��5K      4  .DevExpress.Xpf.Core.Serialization.DXSerializer   StoreLayoutMode$	 All=�6.   $��1��6U   )  #DevExpress.Xpf.Grid.DataControlBase   AutoGenerateColumns$ AddNew=�6b      AutoPopulateColumns . #   EnableSmartColumnsGeneration . $��0,60,0,0q�5M      9	  3DevExpress.Xpf.Grid.DataControlSerializationOptions 	  AddNewColumns .  	  RemoveOldColumns .     View 5S      #
 	 DevExpress.Xpf.Grid.TableView
  5U      -   5         
 Name$ viewRoboDrift��5V       
  AllowPerPixelScrolling . &   DevExpress.Xpf.Grid.DataViewBase   ShowTotalSummary .  
  AllowChangeBandParent .  
  AllowChangeColumnParent . & 	  DevExpress.Xpf.Grid.GridViewBase   ShowGroupPanel .  % 
  AllowConditionalFormattingMenu .    ColumnHeaderTemplate# [ 5]      5a          Columns  5g      $ 	 DevExpress.Xpf.Grid.GridColumn  5j      $  DevExpress.Xpf.Grid.ColumnBase!   	FieldName$! CustomColumn1��6!   #"   AllowUnboundExpressionEditor" . #   UnboundType] YDevExpress.Data.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a8  2DevExpress.Utils.Design.UnboundColumnTypeConverter$# Decimal 5k   &   $   ReadOnly$ .  5l   %     5m      $! CustomColumn2��6!   " . $# Decimal 5n   &   $ .  5o   %     5p      $! CustomColumn3��6!   " . $# Decimal 5q   &   $ .  5r   %     5s      $! CustomColumn4��6!   " . $# Decimal 5t   &   $ .  5u   %     5v      $! CustomColumn5��6!   " . $# String 5w   &   $ .  5x   %     5y      $! CustomColumn6��6!   " . $# String 5z   &   $ .  5{   %   5      &   DevExpress.Xpf.Core.SimpleButton  5�   
   -   5        $��Print��5�      $
��Left=�6*   $��	86,10,0,0q�6F   $��52��6Y   $��20��6d   $	��Top=�6�   %  DevExpress.Xpf.Editors.DateEdit  5�   
   -   5        %  Name$% 
txtenddate��5�   W   $
��Left=�6   $��
366,41,0,0q�6   $	��Top=�63   $	��150��6K   $��Calibri)�6k   $��14(�6�   $��20��6�    5�      �� *Parameters.EndDate+$
 TwoWay=�$ PropertyChanged=�5�   �     5�   
   -	   5        $% txtstartdate��5�   W   $
��Left=�6   $��
366,13,0,0q�6   $	��Top=�63   $	��150��6K   $��Calibri)�6m   $��14(�6�   $��20��6�    5�      �� *Parameters.StartDate+$
 TwoWay=�$ PropertyChanged=�5�   �   )  #DevExpress.Xpf.Editors.ComboBoxEdit  5�      -
   5        &  Name$& comboBoxEdit1��5�      $
��Left=�5�      $��
105,44,0,0q�5�      ' J� 	AllowDrop' . $	��Top=�5�      $	��178��6   +  %DevExpress.Xpf.Editors.LookUpEditBase(   IncrementalFiltering$
( TrueX�5�      )   ImmediatePopup) . *   AutoComplete* .  +   FilterCondition$+ ContainsX�5�      ,   ValidateOnTextInput, .  $-   IsSynchronizedWithCurrentItem- . '  !DevExpress.Xpf.Editors.ButtonEdit.   IsTextEditable$
. TrueX�5�      *  $DevExpress.Xpf.Editors.PopupBaseEdit/   IsPopupOpen/ .  5�      �� *Parameters.AccountName+$
 TwoWay=�$ PropertyChanged=�2  ,DevExpress.Mvvm.UI.Interactivity.Interaction0   Triggers0 5�      '  !DevExpress.Mvvm.UI.EventToCommand  5�      �  �DevExpress.Mvvm.UI.Interactivity.EventTriggerBase`1[[System.Windows.DependencyObject, WindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]1   	EventName$1 SelectedIndexChanged��6(   2   PassEventArgsToCommand$
2 TrueX�6y   +  %DevExpress.Mvvm.UI.EventToCommandBase3   Command3 6I   �� *SelectedIndexChangedCommand+6y   4   Items.4 5�      -  'DevExpress.Xpf.Editors.ComboBoxEditItem  $
��WM01��6#   5�      �� 5�   
   -   5        5 ��Name$5 cmboDesk��5�   
   $
��Left=�6   $��
105,72,0,0q�67   $	��top=�6K   $	��178��5�   
   $��Calibri Black)�6   $��14(�61   $��20��6?   6 �� Text6 5�      �� *Parameters.DeskName+$
 TwoWay=�$ PropertyChanged=�5�   ?   �� 5�   
   $��Desk:��6   $
��Left=�6    $��	19,69,0,0q�6;   $	��Top=�6N   $��65��6f   $��23��6q   $
��Bold"�6}   �� 5�   
   $��Account:��6   $
��Left=�6#   $��	19,41,0,0q�6>   $	��Top=�6Q   $��65��6i   $��23��6t   $
��Bold"�6�   �� 5�      $��	Security:��6   $
��Left=�6%   $��
19,100,0,0q�6@   $	��Top=�6T   $��65��6l   $��23��6w   $
��Bold"�6�     5�   
   -   5        $& SecurityComboBoxEdit��5�      $
��Left=�5�      $��105,100,0,0q�5�      ' . $	��Top=�5�      $	��178��6   $
( TrueX�5�      ) . * .  $+ ContainsX�5�      , .  - . $
. TrueX�5�      / .  5�      �� *Parameters.SecurityName+$
 TwoWay=�$ PropertyChanged=�0 5�        5�      $1 SelectedIndexChanged��6(   $
2 TrueX�6y   3 6I   �� *SelectedIndexChangedCommand+6y   .4 5�        $��IBM.US��6#   5�      �� 5�   
   $��Report:��6   $
��Left=�6"   $��
296,96,0,0q�6=   $	��Top=�6Q   $��65��6i   $��23��6t   $
��Bold"�6�   �� 5�   
   -   5        $5 
cmboReport��5�   
   $
��Left=�6   $��
366,99,0,0q�69   $	��top=�6M   $	��188��5�   
   $��Calibri Black)�6   $��14(�61   $��20��6?   6 5�      �� *Parameters.Report+$
 TwoWay=�$ PropertyChanged=�5�   ?   �� 5�   
   $��To Date:                ��6   $
��Left=�5�      $��
296,38,0,0q�6-   $	��Top=�6A   $��65��6Y   $��23��6d   $
��Bold"�6p   �� 5�   
   $��
From Date:��6   $
��Left=�6%   $��
296,10,0,0q�6@   $	��Top=�6T   $��81��6l   $��23��6w   $
��Bold"�6�   �� 5�   
   $��	Block Id:��6   $
��Left=�6$   $��
296,69,0,0q�6?   $	��Top=�6S   $��65��6k   $��23��6v   $
��Bold"�6�   �� 5�   
   -   5        7 ��Name$7 BlockID��5�   (   $
��Left=�6   $��Calibri)�6=   $��14(�6R   $	��150��6`   $��
366,72,0,0q�6m   $��20��6�   $	��Top=�6�   ��5�      �� *Parameters.BlockID+$
 TwoWay=�$ PropertyChanged=�5�   �     5�   
   -   5        $��Update��5�      $
��Left=�6+   $��	10,10,0,0q�6G   $��65��6Z   $��20��6e   $	��Top=�6�     5�   
   -   5        $
��Save��5�      $
��Left=�6)   $��
151,10,0,0q�6E   $��52��6Y   $��20��6d   $	��Top=�6�   5�      5�      