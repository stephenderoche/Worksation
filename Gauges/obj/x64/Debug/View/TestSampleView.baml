   M S B A M L   `   `   `  ����N  JGenericChart.Client, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nulla5clr-namespace:Linedata.Client.Widget.TestSampleWidget'Linedata.Client.Widget.TestSampleWidget  5
      O Kmscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e0891&clr-namespace:System;assembly=mscorlibSystem 5      A    ;Linedata.Client.Widget.TestSampleWidget.View.TestSampleView   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35a ]DevExpress.Xpf.Core.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aW SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      f bDevExpress.Xpf.Grid.v17.2.Core, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aa ]DevExpress.Xpf.Grid.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a>dxg2http://schemas.devexpress.com/winfx/2008/xaml/grid   5      c	 _DevExpress.Xpf.Charts.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a>dxc4http://schemas.devexpress.com/winfx/2008/xaml/charts 	 5      ?dxe5http://schemas.devexpress.com/winfx/2008/xaml/editors  5      ]
 YDevExpress.Mvvm.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aAdxmvvm2http://schemas.devexpress.com/winfx/2008/xaml/mvvm 
  5	      Clocal5clr-namespace:Linedata.Client.Widget.TestSampleWidget 
  5
      2sys&clr-namespace:System;assembly=mscorlib 
  5      ;dx2http://schemas.devexpress.com/winfx/2008/xaml/core  5      -   5        
�������$
��Left=�5      $
��Left=�62   $��Calibri)�6T   $
��auto��6i   $
��auto��6v     � 	Resources  5      *  $DevExpress.Xpf.Grid.GridColumnHeader �� 
TargetType �� Property �� Value   maxHeaderHeight  
wrapHeader �� TextAlignment��%�   '        &	  J     &	 h     7   �� 5   
   "  6   .�5      ��  � ��
 ��·�6+   5      X�5   
   40Q�5      �� 5   
   .R�5      �� 8��  $
��Wrap=�6V   $ Center=�6j   ��6   �� 6j   5      5       .��5"      � $��Stretch=�6   $
��auto��6'   
�������$
��Auto��6G     5#   
     renameColumnHeaderTemplate%  DevExpress.Xpf.Editors.TextEdit%  DevExpress.Xpf.Editors.BaseEdit   	EditValue �� Path �� RelativeSource �� Mode	 �� AncestorType
 �� 	ConverterA   ;Linedata.Client.Widget.TestSampleWidget.VisibilityConverter �� Mode �� ElementNameH   BLinedata.Client.Widget.TestSampleWidget.ReverseVisibilityConverter��%�  &	       7   &	 +    7   �� 5%      .R�5&      � .+�5'        $��textEdit��5/      -   5        
���   � 5(      �� $ DataContext.Header� �� $ FindAncestor=�$	 dxg:HeaderContentControlL�y�5+      �� $@ :DataContext.(local:ColumnBehavior.IsRenameEditorActivated)� �� $ FindAncestor=�$	 dxg:HeaderContentControlL�
   $ TwoWay=�50      �� 51      $��Center=�52      8��  $
��Wrap=�55   F   $ Center=�6Z   ��53      �� y�54      �� $ 
Visibility�$ textEdit��
   55   Z   58      59      �� 5:      .R�5;      �� 8��  $
��Wrap=�6Z   $ Center=�6n   ��6   �� 6n   5<      5=      .+�5@   
   ( 	 "DevExpress.Xpf.Charts.ChartControl  -   5        $��TopAccountsBar��5@         AnimationMode$ OnDataChanged=�62   $y�Hidden=�6Q   $��0,45,0,0q�6e   $
��auto��6w   $
��auto��6�      Diagram 5B      ' 	 !DevExpress.Xpf.Charts.XYDiagram2D  5C      # 	 DevExpress.Xpf.Charts.Diagram   Series 5D      1	 	 +DevExpress.Xpf.Charts.BarSideBySideSeries2D	  5E      "
 	 DevExpress.Xpf.Charts.Series 
  DisplayName$ Holdings MV��64   + 	 %DevExpress.Xpf.Charts.BarSeries2DBase   BarWidth$	 0.5Q�6N    
  ArgumentDataMember$ Account��6]    
  ValueDataMember$ MV��6z   & 	  DevExpress.Xpf.Charts.XYSeries2D   CrosshairEnabled$
 TrueX�6�      CrosshairLabelPattern$ Acoount: {A}; MV: {V:n2}��6�   ' 	 !DevExpress.Xpf.Charts.BarSeries2D   Model 5G      - 	 'DevExpress.Xpf.Charts.Quasi3DBar2DModel  5H   "   5K         AxisY 5M      # 	 DevExpress.Xpf.Charts.AxisY2D  5N      $ 	 DevExpress.Xpf.Charts.AxisBase   GridLinesMinorVisible .    Label 5O      % 	 DevExpress.Xpf.Charts.AxisLabel  5P   "      TextPattern$ 	{V:#,##0}��60   $
��Bold"�6J   " 	 DevExpress.Xpf.Charts.Axis2D   VisualRange 5R      ! 	 DevExpress.Xpf.Charts.Range  5S   "      SideMarginsValue$ 0Q�5T         AutoSideMargins . 6!     	 DevExpress.Xpf.Charts.Axis   
WholeRange 5V        5W   "   $ 0Q�5X      5Z         AxisX 5\      # 	 DevExpress.Xpf.Charts.AxisX2D  5]       .     
MinorCount$  1��6C   !   
Interlaced! . "   LogarithmicBase$" 2Q�6d    5^        5_   "   #   Angle$# 90��60   $
��Bold"�6<   $   QualitativeScaleOptions$ 5a      3 	 -DevExpress.Xpf.Charts.QualitativeScaleOptions  5b   "   %   AutoGrid% .  6>   5e      5g      &   Legend& 5i      " 	 DevExpress.Xpf.Charts.Legend  5j      $��4q�6   $
��Bold"�61   5l        5m   
   -   5        '  Name$' 
TopIssuers��5m      $ OnDataChanged=�63   , 	 &DevExpress.Xpf.Charts.ChartControlBase(   
AutoLayout( . $��0,45,0,0q�6e   $y�Hidden=�6w   )   CrosshairOptions) 5o      , 	 &DevExpress.Xpf.Charts.CrosshairOptions  5p      0 	 *DevExpress.Xpf.Charts.CrosshairOptionsBase*   ShowValueLine* . +   ShowValueLabels+ . 6<   . 5r        $��0,4,0,-4q�6    5s        5t       .  5u        5v      $ 	{V:#,##0}��6,   $
��Bold"�6F    5x        5y      $ 0Q�5z       . 6!    5|        5}      $ 0Q�5~      5�       5�        5�       5�        5�      $# 45��6,   $
��Bold"�68   $ 5�        5�      % .  6:   5�      . 5�      * 	 $DevExpress.Xpf.Charts.BubbleSeries2D  ,   Transparency$	, 0.2Q�6%   $ 	 DevExpress.Xpf.Charts.XYSeries-   	ColorEach- . $* $Security: {A}; MV: {V:n2}; %: {W:n2}��5�   	   $ 
IssuerName��6F   $ MV��6f   .   WeightDataMember$. PctTotal��6{   / 
  LegendTextPattern$/ #,##0.00��6�   5�      5�        5�   
   -   5        $' TopSecurities��5�      $ OnDataChanged=�66   $y�Hidden=�6U   ( . $��0,45,0,0q�6{   ) 5�        5�      * . + . 6<   . 5�        $��0,4,0,-4q�6   (0   !LabelsResolveOverlappingMinIndent$0 0��61    5�        5�       .  5�        5�      $ 	{V:#,##0}��6,   $
��Bold"�6F    5�        5�      $ 0Q�5�       . 6!    5�        5�      $ 0Q�5�      5�       5�        5�       . $  1��6?   ! . $" 2Q�6`    5�        5�      $# 90��6,   $
��Bold"�68   5�      . 5�        $	, 0.2Q�6%   - . $* $security: {A}; MV: {V:n2}; %: {W:n2}��5�   	   $ Symbol��6F   $ MV��6b   $. PctTotal��6w   $/ #,##0.00��6�   1 
  ToolTipEnabled$
