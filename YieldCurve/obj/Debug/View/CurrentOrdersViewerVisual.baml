   M S B A M L   `   `   `  ����O  Kmscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e0891&clr-namespace:System;assembly=mscorlibSystem  5
      O KCurrentOrders.Client, Version=5.1.0.0, Culture=neutral, PublicKeyToken=null;"clr-namespace:CurrentOrders.ClientCurrentOrders.Client 5      9   3CurrentOrders.Client.View.CurrentOrdersViewerVisual   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35a ]DevExpress.Xpf.Core.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aW SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      ?dxe5http://schemas.devexpress.com/winfx/2008/xaml/editors  5      c _System.Windows.Interactivity, Version=4.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35Bi:http://schemas.microsoft.com/expression/2010/interactivity  5      ;dx2http://schemas.devexpress.com/winfx/2008/xaml/core  5      f bDevExpress.Xpf.Grid.v17.2.Core, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aa	 ]DevExpress.Xpf.Grid.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a>dxg2http://schemas.devexpress.com/winfx/2008/xaml/grid  	 5	      2sys&clr-namespace:System;assembly=mscorlib  	 5
      0local"clr-namespace:CurrentOrders.Client  	 5      ]
 YDevExpress.Mvvm.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aAdxmvvm2http://schemas.devexpress.com/winfx/2008/xaml/mvvm 
  5      -   5        $
��auto��5      $
��auto��6-     � 	Resources  5      * 	 $DevExpress.Xpf.Grid.GridColumnHeader �� 
TargetType �� Property �� Value   maxHeaderHeight  
wrapHeader �� TextAlignment��%�   '        &	  J     &	 h     7   �� 5   
   "  6   .�5      ��  � ��
 ��·�6+   5      X�5   
   40Q�5      �� 5   
   .R�5      �� 8��  $
��Wrap=�6V   $ Center=�6j   ��6   �� 6j   5      5       .��5!      � $��Stretch=�6   $
��auto��6'   
�������$
��Auto��6G   $��Stretch=�6U     5"   
     renameColumnHeaderTemplate%  DevExpress.Xpf.Editors.TextEdit%  DevExpress.Xpf.Editors.BaseEdit   	EditValue �� Path �� RelativeSource �� Mode	 �� AncestorType
 �� 	Converter.  (CurrentOrders.Client.VisibilityConverter �� Mode �� ElementName5  /CurrentOrders.Client.ReverseVisibilityConverter��%�  &	       7   &	 +    7   �� 5$      .R�5%      � .+�5&        $��textEdit��5.      -   5        
���   � 5'      �� $ DataContext.Header� �� $ FindAncestor=�$	 dxg:HeaderContentControlL�y�5*      �� $@ :DataContext.(local:ColumnBehavior.IsRenameEditorActivated)� �� $ FindAncestor=�$	 dxg:HeaderContentControlL�
   $ TwoWay=�5/      �� 50      $��Center=�51      8��  $
��Wrap=�54   F   $ Center=�6Z   ��52      �� y�53      �� $ 
Visibility�$ textEdit��
   54   Z   57      58      �� 59      .R�5:      �� 8��  $
��Wrap=�6Z   $ Center=�6n   ��6   �� 6n   5;      5<       � RowDefinitions 5>   
   �� 5?      $��30 �6   �� 5@      $��* �6   .+�5C   
   �� -   5         ��Name$ 	lblborder��5D      $��1��5C      $	��top=�6$   $��7��6=   
���   �$
��Bold"�5D      $��Center=�6)   $��Stretch=�6M   �� 5H   
   -   5        $��3,8,0,0q�5H      $��20��6#   $��5��60   $
��Left=�6:   $	��Top=�6U   
���/���$��1��6�   6�   �� 5I   
   -   5        $��10,8,0,0q�5I      $��20��6$   $��5��61   $
��Left=�6;   $	��Top=�6V   
������$��1��6�   6�   )  #DevExpress.Xpf.Editors.ComboBoxEdit  5K      -   5          Name$ comboBoxEdit1��5N      $
��Left=�5L      $��0��5M      $��10,5,0,0q�5N       J� 	AllowDrop . $	��Top=�5P      $	��178��6   +  %DevExpress.Xpf.Editors.LookUpEditBase   IncrementalFiltering$
 TrueX�5R         ImmediatePopup .    AutoComplete .     FilterCondition$ ContainsX�5U         ValidateOnTextInput .  $   IsSynchronizedWithCurrentItem . '  !DevExpress.Xpf.Editors.ButtonEdit   IsTextEditable$
 TrueX�5X      *	  $DevExpress.Xpf.Editors.PopupBaseEdit 	  IsPopupOpen .  5K      �� *Parameters.AccountName+$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�2
  ,DevExpress.Mvvm.UI.Interactivity.Interaction 
  Triggers 5Z      '  !DevExpress.Mvvm.UI.EventToCommand  5[      �  �DevExpress.Mvvm.UI.Interactivity.EventTriggerBase`1[[System.Windows.DependencyObject, WindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]   	EventName$ SelectedIndexChanged��6(      PassEventArgsToCommand$
 TrueX�6y   +  %DevExpress.Mvvm.UI.EventToCommandBase   Command 6I   �� *SelectedIndexChangedCommand+6y      Items. 5]      -  'DevExpress.Xpf.Editors.ComboBoxEditItem  $
��WM01��6#   5^      �� 5`   
   -   5        $��Generate Proposal��5`      $��0��6-   $
��Left=�6:   $��	237,5,0,0q�6U   $	��Top=�6h   $	��194��6�   $��25��6�   $��Calibri)�6�   $��14(�6�   $
��Bold"�6�   
��� � �6�   �� 5a   
   -   5        $��btnSubmitOrders��5a   �   $��Submit Orders��6   $��0��6)   $
��Left=�66   $��	453,5,0,0q�6Q   $	��Top=�6d   $	��194��6|   $��25��6�   $��Calibri)�6�   $��14(�6�   $
��Bold"�6�   
��� � �6�   % 	 DevExpress.Xpf.Grid.GridControl  5e   
   -	   5          Name$ 	_dataGrid��5e   `   )  #DevExpress.Xpf.Grid.DataControlBase    AutoGenerateColumns$  AddNew=�6   #!   EnableSmartColumnsGeneration! .  $��SemiBold"�5f      "   AllowLiveDataShaping$
