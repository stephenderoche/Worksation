   M S B A M L   `   `   `  ����O  Kmscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e0891&clr-namespace:System;assembly=mscorlibSystem  5      L HYieldCurve.Client, Version=5.1.0.0, Culture=neutral, PublicKeyToken=null5clr-namespace:YieldCurve.ClientYieldCurve.Client 5      -   'YieldCurve.Client.View.YieldCurveVisual   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35a ]DevExpress.Xpf.Core.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aW SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      ?dxe5http://schemas.devexpress.com/winfx/2008/xaml/editors  5      c _DevExpress.Xpf.Charts.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a>dxc4http://schemas.devexpress.com/winfx/2008/xaml/charts  5      c _System.Windows.Interactivity, Version=4.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35Bi:http://schemas.microsoft.com/expression/2010/interactivity  5      ;dx2http://schemas.devexpress.com/winfx/2008/xaml/core  5	      f	 bDevExpress.Xpf.Grid.v17.2.Core, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aa
 ]DevExpress.Xpf.Grid.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a>dxg2http://schemas.devexpress.com/winfx/2008/xaml/grid 	 
 5
      2sys&clr-namespace:System;assembly=mscorlib 	 
 5      -localclr-namespace:YieldCurve.Client 	 
 5      ] YDevExpress.Mvvm.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aAdxmvvm2http://schemas.devexpress.com/winfx/2008/xaml/mvvm   5      -   5        $
��auto��5      $
��auto��6-   
�������  � 	Resources  5      &   YieldCurve.Client.ColorConverter   ColorConverter* 
 $DevExpress.Xpf.Grid.GridColumnHeader �� 
TargetType �� Property �� Value  maxHeaderHeight  
wrapHeader �� TextAlignment��%	  &	        '       &	 ]     &	 {     7    5   
   68   �� 5   
   "  6   .�5      ��  � ��
 �����6+   5      X�5   
   40Q�5      �� 5   
   .R�5       �� 8��  $
��Wrap=�6V   $ Center=�6j   ��6   �� 6j   5!      5$      .��5&      � $��Stretch=�6   $
��auto��6'   
�������$
��Auto��6G   $��Stretch=�6U     5(   
     renameColumnHeaderTemplate%  DevExpress.Xpf.Editors.TextEdit%  DevExpress.Xpf.Editors.BaseEdit   	EditValue �� Path �� RelativeSource �� Mode	 �� AncestorType
 �� 	Converter+  %YieldCurve.Client.VisibilityConverter �� Mode �� ElementName2  ,YieldCurve.Client.ReverseVisibilityConverter��%9  &	       7  �� 5)      .R�5*      � .+�5+        $��textEdit��53      -   5        
���   � 5,      �� $ DataContext.Header� �� $ FindAncestor=�$	 dxg:HeaderContentControlL�y�5/      �� $@ :DataContext.(local:ColumnBehavior.IsRenameEditorActivated)� �� $ FindAncestor=�$	 dxg:HeaderContentControlL�
   $ TwoWay=�54      �� 55      $��Center=�56      8��  $
��Wrap=�59   F   $ Center=�6Z   ��57      �� y�58      �� $ 
Visibility�$ textEdit��
   59   Z   5<      5=      5?       � RowDefinitions 5B   
   �� 5C      $��30 �6   �� 5D      $��* �6   �� 5E      $��* �6    � ColumnDefinitions 5H   
   �� 5I      $��* �6   6+   �� 5J      $��* �6   6+   .+�5M   
   �� -   5         ��Name$ 	lblborder��5N      $��1��5M      $	��top=�6$   $��7��6=   
�������$
��Bold"�5N      $��Center=�6)   $��Stretch=�6M   �� 5P   
   -   5        $ lblborder45��5Q      $��2��5P      $	��top=�6$   $��7��6=   
������� J� Opacity$ 50Q�6_   $
��Bold"�5Q   ,   $��Center=�6>   $��Stretch=�6b   �� 5S   
   -   5        $ 
lblborder1��5T      $
��left=�5S      $��1��63   $��7��6C   
�������$��1��6e   $
��Bold"�5T   ,   $��Stretch=�6>   $��Stretch=�6a   $��2��6}   �� 5U   
   
�������.+�5V      )  #DevExpress.Xpf.Editors.ComboBoxEdit  -   5          Name$ comboBoxEdit1��5Y   *   $
��Left=�5W      $��0��5X      $��10,5,0,0q�5Y       J� 	AllowDrop . $	��Top=�5[      $	��178��6/   +  %DevExpress.Xpf.Editors.LookUpEditBase   IncrementalFiltering$
 TrueX�5]         ImmediatePopup .    AutoComplete .     FilterCondition$ ContainsX�5`         ValidateOnTextInput .  $   IsSynchronizedWithCurrentItem . '	  !DevExpress.Xpf.Editors.ButtonEdit 	  IsTextEditable$
 TrueX�5c      *
  $DevExpress.Xpf.Editors.PopupBaseEdit 
  IsPopupOpen .  5V      �� *Parameters.AccountName+$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�2  ,DevExpress.Mvvm.UI.Interactivity.Interaction   Triggers 5e   
   '  !DevExpress.Mvvm.UI.EventToCommand  5f      �  �DevExpress.Mvvm.UI.Interactivity.EventTriggerBase`1[[System.Windows.DependencyObject, WindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]   	EventName$ SelectedIndexChanged��6$      PassEventArgsToCommand$
 TrueX�6u   +  %DevExpress.Mvvm.UI.EventToCommandBase   Command 6E   �� *SelectedIndexChangedCommand+6u       Items.  5h   
   -  'DevExpress.Xpf.Editors.ComboBoxEditItem  $
