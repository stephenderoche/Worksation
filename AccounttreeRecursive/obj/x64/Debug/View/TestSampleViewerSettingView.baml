   M S B A M L   `   `   `  ����N  JGenericChart.Client, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullk:clr-namespace:Linedata.Client.Widget.TestSampleWidget.View,Linedata.Client.Widget.TestSampleWidget.View  5
      O    ILinedata.Client.Widget.TestSampleWidget.View.TopAccountsViewerSettingView   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35a ]DevExpress.Xpf.Core.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aW SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      f bDevExpress.Xpf.Grid.v17.2.Core, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aa ]DevExpress.Xpf.Grid.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a>dxg2http://schemas.devexpress.com/winfx/2008/xaml/grid   5      c _DevExpress.Xpf.Charts.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a>dxc4http://schemas.devexpress.com/winfx/2008/xaml/charts  5      ?dxe5http://schemas.devexpress.com/winfx/2008/xaml/editors  5	      Flocal:clr-namespace:Linedata.Client.Widget.TestSampleWidget.View  5
      -   5        $��161.717��5   Q   $��305.15��6b   .��5      � $��0,0,2,1q�6   .+�5   
   )  #DevExpress.Xpf.Editors.ComboBoxEdit  -   5           Name$  	cmboView1��5   (   $
��Left=�5      $��
142,10,0,0q�6(   $	��Top=�5      $	��140��6%   $��Calibri)�61   $��12(�5      $��20��6      Items. 5      -  'DevExpress.Xpf.Editors.ComboBoxEditItem  $
��Grid��6#     5      $��Chart��6#   5      �� 5   
   $��Presentation Type:��6   $
��Left=�6-   $��10,8,0,0q�6H   $	��Top=�6Z   $	��109��6r   $��12(�6~   $
��Bold"�6�   �� 5   
   $��
Date Type:��6   $
��Left=�6%   $��	10,45,0,0q�6@   $	��Top=�6S   $	��109��6k   $��12(�6w   $
��Bold"�6�     5   
   -   5        $  cmboDataType��5   (   $
��Left=�5      $��
142,47,0,0q�6(   $	��Top=�5      $	��140��6%   $��Calibri)�61   $��12(�5      $��20��6   . 5        $��Top Accounts��6#     5      $��Top Issuers��6#     5       $��Top Securities��6#     5!      $��	Hierarchy��6#     5"      $��Performance��6#     5#      $��Top Compliance Securities��6#     5$      $��Compliance Breaches��6#     5%      $��VsBenchmark��6#     5&      $��Under Management��6#     5'      $��
Maturities��6#   5)      �� 5+   
   -   5         ��Name$ cmboHierarchy��5,      $
��Left=�6$   $��
142,83,0,0q�6?   $	��top=�6S   $	��140��5-      $��Calibri Black)�6   $��14(�6:   $��20��6H    �� Text 5+      ��  �� Path$ Parameters.Hierarchy� �� Mode$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�5.      �� 5/   
   -   5        $��lblHierarchy��5/   �   $��
Hierarchy:��6   $
��Left=�6%   $��	10,81,0,0q�6@   $	��Top=�6S   $	��109��6k   $��12(�6w   $
��Bold"�6�   6�   52      53      