" TrueX�65   $��0,35,0,0q�6R   $��1��6d   $��Stretch=�5g      !#   HorizontalContentAlignment$# Stretch=�5h      $��12(�5i      $��Calibri)�6)   $   SelectionMode$	$ Row=�5k      4  .DevExpress.Xpf.Core.Serialization.DXSerializer%   StoreLayoutMode$	% All=�5l      9  3DevExpress.Xpf.Grid.DataControlSerializationOptions&   AddNewColumns& . '   RemoveOldColumns' .  (   ItemsSource( 5j      �� *MyDataTable.DefaultView+$ OneWay=�$ Default=�)   View) 5s      # 	 DevExpress.Xpf.Grid.TableView  5u      -
   5        *  Name$* _viewDataGrid��5v      +   AllowPerPixelScrolling+ . &   DevExpress.Xpf.Grid.DataViewBase,   ShowTotalSummary, . -   AllowChangeBandParent- . .   AllowChangeColumnParent. . & 	  DevExpress.Xpf.Grid.GridViewBase/   ShowGroupPanel/ .  %0   AllowConditionalFormattingMenu0 . 1   ColumnHeaderTemplate#1 [ 5}      5�      2   Columns2 5�      $ 	 DevExpress.Xpf.Grid.GridColumn  5�      $  DevExpress.Xpf.Grid.ColumnBase3   	FieldName$3 CustomColumn1��6!   #4   AllowUnboundExpressionEditor4 . 5   UnboundType] YDevExpress.Data.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a8  2DevExpress.Utils.Design.UnboundColumnTypeConverter$5 Decimal 5�   &   6   ReadOnly6 .  5�   %     5�      $3 CustomColumn2��6!   4 . $5 Decimal 5�   &   6 .  5�   %     5�      $3 CustomColumn3��6!   4 . $5 Decimal 5�   &   6 .  5�   %     5�      $3 CustomColumn4��6!   4 . $5 Decimal 5�   &   6 .  5�   %     5�      $3 CustomColumn5��6!   4 . $5 String 5�   &   6 .  5�   %     5�      $3 CustomColumn6��6!   4 . $5 String 5�   &   6 .  5�   %   7 � ContextMenu7 5�      �� 5�      8 �� PlacementTarget8 6   �� $ dgModels��  5�        SimpleSysResources��%R   &	       �� 5�      " m�6;   .�5�      ��  � ��$ 16(�6;   5�      5�      .@�5�      m� -   5        $��Open Account��5�      #��[ 66   $��Calibri)�6{   $��12(�6�   m� 5�      -   5        $��Approve��5�      #��[ 61   $��Calibri)�6}   $��12(�6�   m� 5�      -   5        $
��Deny��5�      #��[ 6.   $��Calibri)�6x   $��12(�6�   m� 5�      -   5        $��Delete��5�      #��[ 60   $��Calibri)�6z   $��12(�6�   m� 5�      -   5        $��Pre Trade Analytics��5�      #��[ 6=   $��Calibri)�6�   $��12(�6�   5�      5�      5�      5�      