��WM01��6   5i      5j      �� 5l   
   $��1��6   $��0��6%   ! �� Orientation$! 
Horizontal=�62   
�������.+�5p      �� $��Current Market Value:��6   $��14(�64   $	��5,0q�6B   6R   �� 5q      -   5        $��LBLPResentMarketValue��5q      $��14(�6�   $
��Bold"�6�   $	��2,0q�6�   
�������
���������62   �� *
PVOfBond+$ TwoWay=�$ PropertyChanged=�6�   �� 5r      $��Change in Market Value:��6   $��14(�66   $	��5,0q�6D   6T   �� 5s      -   5        $��LBLAdjMarketValue��5s      $��14(�5t      $
��Bold"�6#   $	��2,0q�65   
���������5s   .   �� *AdjPortfolioMarket+$ TwoWay=�$ PropertyChanged=�5v      �� 5w      $��Shift Market Value:��6   $��14(�62   $
��10,0q�6@   6Q   �� 5x      -	   5        $��LBLShiftMarketValue��5x      $��14(�5y      $
��Bold"�6#   $	��2,0q�65   
���������5x   0   �� *ShiftPortfolioMarket+$ TwoWay=�$ PropertyChanged=�5{      5~      (  "DevExpress.Xpf.Charts.ChartControl  5�   
   -
   5        $��chart��5�      $��1��5�      " J� IsManipulationEnabled" . 
�������$��0,7,0,0q�5�      #   CrosshairOptions# 5�      ,  &DevExpress.Xpf.Charts.CrosshairOptions  5�      $   ShowArgumentLine$ . %   ArgumentLineBrush
% ��� �&   ShowOnlyInFocusedPane& .  '   ArgumentLineStyle' 5�      %  DevExpress.Xpf.Charts.LineStyle  5�      (   	Thickness$( 2��5�   !   5�      )   Legend) 5�      "  DevExpress.Xpf.Charts.Legend  5�      *   VerticalPosition$* BottomOutside=�5�      +   HorizontalPosition$
+ Left=�5�      ,   Orientation$, 
Horizontal=�5�      -   IndentFromDiagram$- 1q�5�      $��0q�5�      $��5q�5�      ,  &DevExpress.Xpf.Charts.ChartControlBase.   Titles. 5�      !  DevExpress.Xpf.Charts.Title  5�      %  DevExpress.Xpf.Charts.TitleBase/   Content./ 5�      � 0 � Orientation$0 
Horizontal=�6    $��Center=�69   .+�5�      �� -   5        $��chkparallel��5�   #   
���  ��1 d� 	IsChecked$
1 TrueY�6G   $��14(�6X   $��10,0,0,0q�6f   .��6x   Parallel Shift5�        5�      -   5        $��TxtShiftAmount��5�   '   $��50��5�   '   $��20��62   $��10,0,0,0q�6>   $��12(�6P   2   MaskType$2 Numeric=�6_   {�5�   =   �� $ chkparallel��$ 	IsChecked�)  #DevExpress.Xpf.Editors.TextEditBase3   Text3 5�   '   �� *ShiftChange+$ TwoWay=�$ PropertyChanged=�5�   _   �� 5�      -   5        $��5,0,0,0q�5�   !   $��20��63   $��5��6@   
������$��1��6h   {�5�   !   �� $ chkparallel��$ 	IsChecked�5�      �� 5�      -   5        $��chkCurve2015��5�   #   $1 FalseY�68   $��14(�6J   $��50,0,0,0q�6X   .��6k   	2015 YC5�      �� 5�      -   5        $��chkCurve2016��5�   #   $1 FalseY�68   $��14(�6J   $��10,0,0,0q�6X   .��6j   	2016 YC5�      �� 5�      -   5        $��chkCurve2017��5�   #   $1 FalseY�68   $��14(�6J   $��10,0,0,0q�6X   .��6j   	2017 YC5�      5�      5�      4   Diagram4 5�      '  !DevExpress.Xpf.Charts.XYDiagram2D  5�      5   EnableAxisXNavigation5 . 6   AxisY6 5�      #  DevExpress.Xpf.Charts.AxisY2D  5�      $  DevExpress.Xpf.Charts.AxisBase7   GridLinesMinorVisible7 .     DevExpress.Xpf.Charts.Axis8   Title8 5�      %  DevExpress.Xpf.Charts.AxisTitle  5�   "   $/ Yield Curves��60   
���   �$
��Bold"�6Z   9   
WholeRange9 5�      !  DevExpress.Xpf.Charts.Range  5�   "   :   AlwaysShowZeroLevel: .  6,   ;   Label; 5�      %  DevExpress.Xpf.Charts.AxisLabel  5�   "   <   TextPattern$< 	{V:#,##0}��60   $
��Bold"�6J   5�      =   AxisX= 5�      #  DevExpress.Xpf.Charts.AxisX2D  5�      "   DevExpress.Xpf.Charts.Axis2D>    Visible$
> TrueX�5�   !   ?   GridLinesVisible? . @   
Interlaced@ . A   DateTimeScaleOptionsA 5�      6!  0DevExpress.Xpf.Charts.ManualDateTimeScaleOptions!  5�   "   B !  AutoGridB .  C !  MeasureUnit$	C Day=�5�   )   D !  GridAlignment$	D Day=�5�   )   E !  GridSpacing$E 6Q�5�   )   ; 5�        5�   "   $< {A:MM/dd/yy}��60   F    VisualRangeF 5�        5�   "   G   MaxValue9"  3DevExpress.Xpf.Charts.Design.AxisValueTypeConverter$G 06/08/2008 21:00:00.000" 6,   5�      ##  DevExpress.Xpf.Charts.DiagramH #  SeriesH 5�      ($  "DevExpress.Xpf.Charts.LineSeries2D$  5�      "%  DevExpress.Xpf.Charts.SeriesI %  ArgumentDataMember$I duration��5�      J %  ValueDataMember$J value��5�      K %  DisplayName$K Yield Curve��5�      L %  ArgumentScaleType$L Qualitative=�5�      M $  MarkerVisibleM .  N %  AnimationAutoStartMode$N SetStartState=�5�      O %  
DataSourceO 5�      �� *MyDataTable.DefaultView+$ OneWay=�$ Default=�5�      $  5�      $I duration��5�      $J value��5�      $K Parallel Shift��5�      $L Qualitative=�5�      M .  $N SetStartState=�5�      O 5�      �� *!MyDataTableParallel.DefaultView+$ OneWay=�$ Default=�P %  VisibleP 5�      �� $ chkparallel��$ 	IsChecked�5�      $  5�      $I duration��5     $J value��5     $K 2017 Yield Curve��5     $L Qualitative=�5     M .  $N SetStartState=�5     O 5      �� *MyDataTable2017.DefaultView+$ OneWay=�$ Default=�P 5     �� $ chkCurve2017��$ 	IsChecked�5	     $  5
     $I duration��5     $J value��5     $K 2016 Yield Curve��5     $L Qualitative=�5     M .  $N SetStartState=�5     O 5     �� *MyDataTable2016.DefaultView+$ OneWay=�$ Default=�P 5     �� $ chkCurve2016��$ 	IsChecked�5     $  5     $I duration��5     $J value��5     $K 2015 Yield Curve��5     $L Qualitative=�5     M .  $N SetStartState=�5     O 5     �� *MyDataTable2015.DefaultView+$ OneWay=�$ Default=�P 5     �� $ chkCurve2015��$ 	IsChecked�5     5$     5&       5(  
   -   5        $��chartposition��5)     
�������$��2��5+     " . $	��0,7q�5.     y�5-     �� $ chkpositions��$ 	IsChecked�# 5/       50     $ . 
% ��� �& .  ' 54       55     $( 2��56  !   58     . 5:       5;     ./ 5<     � $0 
Horizontal=�6    $��Center=�69   .+�5?     �� -   5        $��chkDuration��5?  #   $
1 TrueY�67   $��14(�6H   $��50,0,0,0q�6V   .��6i   
Duration5A     �� 5B     -   5        $��chkYield��5B  #   $1 FalseY�64   $��14(�6F   $��10,0,0,0q�6T   .��6f   Yield5D     5F     5G     4 5J       5K     5 . 6 5M       5N     7 .  8 5Q       5R  "   $/ Duration/YTM��60   
���   �$
��Bold"�6Z   9 5T       5U  "   : .  6,   ; 5W       5X  "   $< 	{V:#,##0}��60   $
��Bold"�6J   5Z     = 5]       5^     $
> TrueX�5_  !   ? .  @ . ; 5c       5d  "   Q   Angle$Q 45��60   $
��Bold"�6<   R   QualitativeScaleOptionsR 5f     3&  -DevExpress.Xpf.Charts.QualitativeScaleOptions&  5g  "   S &  AutoGridS .  6>   5j     H 5m     ('  "DevExpress.Xpf.Charts.AreaSeries2D'  5n     &(   DevExpress.Xpf.Charts.XYSeries2DT (  CrosshairLabelPattern$T Duration {V:n2};��5p     U %  ToolTipEnabled$
U TrueX�5q     $)  DevExpress.Xpf.Charts.XYSeriesV )  	ColorEachV . $I symbol��5s     $J duration��69   $K symbol��5t     $
L Auto=�5u     $N SetStartState=�5v     W %  Opacity$W 50Q�5x     O 5o     �� *PositionCurve+$ OneWay=�$ Default=�P 5w     �� $ chkDuration��$ 	IsChecked�5{     '  5|     $T YTM: {V:n2}��5~     $
U TrueX�5     V . $I symbol��5�     $J value��69   $K symbol��5�     $
L Auto=�5�     $N SetStartState=�5�     $W 50Q�5�     O 5}     �� *PositionCurve+$ OneWay=�$ Default=�P 5�     �� $ chkYield��$ 	IsChecked�5�     5�     5�     � 5�     $��1��6   $��1��6    $��3��6-    5�     �� 5�     $
��1.6* �6)   69   �� 5�     $��* �6(   65    5�     �� 5�     $��* �6+   67   �� 5�     $��* �6+   67   .+�5�     �� -   5        $ 
lblborder3��5�     $��1��5�     $	��top=�6(   $��7��6A   
�������$ 50Q�6c   $
��Bold"�5�  0   $��Center=�6B   $��Stretch=�6f   $��3��6�   �� 5�     -   5        $ lblborder18��5�     $
��left=�5�     $��1��67   $��7��6G   
�������$��1��6i   $ 50Q�6v   $
��Bold"�5�  2   $��Stretch=�6D   $��Stretch=�6g   %* 
 DevExpress.Xpf.Grid.GridControl*  5�     -   5        X * Name$X 	_dataGrid��5�  d   )+ 	 #DevExpress.Xpf.Grid.DataControlBaseY +  AutoGenerateColumns$Y AddNew=�6    #Z +  EnableSmartColumnsGenerationZ .  $��0��6x   $��2��6�   $��SemiBold"�5�  '   [ *  AllowLiveDataShaping$
[ TrueX�6A   $��7,0,0,0q�6^   $��0��6o   \ *  
Background
\ �����$��Stretch=�5�  '   !] *  HorizontalContentAlignment$] Stretch=�5�  '   $��12(�5�  '   $��Calibri)�65   ^ +  SelectionMode$	^ Row=�5�  '   4,  .DevExpress.Xpf.Core.Serialization.DXSerializer_ ,  StoreLayoutMode$	_ All=�5�  '   9- 	 3DevExpress.Xpf.Grid.DataControlSerializationOptions` -  AddNewColumns` . a -  RemoveOldColumnsa .  b +  ItemsSourceb 5�  '   �� *BondChange.DefaultView+$ OneWay=�$ Default=�c *  Viewc 5�     #. 
 DevExpress.Xpf.Grid.TableView.  5�  "   -   5        d . Name$d _viewDataGrid��5�  !   e .  AllowPerPixelScrollinge . &/ 	  DevExpress.Xpf.Grid.DataViewBasef /  ShowTotalSummaryf . g .  AllowChangeBandParentg . h .  AllowChangeColumnParenth . &0 
  DevExpress.Xpf.Grid.GridViewBasei 0  ShowGroupPaneli .  %j .  AllowConditionalFormattingMenuj . $��7q�5�  !   k /  ColumnHeaderTemplate#k [ 5�  !   5�  #   l *  Columnsl 5�     $1 
 DevExpress.Xpf.Grid.GridColumn1  5�     $2 	 DevExpress.Xpf.Grid.BaseColumnm 2  Header)3  #DevExpress.Xpf.Core.ObjectConverter$m 
PV Of Bond3 6%   $4 	 DevExpress.Xpf.Grid.ColumnBasen 4  	FieldName$n PVOfBond��6g   o 2  Width25 	 ,DevExpress.Xpf.Grid.GridColumnWidthConverter$	o 1405 6|   p 4  Bindingp 69   �� *
PVOfBond+q �� StringFormat$q n2��r 4  EditSettingsr 5�  &   66  0DevExpress.Xpf.Editors.Settings.TextEditSettings6  5�  *   67  0DevExpress.Xpf.Editors.Settings.BaseEditSettingss 7  DisplayFormat$s N2��6?   5�  #   1  5�     $m Adj. Value Bond3 6%   $n NewValue��6l   $	o 1405 6�   p 6>   �� *
NewValue+$q n2��r 5�  &   6  5�  *   $s N2��6?   5�  #   1  5�     $n CustomColumn1��6%   #t 4  AllowUnboundExpressionEditort . u 4  UnboundType] YDevExpress.Data.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a88  2DevExpress.Utils.Design.UnboundColumnTypeConverter$u Decimal8 5�  2   v 4  ReadOnlyv .  r 5�     6  5�     $s N2��63   5�     1  5�  "   $n CustomColumn2��61   t . $u Decimal8 5�  2   v .  5�  1   1  5�  "   $n CustomColumn3��61   t . $u Decimal8 5�  2   v .  5�  1   1  5�  "   $n CustomColumn4��61   t . $u Decimal8 5�  2   v .  5�  1   1  5�  "   $n CustomColumn5��61   t . $u String8 5�  2   v .  5�  1   1  5�  "   $n CustomColumn6��61   t . $u String8 5�  2   v .  5�  1   w � ContextMenuw 5�     �� 5�  "   x �� PlacementTargetx 6.   �� $ dgModels��  5�  &     SimpleSysResources��%R   &	       �� 5�  *   " m�6K   .�5�  .   ��  � ��$ 16(�6K   5�  +   5�  '   5�  #   5�       5�     -   5        $��chartDistribution��5�     
�������$��1��5     $��0��6*   " . $��7,7,0,0q�5     y   AnimationMode$y OnDataChanged=�5     . 5       5  "   ./ 5  &   � $0 
Horizontal=�60   $��Center=�6I   .+�5
  *   	� -   5        $��rdoDuration��5
  6   
���  ��$
1 TrueY�6Z   $��14(�6k   $��10,0,0,0q�6y   .��6�   Duration Distribution5  +   	� 5     -   5        $��	rdoRating��5  *   
����  �$1 FalseY�6M   $��14(�6_   $��10,0,0,0q�6m   .��6�   Ratings Distribution5  +   	� 5     -   5        $��	rdoSector��5  *   
��� � �$1 FalseY�6N   $��14(�6`   $��10,0,0,0q�6n   .��6�   Sector Distribution5  +   	� 5  *   -   5        $��rdoYield��5  6   
��� ���$1 FalseY�6Z   $��14(�6l   $��10,0,0,0q�6z   .��6�   Yield Distribution5  +   5     5  #   # 5       5     $ . 
% ��� �& .  ' 5        5!     $( 2��5"  -   5$     4 5&       5'  "   5 . 6 5)  &     5*  *   7 .  8 5-  .     5.  2   $/ Distributions��6@   
���   �$
��Bold"�6k   9 50  .     51  2   : .  6<   ; 53  .     54  2   $< 	{V:#,##0}��6@   $
��Bold"�6Z   56  +   = 59  &     5:     $
> TrueX�5;  -   ? .  @ . ; 5>  "     5?  2   $Q 45��6@   $
��Bold"�6L   R 5A  .   &  5B  2   S .  6N   5E  +   H 5H  &   19  +DevExpress.Xpf.Charts.BarSideBySideSeries2D9  5I     $T Duration {V:n2};��5K  )   $
U TrueX�5L  )   V . $I description��5N  )   $J value��6J   $K Duration��5O  )   $
L Auto=�5P  )   $N SetStartState=�5Q  )   O 5J  )   �� *DistributionDuration+$ OneWay=�$ Default=�P 5R  )   �� $ rdoDuration��$ 	IsChecked�5V  +   $  5W     $U FalseX�5Y  -   V . $I description��5[  -   $J value��6N   $K Duration��5\  -   $
L Auto=�5]  -   $N SetStartState=�5^  -   O 5X  -   �� *DistributionDuration+$ OneWay=�$ Default=�P 5_  -   �� $ rdoDuration��$ 	IsChecked�5b     9  5c     $T Rating: {V:n2};��5e  -   $
U TrueX�5f  -   V . $I description��5h  -   $J value��6N   $K Rating��5i  -   $
L Auto=�5j  -   $N SetStartState=�5k  -   O 5d  -   �� *DistributionRating+$ OneWay=�$ Default=�P 5l  -   �� $ 	rdoRating��$ 	IsChecked�5p  +   $  5q     $U FalseX�5s  -   V . $I description��5u  -   $J value��6N   $K Rating��5v  -   $
L Auto=�5w  -   $N SetStartState=�5x  -   O 5r  -   �� *DistributionRating+$ OneWay=�$ Default=�P 5y  -   �� $ 	rdoRating��$ 	IsChecked�5|  +   9  5}     $T Yield: {V:n2};��5  -   $
U TrueX�5�  -   V . $I description��5�  -   $J value��6N   $K Yield��5�  -   $
L Auto=�5�  -   $N SetStartState=�5�  -   O 5~  -   �� *DistributionYield+$ OneWay=�$ Default=�P 5�  -   �� $ rdoYield��$ 	IsChecked�5�  +   $  5�     $U FalseX�5�  -   V . $I description��5�  -   $J value��6N   $K Yield��5�  -   $
L Auto=�5�  -   $N SetStartState=�5�  -   O 5�  -   �� *DistributionYield+$ OneWay=�$ Default=�P 5�  -   �� $ rdoYield��$ 	IsChecked�5�  +   9  5�     $T Sector: {V:n2};��5�  -   $
U TrueX�5�  -   V . $I description��5�  -   $J value��6N   $K Sector��5�  -   $
L Auto=�5�  -   $N SetStartState=�5�  -   O 5�  -   �� *DistributionSector+$ OneWay=�$ Default=�P 5�  -   �� $ 	rdoSector��$ 	IsChecked�5�  +   $  5�     $U FalseX�5�  -   V . $I description��5�  -   $J value��6N   $K Sector��5�  -   $
L Auto=�5�  -   $N SetStartState=�5�  -   O 5�  -   �� *DistributionSector+$ OneWay=�$ Default=�P 5�  -   �� $ 	rdoSector��$ 	IsChecked�5�  +   5�  #   5�       5�     -   5        $��charttop��5�     
�������$��1��5�     $��1��6   " . $��7,7,0,0q�5�     $y OnDataChanged=�5�     y�5�     �� $ chkpositions��$ 	IsChecked�. 5�       5�  "   ./ 5�  &   � $0 
Horizontal=�60   $��Center=�6I   .+�5�  *   	� -   5        $��rdoContDuration��5�  6   
���  ��$
1 TrueY�6^   $��14(�6o   $��10,0,0,0q�6}   ��5�  6   �� *WeightedDuration+$ OneWay=�$ Default=�5�  +   	� 5�  *   -   5        $��rdoContYield��5�  6   
����  �$1 FalseY�6\   $��14(�6n   $��10,0,0,0q�6|   ��5�  6   �� *WeightedYield+$ OneWay=�$ Default=�5�     5�  '   5�  #   # 5�       5�     $ . 
% ��� �& .  ' 5�       5�     $( 2��5�  !   5�     4 5�       5�     5 . 6 5�       5�     7 .  8 5�  "     5�  &   $/ Contibutions��64   
���   �$
��Bold"�6^   9 5�  "     5�  &   : .  60   ; 5�  "     5�  &   $< 	{V:#,##0}��64   $
��Bold"�6N   5�     = 5�       5�     $
> TrueX�5�  !   ? .  @ . ; 5�  "     5�  &   $Q 45��64   $
��Bold"�6@   R 5�  "   &  5�  &   S .  6B   5�     H 5      *:  $DevExpress.Xpf.Charts.BubbleSeries2D:  5     $6T 0Symbol: {A} Cont. to Duration: {W:n4} MV {V:n2};��5  !   $
U TrueX�5     V . $I symbol��5     $J mv��69   z :  WeightDataMember$z Contribution��6O   $K Cont. To Duration��5     $
L Auto=�5     $N SetStartState=�5	     O 5     �� *ContDuration+$ OneWay=�$ Default=�P 5
     �� $ rdoContDuration��$ 	IsChecked�5     :  5     $2T ,Symbol: {A} Cont to Yield: {W:n4} MV {V:n2};��5  !   $
U TrueX�5  !   V . $I symbol��5  !   $J mv��6=   $z Contribution��6S   $K Cont. To Yield��5  !   $
L Auto=�5  !   $N SetStartState=�5  !   O 5  !   �� *	ContYield+$ OneWay=�$ Default=�P 5  !   �� $ rdoContYield��$ 	IsChecked�5     5     5      5"     5(     5)     