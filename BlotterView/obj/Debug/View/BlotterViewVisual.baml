   M S B A M L   `   `   `  ����O  Kmscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e0891&clr-namespace:System;assembly=mscorlibSystem  5      M IBlotterView.Client, Version=5.1.0.0, Culture=neutral, PublicKeyToken=null7 clr-namespace:BlotterView.ClientBlotterView.Client 5      /   )BlotterView.Client.View.BlotterViewVisual   5      a ]DevExpress.Xpf.Core.v18.1, Version=18.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      ?dxe5http://schemas.devexpress.com/winfx/2008/xaml/editors  5      c _System.Windows.Interactivity, Version=4.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35Bi:http://schemas.microsoft.com/expression/2010/interactivity  5      ;dx2http://schemas.devexpress.com/winfx/2008/xaml/core  5      c _DevExpress.Xpf.Charts.v18.1, Version=18.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a>dxc4http://schemas.devexpress.com/winfx/2008/xaml/charts  5	      f	 bDevExpress.Xpf.Grid.v18.1.Core, Version=18.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aa
 ]DevExpress.Xpf.Grid.v18.1, Version=18.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a>dxg2http://schemas.devexpress.com/winfx/2008/xaml/grid 	 
 5
      2sys&clr-namespace:System;assembly=mscorlib 	 
 5      Gdxgt<http://schemas.devexpress.com/winfx/2008/xaml/grid/themekeys 
 5      ,local clr-namespace:BlotterView.Client 
 5      ] YDevExpress.Mvvm.v18.1, Version=18.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aAdxmvvm2http://schemas.devexpress.com/winfx/2008/xaml/mvvm   5      -   5        
�������$
��auto��5      $
��auto��6-     � 	Resources  5       �� 
TargetType' 
 !DevExpress.Xpf.Grid.DataPresenter; 
 5DevExpress.Xpf.Grid.Themes.TableViewThemeKeyExtension�  �DevExpress.Xpf.Utils.Themes.ThemeKeyExtensionBase`1[[DevExpress.Xpf.Grid.Themes.TableViewThemeKeys, DevExpress.Xpf.Grid.v18.1, Version=18.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a]]   IsThemeIndependent�  �DevExpress.Xpf.Utils.Themes.ThemeKeyExtensionInternalBase`1[[DevExpress.Xpf.Grid.Themes.TableViewThemeKeys, DevExpress.Xpf.Grid.v18.1, Version=18.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a]]   ResourceKey   UnfocusedRowBrush �� Color* 
 $DevExpress.Xpf.Grid.GridColumnHeader �� 
TargetType �� Property �� Value1 
 +DevExpress.Xpf.Grid.BackgroundBorderControl+ 
 %DevExpress.Xpf.Grid.BandHeaderControl, 
 &DevExpress.Xpf.Grid.HeaderItemsControl+	 
 %DevExpress.Xpf.Grid.GridSearchControl/
 
 )DevExpress.Xpf.Grid.GroupFooterRowControl. 
 (DevExpress.Xpf.Grid.HeaderContentControl,  &DevExpress.Xpf.Core.CachedItemsControl: 
 4DevExpress.Xpf.Grid.Themes.GroupRowThemeKeyExtension�  �DevExpress.Xpf.Utils.Themes.ThemeKeyExtensionInternalBase`1[[DevExpress.Xpf.Grid.Themes.GroupRowThemeKeys, DevExpress.Xpf.Grid.v18.1, Version=18.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a]]   ResourceKey$ 	 DevExpress.Xpf.Grid.ColumnBase  maxHeaderHeight  
wrapHeader	 �� TextAlignment  SelectedRowStyle
 �� Triggers �� Binding �� Path �� Value& 	  DevExpress.Xpf.Grid.DataViewBase P� Property P� Value��%�  (        5       . $ DataPresenterTemplate=�)&	  W     '  z     '  �     '      '  X    '	  �    '
  �    '  6    (  �    54      $ GroupItemsControlStyle=�)&	 ,    &	 J    7  &	 �    �� 5   
   "  6v   .R�5      �� 
