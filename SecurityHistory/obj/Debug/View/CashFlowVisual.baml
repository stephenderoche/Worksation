   M S B A M L   `   `   `  ����O  Kmscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e0891&clr-namespace:System;assembly=mscorlibSystem  5
      J FCashFlow.Client, Version=5.1.0.0, Culture=neutral, PublicKeyToken=null1clr-namespace:CashFlow.ClientCashFlow.Client 5      )   #CashFlow.Client.View.CashFlowVisual   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35a ]DevExpress.Xpf.Core.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aW SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      ?dxe5http://schemas.devexpress.com/winfx/2008/xaml/editors  5      c _System.Windows.Interactivity, Version=4.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35Bi:http://schemas.microsoft.com/expression/2010/interactivity  5      ;dx2http://schemas.devexpress.com/winfx/2008/xaml/core  5      f bDevExpress.Xpf.Grid.v17.2.Core, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aa	 ]DevExpress.Xpf.Grid.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a>dxg2http://schemas.devexpress.com/winfx/2008/xaml/grid  	 5	      2sys&clr-namespace:System;assembly=mscorlib  	 5
      +localclr-namespace:CashFlow.Client  	 5      ]
 YDevExpress.Mvvm.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aAdxmvvm2http://schemas.devexpress.com/winfx/2008/xaml/mvvm 
  5      -   5        $
��auto��5      $
��auto��6-     � 	Resources  5      * 	 $DevExpress.Xpf.Grid.GridColumnHeader �� 
TargetType �� Property �� Value   maxHeaderHeight��%|   '        &	  J     �� 5   
   "  6   .�5      ��  � ��
 ��·�6+   5      X�5   
   40Q�5      5!      .��5"      � $��Stretch=�6   $
��auto��6'   
�������$
��Auto��6G   $��Stretch=�6U     5#   
     renameColumnHeaderTemplate%  DevExpress.Xpf.Editors.TextEdit%  DevExpress.Xpf.Editors.BaseEdit   	EditValue �� Path �� RelativeSource �� Mode �� AncestorType	 �� 	Converter)  #CashFlow.Client.VisibilityConverter
 �� Mode �� TextAlignment �� ElementName0  *CashFlow.Client.ReverseVisibilityConverter � LayoutTransform �� Angle  
wrapHeader��%�  &	       7   &	 U    7   �� 5%      .R�5&      � .+�5'        $��textEdit��5/      -   5        
���   � 5(      �� $ DataContext.Header� �� $ FindAncestor=�$ dxg:HeaderContentControlL�y�5+      �� $@ :DataContext.(local:ColumnBehavior.IsRenameEditorActivated)� �� $ FindAncestor=�$ dxg:HeaderContentControlL�	   $
 TwoWay=�50      �� 52      $��Center=�53      8��  $��NoWrap=�56   F   $ Center=�6\   ��54      �� y�55      �� $ 
Visibility�$ textEdit��	    57      �� 58      $ 0Q�6.   5:      5<      5=      �� 5>      .R�5?      �� 8��  $
��Wrap=�6Z   $ Center=�6n   ��6   �� 6n   5@      5A       � RowDefinitions 5C   
   �� 5D      $��70 �6   �� 5E      $��* �6   .+�5I   
   �� -   5        $��	lblheader��5I     $��1��6m   $
��Left=�6z   $	��Top=�6�   $��
378,10,0,0q�6�   $��Calibri Black)�6�   $��18(�6�   ���	#FF0072C6$
��auto��6  $��27��6   ��6   �� $ Parameters.Report�$
 TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�6   % 	 DevExpress.Xpf.Grid.GridControl  5N   
   -   5          Name$ 	_dataGrid��5N      4  .DevExpress.Xpf.Core.Serialization.DXSerializer   StoreLayoutMode$	 All=�6.   $��1��6U   )  #DevExpress.Xpf.Grid.DataControlBase   AutoGenerateColumns$ AddNew=�6b      AutoPopulateColumns . #   EnableSmartColumnsGeneration . $��0,0,0,0q�5P      9	  3DevExpress.Xpf.Grid.DataControlSerializationOptions 	  AddNewColumns .  	  RemoveOldColumns .     ItemsSource 5T      �� *MyDataTable.DefaultView+$
 OneWay=�$ Default=�   View 5X      #
 	 DevExpress.Xpf.Grid.TableView
  5Z      -   5         
 Name$ viewRoboDrift��5[       
  AllowPerPixelScrolling . &   DevExpress.Xpf.Grid.DataViewBase   ShowTotalSummary .  
  AllowChangeBandParent .  
  AllowChangeColumnParent . & 	  DevExpress.Xpf.Grid.GridViewBase   ShowGroupPanel .  %  
  AllowConditionalFormattingMenu  . !   ColumnHeaderTemplate#! [ 5b      "   IsGroupFooterMenuEnabled" . # 
  GroupSummaryDisplayMode$# AlignByColumns=�5d      $   ShowFixedTotalSummary$ . %   GroupValueTemplate% 5l      �� 5m      .R�5n      �� & �� Orientation$& 
Horizontal=�6)   .+�5o   "   �� ��6,   �� *Value+' �� StringFormat$
'  {0}���� 5p   "   ��6,   �� *RowData.Row.GroupDescription+$' Dexcription: {0}��5q      5r      5u      (   Columns( 5{      $ 	 DevExpress.Xpf.Grid.GridColumn  5}      $  DevExpress.Xpf.Grid.BaseColumn)   Header)  #DevExpress.Xpf.Core.ObjectConverter$) 	cash_flow 6!   $  DevExpress.Xpf.Grid.ColumnBase*   	FieldName$* 	cash_flow��6c   +   Binding+ 64   �� *	cash_flow+$' n2��,   EditSettings, 5~      6  0DevExpress.Xpf.Editors.Settings.TextEditSettings  5      6  0DevExpress.Xpf.Editors.Settings.BaseEditSettings-   DisplayFormat$- N2��6/   5�        5�      $) 	Principal 6!   $* 	Principal��6c   + 64   �� *	Principal+$' n2��, 5�        5�      $- N2��6/   5�        5�      $) Interest 6!   $* Interest��6a   + 63   �� *
Interest+$' n2��, 5�        5�      $- N2��63   5�        5�      $) Cash Sum 6!   $
* cash��6M   .   
GroupIndex$. 0��6_   + 63   �� *cash+5�        5�      $* CustomColumn1��6!   #/   AllowUnboundExpressionEditor/ . 0   UnboundType] YDevExpress.Data.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a8  2DevExpress.Utils.Design.UnboundColumnTypeConverter$0 Decimal 5�   &   1   ReadOnly1 .  5�   %     5�      $* CustomColumn2��6!   / . $0 Decimal 5�   &   1 .  5�   %     5�      $* CustomColumn3��6!   / . $0 Decimal 5�   &   1 .  5�   %     5�      $* CustomColumn4��6!   / . $0 Decimal 5�   &   1 .  5�   %     5�      $* CustomColumn5��6!   / . $0 String 5�   &   1 .  5�   %     5�      $* CustomColumn6��6!   / . $0 String 5�   &   1 .  5�   %   2   TotalSummary2 5�      ) 	 #DevExpress.Xpf.Grid.GridSummaryItem  5�      )  #DevExpress.Xpf.Grid.SummaryItemBase3   DisplayFormat$3 Sum: {0:n2}��6&   4   	FieldName$4 	cash_flow��6B   5   ShowInColumn$5  ��5�   &   6   SummaryType5  /DevExpress.Data.Design.SummaryItemTypeConverter$	6 Sum 66   7   	Alignment$
7 Left=�6H   8   GroupSummary8 5�        5�      $4 	cash_flow��6&   $	6 Sum 6<   $5 	cash_flow��6N   5�      &   DevExpress.Xpf.Core.SimpleButton  5�   
   -   5        $��Print��5�      $
��Left=�6*   $��
542,38,0,0q�6F   $��62��6Z   $��20��6e   $	��Top=�6�   %  DevExpress.Xpf.Editors.DateEdit  5�   
   -   5        9  Name$9 
txtenddate��5�   W   $
��Left=�6   $��
366,41,0,0q�6   $	��Top=�63   $	��150��6K   $��Calibri)�6k   $��14(�6�   $��20��6�    5�      �� *Parameters.EndDate+$
 TwoWay=�$ PropertyChanged=�5�   �     5�   
   -   5        $9 txtstartdate��5�   W   $
��Left=�6   $��
366,13,0,0q�6   $	��Top=�63   $	��150��6K   $��Calibri)�6m   $��14(�6�   $��20��6�    5�      �� *Parameters.StartDate+$
 TwoWay=�$ PropertyChanged=�5�   �   )  #DevExpress.Xpf.Editors.ComboBoxEdit  5�   
   -	   5        :  Name$: comboBoxEdit1��5�      $
��Left=�5�      $��
105,13,0,0q�5�      ; J� 	AllowDrop; . $	��Top=�5�      $	��178��6   +  %DevExpress.Xpf.Editors.LookUpEditBase<   IncrementalFiltering$
< TrueX�5�      =   ImmediatePopup= . >   AutoComplete> .  ?   FilterCondition$? ContainsX�5�      @   ValidateOnTextInput@ .  $A   IsSynchronizedWithCurrentItemA . '  !DevExpress.Xpf.Editors.ButtonEditB   IsTextEditable$
B TrueX�5�      *  $DevExpress.Xpf.Editors.PopupBaseEditC   IsPopupOpenC .  5�      �� *Parameters.AccountName+$
 TwoWay=�$ PropertyChanged=�2  ,DevExpress.Mvvm.UI.Interactivity.InteractionD   TriggersD 5�      '  !DevExpress.Mvvm.UI.EventToCommand  5�      �  �DevExpress.Mvvm.UI.Interactivity.EventTriggerBase`1[[System.Windows.DependencyObject, WindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]E   	EventName$E SelectedIndexChanged��6(   F   PassEventArgsToCommand$
F TrueX�6y   +   %DevExpress.Mvvm.UI.EventToCommandBaseG    CommandG 6I   �� *SelectedIndexChangedCommand+6y   H   Items.H 5�      -!  'DevExpress.Xpf.Editors.ComboBoxEditItem!  $
��WM01��6#   5�      �� 5�   
   $��Account:��6   $
��Left=�6#   $��	19,14,0,0q�6>   $	��Top=�6Q   $��65��6i   $��23��6t   $
��Bold"�6�   �� 5�   
   $��	Security:��6   $
��Left=�6$   $��	19,42,0,0q�6?   $	��Top=�6R   $��65��6j   $��23��6u   $
��Bold"�6�     5�   
   -
   5        $: SecurityComboBoxEdit��5�      $
��Left=�5�      $��
105,42,0,0q�5�      ; . $	��Top=�5�      $	��178��6   $
< TrueX�5�      = . > .  $? ContainsX�5�      @ .  A . $
B TrueX�5�      C .  5�      �� *Parameters.SecurityName+$
 TwoWay=�$ PropertyChanged=�D 5�        5�      $E SelectedIndexChanged��6(   $
F TrueX�6y   G 6I   �� *SelectedIndexChangedCommand+6y   .H 5�      !  $��IBM.US��6#   5�      �� 5�   
   $��To Date:                ��6   $
��Left=�5�      $��
296,38,0,0q�6-   $	��Top=�6A   $��65��6Y   $��23��6d   $
��Bold"�6p   �� 5�   
   $��
From Date:��6   $
��Left=�6%   $��
296,10,0,0q�6@   $	��Top=�6T   $��81��6l   $��23��6w   $
��Bold"�6�     5�   
   -   5        $��Update��5�      $
��Left=�6+   $��
542,10,0,0q�6G   $��62��6[   $��20��6f   $	��Top=�6�   5�      5�      