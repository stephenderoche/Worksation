   M S B A M L   `   `   `  ����1  -Linedata.Framework.Client.RoboViewerPublisherM    GLinedata.Framework.Client.RoboViewerPublisher.RoboViewerPublisherVisual   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35a ]DevExpress.Xpf.Core.v16.1, Version=16.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aW SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      ?dxe5http://schemas.devexpress.com/winfx/2008/xaml/editors  5      f bDevExpress.Xpf.Grid.v16.1.Core, Version=16.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aa ]DevExpress.Xpf.Grid.v16.1, Version=16.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a>dxg2http://schemas.devexpress.com/winfx/2008/xaml/grid   5      -   5        $
��auto��5      $
��auto��6-   .��5      � $��Stretch=�6   $
��auto��6'   
�������$
��Auto��6G   $��Stretch=�6U   .+�5   
   %  DevExpress.Xpf.Grid.GridControl  -   5           Name$  	RoboDrift��5      )  #DevExpress.Xpf.Grid.DataControlBase   AutoGenerateColumns$
 None=�5   :   #   EnableSmartColumnsGeneration . $��SemiBold"�5   0      SelectionMode$	 Row=�6F      AllowLiveDataShaping$
 TrueX�6]   $��0,20,0,0q�5      $��Stretch=�6-   !   HorizontalContentAlignment$ Stretch=�6K   9  3DevExpress.Xpf.Grid.DataControlSerializationOptions   AddNewColumns .    RemoveOldColumns .     ItemsSource 5      �� *Table1+	   View	 5      #  DevExpress.Xpf.Grid.TableView  5      -   5        $��viewRoboDrift��5   q   %
   AllowConditionalFormattingMenu
 . &   DevExpress.Xpf.Grid.GridViewBase   ShowGroupPanel .     	AutoWidth .     FormatConditions 5      3  -DevExpress.Xpf.Grid.ColorScaleFormatCondition  5      -  'DevExpress.Xpf.Grid.FormatConditionBase   
Expression$ [Int]��68      PredefinedFormatName$ RedWhiteBlueColorScale��6K   5         Columns. 5      $  DevExpress.Xpf.Grid.GridColumn  $	  DevExpress.Xpf.Grid.BaseColumn 	  Header)
  #DevExpress.Xpf.Core.ObjectConverter$
 Hold
 6    	  Width2  ,DevExpress.Xpf.Grid.GridColumnWidthConverter$ 40 6H   $  DevExpress.Xpf.Grid.ColumnBase   SortMode$ DisplayText=�6S      	FieldName$
 Hold��6j      AllowEditing] YDevExpress.Data.v16.1, Version=16.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a5  /DevExpress.Utils.Design.DefaultBooleanConverter$
 True 6{      Binding 6+   �� *	on_hold+6{     5      $ Account
 6   $ 90 6N   $ DisplayText=�6Y   $ Account��6p    6.   �� *
short_name+6p     5      $ 
Model/Risk
 6   $ 90 6Q   $ DisplayText=�6\   $ Model��6s    61   �� *
model_name+6s     5      $ Sector
 6   $ 75 6O   $ DisplayText=�6Z   $ SectorDrift��6q    6-   �� *sector_drift+6q     5      $ Security
 6   $ 75 6S   $ DisplayText=�6^   $ SecurityDrift��6u    6/   �� *security_drift+6u     5       $ Cash%
 6   $ 50 6F   $ DisplayText=�6Q   $
 Cash��6h    6,   �� *cash+6h     5!      $ Last Rebalance
 6   $ 90 6Y   $ DisplayText=�6d   $ LastRebalance��6{    65   �� *last_rebalance+6{     5"      $ Next Rebalance
 6   $	 110 6Y   $ DisplayText=�6e   $ NextRebalance��6|    65   �� *next_rebalance+6|     5#      $ Orders
 6   $ 60 6Q   $ DisplayText=�6\   $ CurrentOrders��6s    6-   �� *current_orders+6s     5$      $ 
Account id
 6   $	 100 6Q   $ DisplayText=�6]   $ 
account_id��6t    	  Visible .   61   �� *
account_id+6�    � ContextMenu 5&      �� 5'       �� PlacementTarget 6   ��  �� ElementName$ dgModels�� � 	Resources 5(         SimpleSysResources �� 
TargetType �� Property �� Value��%R   &	        �� 5)      " m�6;   .�5*      ��  � ��$ 16(�6;   5+      5,      .@�5-      m� -   5        $��Open Account��5-      #��[  66   $��Arial)�6w   $��12(�6�   m� 5/      -   5        $��	Rebalance��5/      #��[  63   $��Arial)�6w   $��12(�6�   51      54      �� 55   
   -   5         ��Name$ txtAccount1��55   .   $
��Left=�6   $��Arial)�6�   $��14(�6�   $	��100��6�   $��	696,0,0,0q�6�   $��20��6�   $	��Top=�6�   59      5:      