�������._�5      �� 5      5      �� 5   
   $ 	#FF666666��64   �� 5   
   "  6   .�5       ��  � ��
 �����6+   5!      �� 5"   
   "  6   .�5#      ��  � ��
 �����6+   5$      �� 5%   
   "  6   .�5&      ��  � ��
 �����6+   5'      �� 5(   
   "  6   .�5)      ��  � ��
 �����6+   5*      �� 5+   
   " 	 6   .�5,      ��  � ��
 �����6+   5-      �� 5.   
   " 
 6   .�5/      ��  � ��
 �����6+   50      �� 51   
   "  6   .�52      ��  � ��
 �����6+   53      �� 54   
   "  6S   .�55      ��  � }� . 6-   �� 56       �@ HeaderPresenterType$ 
GroupPanel=�6C   �� 57       � ��
 �����6+   58      X�5;   
   50Q�5=      �� 5?   
   .R�5@      �� 8��  $
��Wrap=�6V   $	 Center=�6j   ��6   �� 6j   5A      �� 5D   
   
 5E      �� 5F       6   �� $ 
IsSelected� True6B   .a�5G      ��  � ��
 �����6B   �� 5H       � ��
 �����6?   5I      P� 5J       �@ IsFocusedRow . . �5K      ��  � ��
 ���_�6B   �� 5L       � ��
 �����6?   5M      5O      5R      .��5T      � -   5        $
��root��5T        5V   
     renameColumnHeaderTemplate%  DevExpress.Xpf.Editors.TextEdit%  DevExpress.Xpf.Editors.BaseEdit   	EditValue �� RelativeSource �� Mode �� AncestorType �� 	Converter,  &BlotterView.Client.VisibilityConverter �� Mode �� ElementName3  -BlotterView.Client.ReverseVisibilityConverter � LayoutTransform �� Angle��%�  &	       7  &	 S    7  �� 5W      .R�5X      � .+�5Y        $��textEdit��5a      -   5        
���   � 5Z      �� $ DataContext.Header� �� $ FindAncestor=�$ dxg:HeaderContentControlL�y�5]      �� $@ :DataContext.(local:ColumnBehavior.IsRenameEditorActivated)� �� $ FindAncestor=�$ dxg:HeaderContentControlL�   $ TwoWay=�5b      �� 5d      $��Center=�5e      8��  $
��Wrap=�5h   F   $	 Center=�6Z   ��5f      �� y�5g      �� $ 
Visibility�$ textEdit��    5i      �� 5j      $ 0Q�6.   5l      5n      5o      �� 5p      .R�5q      �� 8��  $
��Wrap=�6Z   $	 Center=�6n   ��6   �� 6n   5r      5s       � ColumnDefinitions 5t   
   �� 5u      $��* �6   6+   �� 5v      $��* �6   6+   �� 5w      $��2* �6   6,   .+�5|   
   �� -   5         ��Name$ 
lblborder4��5}      $
��left=�5|      $��1��63   $��7��6C   
�������$��0��6d   $��3��6q   $
��Bold"�5}   ,   $��Stretch=�6>   $��Stretch=�6a   �� 5   
   -   5        $ 
lblborder5��5�      $��Right=�5      $��1��64   $��7��6D   
�������$��0��6f   $��3��6s   $
��Bold"�5�   ,   $��Stretch=�6>   $��Stretch=�6a   � 5�   
   $��0��6    � RowDefinitions 5�      �� 5�      $��30 �6    6.   �� 5�      $��* �6    6-   .+�5�      �� -   5         ��Name$ cmboDesk��5�      $
��Left=�6%   $	��top=�6A   $	��178��5�      $��Calibri Black)�6   $��14(�6:   $��20��6H   
������� �� Text 5�      �� *Parameters.DeskName+$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�5�   T   % 
 DevExpress.Xpf.Grid.GridControl  5�      -   5          Name$ 	_dataGrid��5�      $��1��65   $��2��6B   ) 	 #DevExpress.Xpf.Grid.DataControlBase    AutoGenerateColumns$  AddNew=�6S   $��0��6p   !   AutoPopulateColumns! . #"   EnableSmartColumnsGeneration" . $��0,0,0,0q�5�      9 	 3DevExpress.Xpf.Grid.DataControlSerializationOptions#   RemoveOldColumns# .  4  .DevExpress.Xpf.Core.Serialization.DXSerializer$   StoreLayoutMode$	$ All=�5�      %   
