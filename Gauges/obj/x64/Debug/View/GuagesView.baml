   M S B A M L   `   `   `  ����  Guages.Client#    Guages.Client.View.GuagesView   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35a ]DevExpress.Xpf.Core.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49aW SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   c _DevExpress.Xpf.Gauges.v17.2, Version=17.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a?dxga4http://schemas.devexpress.com/winfx/2008/xaml/gauges  5   	   -   5        
�������$
��Left=�5
      $
��Left=�62   $��Calibri)�6T   $
��auto��6i   $
��auto��6v   .��5      � .+�5   
   0  *DevExpress.Xpf.Gauges.CircularGaugeControl  -   5        $��GuageRev��5   L   $��0,25,0,0q�6$   ���#165c56    Scales  5      $  DevExpress.Xpf.Gauges.ArcScale  5      -   5        $��ScaleReverse��5          Needles 5      *  $DevExpress.Xpf.Gauges.ArcScaleNeedle  5      -   5        needleReverse��.  (DevExpress.Xpf.Gauges.ValueIndicatorBase   IsInteractive .    Value 5   E   ��  �� Path$ Parameters.Count� �� Mode$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�   	Animation 5      .  (DevExpress.Xpf.Gauges.IndicatorAnimation  5   "   5         Ranges 5      )  #DevExpress.Xpf.Gauges.ArcScaleRange  5      %  DevExpress.Xpf.Gauges.RangeBase	   EndValue/  )DevExpress.Xpf.Gauges.RangeValueConverter$		 20% 6-   
   Presentation
 5      <	  6DevExpress.Xpf.Gauges.DefaultArcScaleRangePresentation	  5   "   ?
  9DevExpress.Xpf.Gauges.PredefinedArcScaleRangePresentation 
  Fill
 �  ��6H   5        5       $		 80% 6-      
StartValue$	 20% 6<   
 5!      	  5"   "   
 � ���6H   5$        5%      $
	 100% 6-   $	 80% 6=   
 5&      	  5'   "   
 � � �6H   5)         Layers 5+      )  #DevExpress.Xpf.Gauges.ArcScaleLayer  5,      5.         Model 50      0  *DevExpress.Xpf.Gauges.CircularClassicModel  51      53        55   
   -   5        $��GuageNotRev��55   _   $��0,25,0,0q�6$   ���#165c56$y�Hidden=�6K     56        57      -   5        $��Scale��57        58        59      -   5        
needle�� .  59   >   �� $ Parameters.Count�$ TwoWay=�$ PropertyChanged=� 5:        5;   "   5=       5?        5@      $		 20% 6-   
 5A      	  5B   "   
 � � �6H   5D        5E      $		 80% 6-   $	 20% 6<   
 5F      	  5G   "   
 � ���6H   5I        5J      $
	 100% 6-   $	 80% 6=   
 5K      	  5L   "   
 �  ��6H   5N       5P        5Q      5S       5U        5V      5X      �� 5Z   
   -   5         ��Name$ 
lblheader1��5Z     $��Center=�6q   $��Center=�6�   $	��Top=�6�   $��Calibri Black)�6�   $��18(�6�   
���   �$
��auto��6  $��0��6)  $��0,0,0,0q�69  $
��Bold"�6J  ��6   �� $ Parameters.GuageType�$ TwoWay=�$ PropertyChanged=�6J  5]      5_      