1 TrueX�6�   2 
  LabelsVisibility2 . 6�   5�      5�        5�   
   -   5        $��ChartHierarchy��5�      3 � ToolTip$!3 Shows Holdings By Hierarchy��62   $ OnDataChanged=�6X   4 J� IsManipulationEnabled4 . $��0,65,0,0q�6�   $y�Hidden=�6�   $��Calibri Black)�6�    5�      + 	 %DevExpress.Xpf.Charts.SimpleDiagram2D  5�       5�      ' 	 !DevExpress.Xpf.Charts.PieSeries2D  5�      -   5        $��ChartHierarchySeries��5�   @   % 	 DevExpress.Xpf.Charts.PieSeries5   HoleRadiusPercent$5 0Q�6*   $ Symbol��6]   $ PctTotal��6y   $��Calibri Black)�5�   I   6 � DataContext6 6*   �� *Table1+7   Model7 5�      +  	 %DevExpress.Xpf.Charts.GlassPie2DModel   5�   "   8 
  PointOptions8 5�      (! 	 "DevExpress.Xpf.Charts.PointOptions!  5�   "   9 !  ValueNumericOptions9 5�   &   *" 	 $DevExpress.Xpf.Charts.NumericOptions"  5�   *   : "  Format$: Percent=�6=   ; "  	Precision$; 0��6N   5�   #   < 
  LegendPointOptions< 5�      !  5�   "   = !  Pattern$	= {A}��63   5�      5�      & 5�        5�      $��10(�6   $��4,4,4,4q�6,   (# 	 "DevExpress.Xpf.Charts.ChartElement> #  MaxWidth$	> 150Q�6F   $
��Bold"�6U   5�        5�   
   -   5        $��ChartPerformance��5�      $ OnDataChanged=�63   ( . $��0,45,0,0q�6d   $y�Hidden=�6v   ) 5�        5�      * . + . 6<    5�        5�       5�      ($ 	 "DevExpress.Xpf.Charts.AreaSeries2D$  5�      $ Account��6+   ? $  Transparency$	? 0.5Q�6A   $ Period��6T   $ Account Return��6p   6 6�   �� *Table1+5�      $  5�      $ 	Benchmark��6+   $	? 0.5Q�6C   $ Period��6V   $ Benchmark Return��6r   6 6�   �� *Table1+5�       5�        5�      @   Range@ 5�      %% 	 DevExpress.Xpf.Charts.AxisRange%  5�   "   A %  SideMarginsEnabledA .  60   5�       5�        5�       .  5�        5�   "   $ 	{V:#,##0}��60   $
��Bold"�6J    5�        5�   "    5�        5�   "   $ 0Q�5�      5     5     & 5       5     $��4q�6   $
��Bold"�61   5
       5  
   -	   5        $' ChartTopCmplSecurities��5     $ OnDataChanged=�6?   $y�Hidden=�6^   ( . $��0,45,0,0q�6�    5       5     B   RenderTransformOrigin$B 0.5,0.5&�6&   $��0,0,0,0q�6G    5       5     -
   5        $��AssetAllocationSeries��5  +   $ Symbol��6H   $ pct_acct_total��6d   $5 40Q�6�   2 . C 
  ShowInLegendC . $
1 TrueX�6�   $��12(�6�   $
��Bold"�6�   $��Segoe UI)�6�   &&   System.Windows.Media.TextOptionsD &  TextHintingMode$D Animated=�6  E 
  
Background
E �����F 
  
Foreground
F ��� �7 5     +' 	 %DevExpress.Xpf.Charts.GlarePie2DModel'  5  "   8 5     !  5  "   G !  	PointView$G ArgumentAndValues=�63   $=  ��6Q   9 5  &   "  5  *   $: Percent=�6=   5  #   5!     5#     5&       5'  
   -   5        $' ChartBreachesBySeverity��5'     $ OnDataChanged=�6@   ( . $��0,45,0,0q�6r   $y�Visible=�6�    5)       5+     $B 0.5,0.5&�6&   $��0,0,0,0q�6G    5-       5.     -   5        $��ComplianceSeverityChart��5.  +   $ country��6J   $ disclosures��6g   $5 0Q�6�   2 . C . $
1 TrueX�6�   $��12(�6�   $
��Bold"�6�   $��Segoe UI)�6�   $D Animated=�6  
E �����
F ��� �7 50     '  51  "   8 54     !  55  "   $G ArgumentAndValues=�63   $=  ��6Q   9 56  &   "  57  *   $: Percent=�6=   59  #   5<     5>     5A       5B  
   -   5        $��ChartVsBenchmark��5B     $ Disabled=�64   $y�Visible=�6N   $��0,45,0,0q�6c   H   ToolTipEnabled$
H TrueX�6u   ) 5C       5D     I   ShowArgumentLabelsI . * . + . J   ShowOutOfRangePointsJ . 6m    5G       5H      5I     	  5J     $ 
Holdings %��64   $	 0.5Q�6M   $ Asset_class��6\   $ Holdings_percent��6}   5L     	  5M     $ Benchmark %��64   $	 0.5Q�6N   $ Asset_class��6]   $ benchmark_percent��6~    5S       5T  "   5W      5Y       5Z      .  5[       5\  "   $ 	{V:#,##0}��60   $
��Bold"�6J    5^       5_  "   $ 0Q�5`      . 6!    5b       5c  "   $ 0Q�5d     5f      5h       5i      . $  1��6C   ! . $" 2Q�6d    5j       5k  "   $
��Bold"�62   $ 5m       5n  "   % .  6>   5q     5t     & 5v       5w     $��4q�6   $��12(�61   $
��Bold"�6?   5{       5|  
   -   5        $' AssetUnderBubble��5|     $ OnDataChanged=�69   ( . $��0,45,0,0q�6k   ) 5}       5~     * . + . 6<   . 5�       $��0,4,0,-4q�6    5�       5�      .  5�       5�     $ 	{V:#,##0}��6,   $
��Bold"�6F    5�       5�     $ 0Q�5�      . 6!    5�       5�     $ 0Q�5�     5�     . 5�       $	, 0.2Q�6%   - . $% Aum: {A}; MV: {V:n2}; %: {W:n2}��5�  	   $ 
asset_type��6A   $ market_value��6a   $. percentof_assets��6�   $/ #,##0.00��6�   $
��Bold"�6�   5�     5�       5�  
   -   5        $' ChartMaturities��5�     $��0,30,0,0q�64   $ OnDataChanged=�6F   $��0��6d   ( . ) 5�       5�     * . + . 6<   . 5�        5�       5�      .  5�       5�     $ 	{V:#,##0}��6,   $
��Bold"�6F    5�       5�     $ 10Q�5�  	    . 6    5�       5�     $ 10Q�5�  	   5�      5�       5�      . $  1��6?   ! . $" 2Q�6`    5�       5�     $# 45��6,   $
��Bold"�68   $ 5�       5�     % .  6:   5�     . 5�     )( 	 #DevExpress.Xpf.Charts.PointSeries2D(  -   5        K ( Name$
K test��5�  E   - . L (  
MarkerSize$L 20��65   $ Symbol��6S   $
 Cash��6o   $/ #,##0.00��6�   8 5�     !  5�     $G ArgumentAndValues=�6+   $= {A} : {V:#,##0.00}��6I   M (  MarkerModelM 5�     /) 	 )DevExpress.Xpf.Charts.DollarMarker2DModel)  5�     N 
  LabelN 5�     '* 	 !DevExpress.Xpf.Charts.SeriesLabel*  5�     O *  ConnectorVisibleO . P *  Indent$P 15��6B   *+ 	 $DevExpress.Xpf.Charts.MarkerSeries2DQ +  Angle$Q 90Q�6N   $
��Bold"�6l   5�     	  5�     $* $Security: {A}; MV: {V:n2}; %: {W:n2}��6,   5�     5�     %,  DevExpress.Xpf.Grid.GridControl,  5�  
   -   5        R , Name$R 	_dataGrid��5�     4-  .DevExpress.Xpf.Core.Serialization.DXSerializerS -  StoreLayoutMode$	S All=�6.   ).  #DevExpress.Xpf.Grid.DataControlBaseT .  AutoGenerateColumns$T AddNew=�6U   U .  AutoPopulateColumnsU . #V .  EnableSmartColumnsGenerationV . $��0,60,0,0q�5�     9/  3DevExpress.Xpf.Grid.DataControlSerializationOptionsW /  AddNewColumnsW . X /  RemoveOldColumnsX .  Y ,  ViewY 5�     #0  DevExpress.Xpf.Grid.TableView0  5�     -   5        Z 0 Name$Z _viewDataGrid��5�     [ 0  AllowPerPixelScrolling[ . &1   DevExpress.Xpf.Grid.DataViewBase\ 1  ShowTotalSummary\ . ] 0  AllowChangeBandParent] . ^ 0  AllowChangeColumnParent^ . &2   DevExpress.Xpf.Grid.GridViewBase_ 2  ShowGroupPanel_ .  %` 0  AllowConditionalFormattingMenu` . a 1  ColumnHeaderTemplate#a [ 5�     5�     b � ContextMenub 5�     �� 5�     c �� PlacementTargetc 6   �� $ dgModels��  5�       SimpleSysResources��%R   &	       �� 5�     " m�6;   .�5�     ��  � ��$ 16(�6;   5�     5�     .@�5�     m� $��Approve and send��6   #��[ 6:   $��Calibri)�6g   $��12(�6|   5�     d ,  Columnsd 5�     $3  DevExpress.Xpf.Grid.GridColumn3  5�     $4  DevExpress.Xpf.Grid.ColumnBasee 4  	FieldName$e CustomColumn1��6!   #f 4  AllowUnboundExpressionEditorf . g 4  UnboundType] YDevExpress.Data.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a85  2DevExpress.Utils.Design.UnboundColumnTypeConverter$g Decimal5 5�  &   h 4  ReadOnlyh .  5�  %   3  5�     $e CustomColumn2��6!   f . $g Decimal5 5�  &   h .  5�  %   3  5�     $e CustomColumn3��6!   f . $g Decimal5 5�  &   h .  5�  %   3  5      $e CustomColumn4��6!   f . $g Decimal5 5  &   h .  5  %   3  5     $e CustomColumn5��6!   f . $g String5 5  &   h .  5  %   3  5     $e CustomColumn6��6!   f . $g String5 5  &   h .  5  %   5     �� 5  
   -   5        $��	lblheader��5  �   $��Center=�6o   $	��Top=�6�   $��	10,19,0,0q�6�   $��Calibri Black)�6�   $��18(�6�   ���	#FF0072C6$
��auto��6	  $��27��6  ��6   �� $ Parameters.DataType�$ TwoWay=�i �� UpdateSourceTrigger$i PropertyChanged=�6  �� 5  
   -   5        $��lblhierarchy��5  �   $��Center=�6p   $	��Top=�6�   $��	10,40,0,0q�6�   $��Calibri Black)�6�   $��18(�6�   ���	#FF0072C6$
��auto��6  $��27��6  ��6   �� $ Parameters.Hierarchy�$ TwoWay=�$i PropertyChanged=�6  )6  #DevExpress.Xpf.Editors.ComboBoxEdit6  5#  
   -   5        j 6 Name$j comboBoxEdit1��5%     $
��Left=�5$     $��10,0,0,0q�5%     k J� 	AllowDropk . $	��Top=�5'     $	��150��6   $��20��6)   +7  %DevExpress.Xpf.Editors.LookUpEditBasel 7  IncrementalFiltering$
l TrueX�5)     m 7  ImmediatePopupm . n 7  AutoCompleten .  o 7  FilterCondition$o ContainsX�5,     p   ValidateOnTextInputp .  $q 7  IsSynchronizedWithCurrentItemq . '8  !DevExpress.Xpf.Editors.ButtonEditr 8  IsTextEditable$
r TrueX�5/     *9  $DevExpress.Xpf.Editors.PopupBaseEdits 9  IsPopupOpens . t J� RenderTransformOrigin$t 0.691,0.636&�6.    5#     �� *Parameters.AccountName+$ TwoWay=�$i PropertyChanged=�2:  ,DevExpress.Mvvm.UI.Interactivity.Interactionu :  Triggersu 53     ';  !DevExpress.Mvvm.UI.EventToCommand;  54     �<  �DevExpress.Mvvm.UI.Interactivity.EventTriggerBase`1[[System.Windows.DependencyObject, WindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]v <  	EventName$v SelectedIndexChanged��6(   w ;  PassEventArgsToCommand$
w TrueX�6y   +=  %DevExpress.Mvvm.UI.EventToCommandBasex =  Commandx 6I   �� *SelectedIndexChangedCommand+6y   y 6  Items.y 56     ->  'DevExpress.Xpf.Editors.ComboBoxEditItem>  $
��WM01��6#   57     6  5;  
   -   5        $j cmboView��5@  (   $y�Hidden=�5=     $
��Left=�5>     $��	300,4,0,0q�6(   $	��Top=�5?     $	��140��6%   $��Calibri)�61   $��12(�5@     $��20��6    5<     �� $ Parameters.Visibilty�$ TwoWay=�$i PropertyChanged=�.y 5A     >  $
��Grid��6#   >  5B     $��Chart��6#   5D     �� 5E  
   -   5        $��lblColorIndicator��5E  �   $
��Left=�6   $��7��6,   $��	174,4,0,0q�67   $	��Top=�6J   $��21��6b   
��� � �6�   5H     5J     