ShowBorder% .  &   ItemsSource& 5�      �� *MyDataTable.DefaultView+$ OneWay=�$ Default=�'   View' 5�      # 
 DevExpress.Xpf.Grid.TableView  5�      -   5        (  Name$( viewblotterGrid��5�      )   AllowPerPixelScrolling) . *   ShowTotalSummary* . +   AllowChangeBandParent+ . ,   AllowChangeColumnParent, . & 
  DevExpress.Xpf.Grid.GridViewBase-   ShowGroupPanel- .  %.   AllowConditionalFormattingMenu. . /   ColumnHeaderTemplate#/ [ 5�      0   IsGroupFooterMenuEnabled0 . 1   GroupSummaryDisplayMode$1 AlignByColumns=�5�      2   FooterTemplate2 5�      �� 5�      .R�5�   "   �� 
�������5�   #   5�      5�      3   Columns3 5�      4   GroupSummary4 5�      ) 
 #DevExpress.Xpf.Grid.GridSummaryItem  5�      ) 	 #DevExpress.Xpf.Grid.SummaryItemBase5   DisplayFormat$5 Sum: {0:c2}��6&   6   	FieldName$6 balance_value��6B   7   ShowInColumn$7  ��5�      8   SummaryType] YDevExpress.Data.v18.1, Version=18.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a5  /DevExpress.Data.Design.SummaryItemTypeConverter$	8 Sum 6)   9   	Alignment$
9 Left=�6;   5�      5�      � 5�   
   $��1��6    5�      �� 5�      $��* �6    6-   �� 5�      $��* �6    6-   .+�5�      (  "DevExpress.Xpf.Charts.ChartControl  -	   5        :  Name$: 	BrokerBar��5�      ;   AnimationMode$; OnDataChanged=�63   $��7,0,7,0q�6S   $��0��5�      
�������<   
DataSource< 6)   �� *BrokerTable+$ OneWay=�$ Default=�=   CrosshairOptions= 5�      ,  &DevExpress.Xpf.Charts.CrosshairOptions  5�      0   *DevExpress.Xpf.Charts.CrosshairOptionsBase>    ShowValueLine> . ?   ShowValueLabels? . 6<   @   Legend@ 5�      "!  DevExpress.Xpf.Charts.Legend!  5�      $��12(�6   $��1,1,1,1q�6,   
�������A !  VerticalPosition$A BottomOutside=�5�      B !  HorizontalPosition$
B Left=�5�      C !  Orientation$C 
Horizontal=�5�      D !  IndentFromDiagram$D 1q�5�      $��1q�5�      $��5q�5�      E !  TitleE 5�      '"  !DevExpress.Xpf.Charts.LegendTitle"  5�      %#  DevExpress.Xpf.Charts.TitleBaseF #  Content$F Avg.Executions by Broker��6*   $��16(�6N   
����  �$��0q�6n   5�      G   Diagram.G 5�      '$  !DevExpress.Xpf.Charts.XYDiagram2D$  H $  AxisYH 5�      #%  DevExpress.Xpf.Charts.AxisY2D%  5�      $&  DevExpress.Xpf.Charts.AxisBaseI &  GridLinesMinorVisibleI . J &  LabelJ 5�      %'  DevExpress.Xpf.Charts.AxisLabel'  5�      K '  TextPattern$K 	{V:#,##0}��6,   $��12(�6F   "(  DevExpress.Xpf.Charts.Axis2DL (  VisualRangeL 5�      !)  DevExpress.Xpf.Charts.Range)  5�      M )  SideMarginsValue$M 0Q�5�   	   N )  AutoSideMarginsN . 6    *  DevExpress.Xpf.Charts.AxisO *  
WholeRangeO 5�      )  5�      $M 0Q�5�   	   5�      #+  DevExpress.Xpf.Charts.DiagramP +  Series.P 5�      .,  (DevExpress.Xpf.Charts.BarStackedSeries2D,  "-  DevExpress.Xpf.Charts.SeriesQ -  DisplayName$Q Cash %��6)   +.  %DevExpress.Xpf.Charts.BarSeries2DBaseR .  BarWidth$	R 0.5Q�6>   &/   DevExpress.Xpf.Charts.XYSeries2DS /  CrosshairEnabled$
S TrueX�6O   $0  DevExpress.Xpf.Charts.XYSeriesT 0  	ColorEachT . U /  CrosshairLabelPattern$,U &Broker: {A}; Executions Avg;: {V:n2}; ��5�      V -  ArgumentDataMember$
V name��6E   W -  ValueDataMember$W AveragePrice��6_   X -  LegendTextPattern$X #,##0.00��6�   Y -  LegendPointOptionsY 5      (1  "DevExpress.Xpf.Charts.PointOptions1  5     Z 1  Pattern$Z {A} : {V:#,##0.00}��6+   5     5     5       5	     -
   5        $ _dataGridBroker��5	     $	$ All=�68   $��1��6_   $  AddNew=�6m   ! . " . $��7,0,7,0q�5     [   AddNewColumns[ . # .  \   
Background
\ �����& 5     �� *BrokerDateTable.DefaultView+$ OneWay=�$ Default=�' 5       5     -   5        $( 
viewBroker��5     ) . * . + . , . - .  . . #/ [ 5     0 . $1 AlignByColumns=�5      ]   
Background
] �����2 5&     �� 5'     .R�5(  "   �� 
�������5*  #   5+     %^   GroupColumnSummaryItemTemplate^ 5-     �� 5.     .R�5/  "   �� 
�������51  #   52     54     4 58       59     $5 Sum: {0:c2}��6&   $6 balance_value��6B   $7  ��5:     $	8 Sum 6)   $
9 Left=�6;   5>     5@     � 5D  	   $��2��6    5E  
   �� 5F     $��30 �6   6*   �� 5G     $��30 �6   6*   �� 5H     $��* �6   6)   .+�5J     �� $��0��6   _ �� Orientation$_ 
Horizontal=�6&   $��20,0,0,0q�6?   $��Center=�6Q   $��2��6n   
�������.+�5K     	� -   5        ` 	�Name$` chk1d��5K     $��1D��6)   
���   �$��14(�6I   $
��Bold"�6W   $��10,0,0,0q�6�   a d� 	IsCheckeda 6�   �� *Parameters.OneDay+$ TwoWay=�$ PropertyChanged=�6  	� 5L     -   5        $` chk5d��5L     $��5D��6)   
���   �$��14(�6I   $
��Bold"�6W   $��10,0,0,0q�6�   a 6�   �� *Parameters.FiveDay+$ TwoWay=�$ PropertyChanged=�6  	� 5M     -   5        $` chk1M��5M     $��1M��6)   
���   �$��14(�6I   $
��Bold"�6W   $��10,0,0,0q�6�   a 6�   �� *Parameters.OneMonth+$ TwoWay=�$ PropertyChanged=�6  	� 5N     -   5        $` chk3M��5N     $��3M��6)   
���   �$��14(�6I   $
��Bold"�6W   $��10,0,0,0q�6�   a 6�   �� *Parameters.ThreeMonth+$ TwoWay=�$ PropertyChanged=�6  	� 5O     -   5        $` chk6M��5O     $��6M��6)   
���   �$��14(�6I   $
��Bold"�6W   $��10,0,0,0q�6�   a 6�   �� *Parameters.SixMonth+$ TwoWay=�$ PropertyChanged=�6  	� 5P     -   5        $` chkYTD��5P     $	��YTD��6*   
���   �$��14(�6K   $
��Bold"�6Y   $��10,0,0,0q�6�   a 6�   �� *Parameters.YTD+$ TwoWay=�$ PropertyChanged=�6  	� 5Q     -   5        $` chk1y��5Q     $��1Y��6)   
���   �$��14(�6I   $
��Bold"�6W   $��10,0,0,0q�6�   a 6�   �� *Parameters.OneYear+$ TwoWay=�$ PropertyChanged=�6  	� 5R     -   5        $` chk2y��5R     $��2Y��6)   
���   �$��14(�6I   $
��Bold"�6W   $��10,0,0,0q�6�   a 6�   �� *Parameters.TwoYear+$ TwoWay=�$ PropertyChanged=�6  	� 5S     -   5        $` chk5y��5S     $��5Y��6)   
���   �$��14(�6I   $
��Bold"�6W   $��10,0,0,0q�6  a 6�   �� *Parameters.FiveYear+$ TwoWay=�$ PropertyChanged=�6  )2  #DevExpress.Xpf.Editors.ComboBoxEdit2  5T     -   5        b 2 Name$b SecurityComboBoxEdit��5W  !   $��10,0,0,0q�5T     $
��Left=�5U     c J� 	AllowDropc . $	��Top=�5Y     $	��178��67   +3  %DevExpress.Xpf.Editors.LookUpEditBased 3  IncrementalFiltering$
d TrueX�5[     e 3  ImmediatePopupe . f 3  AutoCompletef .  g 3  FilterCondition$g ContainsX�5^     h   ValidateOnTextInputh .  $i 3  IsSynchronizedWithCurrentItemi . '4  !DevExpress.Xpf.Editors.ButtonEditj 4  IsTextEditable$
j TrueX�5a     *5  $DevExpress.Xpf.Editors.PopupBaseEditk 5  IsPopupOpenk .  5T     �� *Parameters.SecurityName+$ TwoWay=�$ PropertyChanged=�26  ,DevExpress.Mvvm.UI.Interactivity.Interactionl 6  Triggersl 5c     '7  !DevExpress.Mvvm.UI.EventToCommand7  5d     �8  �DevExpress.Mvvm.UI.Interactivity.EventTriggerBase`1[[System.Windows.DependencyObject, WindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]m 8  	EventName$m SelectedIndexChanged��6,   n 7  PassEventArgsToCommand$
n TrueX�6}   +9  %DevExpress.Mvvm.UI.EventToCommandBaseo 9  Commando 6M   �� *SelectedIndexChangedCommand+6}   p 2  Items.p 5f     -:  'DevExpress.Xpf.Editors.ComboBoxEditItem:  $��IBM.US��6'   5g     �� 5h     -   5        $��3,0,0,0q�5h     $��20��6'   $��5��64   $
��Left=�6>   $	��Top=�6Y   
���/���6�   �� 5q     -   5        q ��Name$q imageVisibilty��5q     $��Center=�6/   $��	Dividends��6L   $��20,0,0,0q�6`   6t   5r     �� 5s  
   $��1��6   $_ 
Horizontal=�6"   $��20,0,0,0q�6;   $��Center=�6M   $��2��6j   
�������.+�5u     �� $��Center=�6f   $��10,0,0,0q�6�   $��Oblique$�6�   $
��Bold"�6�   
���   �$��14(�6�   ��6   �� *NewProperty+$ OneWay=�$ PropertyChanged=�6�   5w       5x  
   -   5        $��chart��5z     $��2��5y     $��2��5{     r J� IsManipulationEnabledr . 
�������$��0,0,0,0q�5     < 5}     �� *
DataSeries+$ OneWay=�$ Default=�= 5�       5�     s   ShowArgumentLines . t   ArgumentLineBrush
t ��� �u   ShowOnlyInFocusedPaneu .  v   ArgumentLineStylev 5�     %;  DevExpress.Xpf.Charts.LineStyle;  5�     w ;  	Thickness$w 2��5�  !   5�     @ 5�     !  5�     $A BottomOutside=�5�     $
B Left=�5�     $C 
Horizontal=�5�     $D 1q�5�     $��1q�5�     $��5q�5�     
�������5�     ,<  &DevExpress.Xpf.Charts.ChartControlBasex <  Titlesx 5�     !=  DevExpress.Xpf.Charts.Title=  5�     .F 5�     � y � Orientation$y 
Horizontal=�6$   $��Center=�6=   
�������.+�5�     �� $_ 
Horizontal=�6%   $��Center=�6>   $��0��6[   .+�5�     �� -   5        $��chPrice��5�  '   
���   �$
a TrueY�6I   $��14(�6Z   $
��10,0q�6h   .��6v   Price5�     �� 5�     -   5        $��chLow��5�  '   
���  ��$a FalseY�6E   $��14(�6W   $
��10,0q�6e   .��6s   Low5�     �� 5�     -   5        $��chHigh��5�  '   
��� � �$a FalseY�6H   $��14(�6Z   $
��10,0q�6h   .��6v   High5�     �� 5�     -   5        $��	chVolumne��5�  '   
���   �$a FalseY�6K   $��14(�6]   $
��10,0q�6k   .��6y   Volume5�     �� 5�     -   5        $��chChange��5�  '   
���   �$
a TrueY�6J   $��14(�6[   $
��10,0q�6i   .��6w   
Change %5�     5�     5�     5�     G 5�     $  5�     z $  EnableAxisXNavigationz . { $  
PanesPanel{ 5�     �� 5�     .R�5�     �  5�  "   �� 5�  &   $��2* �64   �� 5�  &   $��* �64   �� 5�  &   $��* �64   5�     5�     | $  DefaultPane| 5�      >  DevExpress.Xpf.Charts.Pane>  5�     -   5        } > Name$} temperaturePane��5�  !   $��0��5�  !   ~ >  AxisXScrollBarOptions~ 5�     ,?  &DevExpress.Xpf.Charts.ScrollBarOptions?  5�  "    ?  Visible .  67   5�     � $  Panes� 5�     >  5�     -   5        $} pressurePane��5�  !   $��1��5�  !   ~ 5�     ?  5�  "    .  67   5�     >  5�     -    5        $} humidityPane��5�  !   $��2��5�  !   H 5�     %  5�     I .  � *  Title� 5�     %@  DevExpress.Xpf.Charts.AxisTitle@  5�  "   $F Prices��60   
���   �$
��Bold"�6T   O 5�     )  5�  "   � %  AlwaysShowZeroLevel� .  6,   J 5�     '  5�  "   $K 	{V:#,##0}��60   $
��Bold"�6J   5�     � $  SecondaryAxesY� 5�     ,A  &DevExpress.Xpf.Charts.SecondaryAxisY2DA  5�     -!   5        � A Name$� pressureAxis��5�  !   � (  	Alignment$
� Near=�5�  !   � &  GridLinesVisible� .  I .  � &  
MinorCount$� 3��5�  !   � 5�     @  5�  "   $F  VWap/Change ��60   
���   �$
��Bold"�6[   J 5�     '  5�  "   $K 	{V:#,##0}��60   $
��Bold"�6J   O 5�     )  5�  "   $M 0Q�5�  )   5�     A  5�     -"   5        $� humidityAxis��5   !   $
� Near=�5  !   � .  I .  $� 2��5  !   J 5	     '  5
  "   $K 	{V:#,##0}��60   $
��Bold"�6J   � 5     @  5  "   $F Volume��5  )   
���   �$
��Bold"�6M   O 5     )  5  "   $M 0Q�5  )   5     � $  AxisX� 5     #B  DevExpress.Xpf.Charts.AxisX2DB  5     � (  Visible$
� TrueX�5  !   � . � &  
Interlaced� . � B  DateTimeScaleOptions� 5     6C  0DevExpress.Xpf.Charts.ManualDateTimeScaleOptionsC  5  "   � C  AutoGrid� .  � C  MeasureUnit$	� Day=�5  )   � C  GridAlignment$	� Day=�5   )   � C  GridSpacing$� 6Q�5!  )   J 5#     '  5$  "   $K {A:MM/dd/yy}��60   � (  VisibilityInPanes� 5'     ,D  &DevExpress.Xpf.Charts.VisibilityInPaneD  5(  "   � D  Visible� .  � D  Pane� 5)  )   �� $ pressurePane��5*  )   D  5+  "   � .  � 5,  )   �� $ temperaturePane��5-  )   5/     P 53     )E  #DevExpress.Xpf.Charts.StockSeries2DE  54     $
V Date��56     -F  'DevExpress.Xpf.Charts.FinancialSeries2D� F  HighValueDataMember$
� High��57     � F  LowValueDataMember$	� Low��58     � F  OpenValueDataMember$
� Open��59     � F  CloseValueDataMember$� Close��5:     � -  ArgumentScaleType$� DateTime=�5;     � -  AnimationAutoStartMode$� SetStartState=�5<     � -  Visible� 5=     �� $ chPrice��$ 	IsChecked�� F  PointAnimation� 5?     2G  ,DevExpress.Xpf.Charts.Stock2DExpandAnimationG  5@  "   )H  #DevExpress.Xpf.Charts.AnimationBase� H  Duration$� 0:0:2h�6=   � -  Label� 5B     'I  !DevExpress.Xpf.Charts.SeriesLabelI  5C  "   *J  $DevExpress.Xpf.Charts.MarkerSeries2D� J  Angle$� 90Q�62   5E     (K  "DevExpress.Xpf.Charts.LineSeries2DK  5F     $
V Date��5G     $	W Low��5H     $	Q Low��5I     $� DateTime=�5J     � K  MarkerVisible� .  $� SetStartState=�5L     � 5M     �� $ chLow��$ 	IsChecked�5O     K  5P     $
V Date��5Q     $
W High��5R     $
Q High��5S     $� DateTime=�5T     � .  $� SetStartState=�5V     � 5W     �� $ chHigh��$ 	IsChecked�5Y     K  5Z     $
V Date��5\     $W ticketPrice��5]     $Q Broker Executions��5^     $� DateTime=�5_     � .  $� SetStartState=�5a     � -  
DataSource� 5[     �� *ByBrokerDateTable+$ OneWay=�$ Default=�� 5b     �� $ chBrokerExecutions��$ 	IsChecked�5d     )L  #DevExpress.Xpf.Charts.PointSeries2DL  5e     � -  
Visibility$� Hidden=�5g     � -  ToolTipEnabled$
� TrueX�5h     T . � L  
MarkerSize$� 10��5i  .   $V paymentDate��5j     $W amount��5k     $Q dividend��5l     $� DateTime=�5m     $� SetStartState=�5n     � 5f     �� *	Dividends+$ OneWay=�$ Default=�� 5o     �� $ imageVisibilty��$ 	IsChecked�� L  MarkerModel� 5r     -M  'DevExpress.Xpf.Charts.StarMarker2DModelM  5s  "   5u     1N  +DevExpress.Xpf.Charts.BarSideBySideSeries2DN  5v     $
V Date��5y  !   $
W Vwap��5z  !   $
Q vwap��5{  !   $� DateTime=�5|  !   $� SetStartState=�5�  !   � $  
SeriesPane� 5x     �� $ pressurePane��� /  AxisY� 5~  !   �� $ pressureAxis��� /  Pane� 5  !   %O  System.Windows.Markup.ReferenceO  � O  Name$� pressurePane��� 5�     �� $ 	chVolumne��$ 	IsChecked�5�     N  5�     $
V Date��5�     $W ChangePercent��5�     $Q Change %��5�     $� DateTime=�5�     $� SetStartState=�5�     � 5�     �� $ pressurePane��� 5�     �� $ pressureAxis��� 5�     O  $� pressurePane��� 5�     �� $ chChange��$ 	IsChecked�5�     (P  "DevExpress.Xpf.Charts.AreaSeries2DP  5�     $
V Date��5�  !   $W Volume��5�  !   $Q Volume��5�  !   $� DateTime=�5�  !   $� SetStartState=�5�  !   � 5�     �� $ humidityPane��� 5�     �� *
DataSeries+$ OneWay=�$ Default=�� 5�  !   �� $ humidityAxis��� 5�  !   O  $� humidityPane��5�     5�     5�     5�     5�     5�     