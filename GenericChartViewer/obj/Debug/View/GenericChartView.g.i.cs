﻿#pragma checksum "..\..\..\View\GenericChartView.xaml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "DA1A3D8674EBE4A02E71559FC7F5E1E38149522C"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using DevExpress.Core;
using DevExpress.Mvvm;
using DevExpress.Mvvm.UI;
using DevExpress.Mvvm.UI.Interactivity;
using DevExpress.Mvvm.UI.ModuleInjection;
using DevExpress.Xpf.Charts;
using DevExpress.Xpf.Core;
using DevExpress.Xpf.Core.ConditionalFormatting;
using DevExpress.Xpf.Core.ConditionalFormatting.Native;
using DevExpress.Xpf.Core.DataSources;
using DevExpress.Xpf.Core.Native;
using DevExpress.Xpf.Core.Serialization;
using DevExpress.Xpf.Core.ServerMode;
using DevExpress.Xpf.DXBinding;
using DevExpress.Xpf.Editors;
using DevExpress.Xpf.Editors.DataPager;
using DevExpress.Xpf.Editors.DateNavigator;
using DevExpress.Xpf.Editors.DateNavigator.Controls;
using DevExpress.Xpf.Editors.ExpressionEditor;
using DevExpress.Xpf.Editors.Filtering;
using DevExpress.Xpf.Editors.Flyout;
using DevExpress.Xpf.Editors.Flyout.Native;
using DevExpress.Xpf.Editors.Helpers;
using DevExpress.Xpf.Editors.Internal;
using DevExpress.Xpf.Editors.Popups;
using DevExpress.Xpf.Editors.Popups.Calendar;
using DevExpress.Xpf.Editors.RangeControl;
using DevExpress.Xpf.Editors.RangeControl.Internal;
using DevExpress.Xpf.Editors.Settings;
using DevExpress.Xpf.Editors.Settings.Extension;
using DevExpress.Xpf.Editors.Themes;
using DevExpress.Xpf.Editors.Validation;
using DevExpress.Xpf.Grid;
using DevExpress.Xpf.Grid.ConditionalFormatting;
using DevExpress.Xpf.Grid.LookUp;
using DevExpress.Xpf.Grid.TreeList;
using GenericChart;
using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Automation;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Effects;
using System.Windows.Media.Imaging;
using System.Windows.Media.Media3D;
using System.Windows.Media.TextFormatting;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Shell;


namespace GenericChart {
    
    
    /// <summary>
    /// GenericChartView
    /// </summary>
    public partial class GenericChartView : System.Windows.Controls.UserControl, System.Windows.Markup.IComponentConnector, System.Windows.Markup.IStyleConnector {
        
        
        #line 102 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.ChartControl TopAccountsBar;
        
        #line default
        #line hidden
        
        
        #line 147 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.ChartControl TopIssuers;
        
        #line default
        #line hidden
        
        
        #line 184 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.ChartControl TopSecurities;
        
        #line default
        #line hidden
        
        
        #line 218 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.ChartControl ChartHierarchy;
        
        #line default
        #line hidden
        
        
        #line 232 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.PieSeries2D Series;
        
        #line default
        #line hidden
        
        
        #line 250 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.PieTotalLabel pieTotalLabel;
        
        #line default
        #line hidden
        
        
        #line 308 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.Legend legend;
        
        #line default
        #line hidden
        
        
        #line 331 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.ChartControl ChartPerformance;
        
        #line default
        #line hidden
        
        
        #line 377 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.ChartControl ChartTopCmplSecurities;
        
        #line default
        #line hidden
        
        
        #line 385 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.PieSeries2D AssetAllocationSeries;
        
        #line default
        #line hidden
        
        
        #line 405 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.ChartControl ChartBreachesBySeverity;
        
        #line default
        #line hidden
        
        
        #line 412 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.PieSeries2D ComplianceSeverityChart;
        
        #line default
        #line hidden
        
        
        #line 432 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.ChartControl ChartVsBenchmark;
        
        #line default
        #line hidden
        
        
        #line 490 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.ChartControl AssetUnderBubble;
        
        #line default
        #line hidden
        
        
        #line 514 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.ChartControl ChartMaturities;
        
        #line default
        #line hidden
        
        
        #line 546 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.PointSeries2D test;
        
        #line default
        #line hidden
        
        
        #line 571 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.ChartControl AgedBreaches;
        
        #line default
        #line hidden
        
        
        #line 611 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Charts.ChartControl CashBar;
        
        #line default
        #line hidden
        
        
        #line 652 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Grid.GridControl _dataGrid;
        
        #line default
        #line hidden
        
        
        #line 661 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Grid.TableView _viewDataGrid;
        
        #line default
        #line hidden
        
        
        #line 717 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Label lblheader;
        
        #line default
        #line hidden
        
        
        #line 718 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Label lblhierarchy;
        
        #line default
        #line hidden
        
        
        #line 738 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Editors.ComboBoxEdit comboBoxEdit1;
        
        #line default
        #line hidden
        
        
        #line 765 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Editors.ComboBoxEdit cmboView;
        
        #line default
        #line hidden
        
        
        #line 770 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Label lblColorIndicator;
        
        #line default
        #line hidden
        
        
        #line 773 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Editors.CheckEdit rdoNegitve;
        
        #line default
        #line hidden
        
        
        #line 776 "..\..\..\View\GenericChartView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Editors.CheckEdit rdoPositve;
        
        #line default
        #line hidden
        
        private bool _contentLoaded;
        
        /// <summary>
        /// InitializeComponent
        /// </summary>
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        public void InitializeComponent() {
            if (_contentLoaded) {
                return;
            }
            _contentLoaded = true;
            System.Uri resourceLocater = new System.Uri("/GenericChart;component/view/genericchartview.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\View\GenericChartView.xaml"
            System.Windows.Application.LoadComponent(this, resourceLocater);
            
            #line default
            #line hidden
        }
        
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal System.Delegate _CreateDelegate(System.Type delegateType, string handler) {
            return System.Delegate.CreateDelegate(delegateType, this, handler);
        }
        
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Design", "CA1033:InterfaceMethodsShouldBeCallableByChildTypes")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Maintainability", "CA1502:AvoidExcessiveComplexity")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1800:DoNotCastUnnecessarily")]
        void System.Windows.Markup.IComponentConnector.Connect(int connectionId, object target) {
            switch (connectionId)
            {
            case 1:
            
            #line 23 "..\..\..\View\GenericChartView.xaml"
            ((GenericChart.GenericChartView)(target)).Loaded += new System.Windows.RoutedEventHandler(this.UserControl_Loaded);
            
            #line default
            #line hidden
            return;
            case 3:
            this.TopAccountsBar = ((DevExpress.Xpf.Charts.ChartControl)(target));
            return;
            case 4:
            this.TopIssuers = ((DevExpress.Xpf.Charts.ChartControl)(target));
            return;
            case 5:
            this.TopSecurities = ((DevExpress.Xpf.Charts.ChartControl)(target));
            return;
            case 6:
            this.ChartHierarchy = ((DevExpress.Xpf.Charts.ChartControl)(target));
            return;
            case 7:
            this.Series = ((DevExpress.Xpf.Charts.PieSeries2D)(target));
            return;
            case 8:
            this.pieTotalLabel = ((DevExpress.Xpf.Charts.PieTotalLabel)(target));
            return;
            case 9:
            this.legend = ((DevExpress.Xpf.Charts.Legend)(target));
            return;
            case 10:
            this.ChartPerformance = ((DevExpress.Xpf.Charts.ChartControl)(target));
            return;
            case 11:
            this.ChartTopCmplSecurities = ((DevExpress.Xpf.Charts.ChartControl)(target));
            return;
            case 12:
            this.AssetAllocationSeries = ((DevExpress.Xpf.Charts.PieSeries2D)(target));
            return;
            case 13:
            this.ChartBreachesBySeverity = ((DevExpress.Xpf.Charts.ChartControl)(target));
            return;
            case 14:
            this.ComplianceSeverityChart = ((DevExpress.Xpf.Charts.PieSeries2D)(target));
            return;
            case 15:
            this.ChartVsBenchmark = ((DevExpress.Xpf.Charts.ChartControl)(target));
            return;
            case 16:
            this.AssetUnderBubble = ((DevExpress.Xpf.Charts.ChartControl)(target));
            return;
            case 17:
            this.ChartMaturities = ((DevExpress.Xpf.Charts.ChartControl)(target));
            return;
            case 18:
            this.test = ((DevExpress.Xpf.Charts.PointSeries2D)(target));
            return;
            case 19:
            this.AgedBreaches = ((DevExpress.Xpf.Charts.ChartControl)(target));
            return;
            case 20:
            this.CashBar = ((DevExpress.Xpf.Charts.ChartControl)(target));
            return;
            case 21:
            this._dataGrid = ((DevExpress.Xpf.Grid.GridControl)(target));
            return;
            case 22:
            this._viewDataGrid = ((DevExpress.Xpf.Grid.TableView)(target));
            
            #line 668 "..\..\..\View\GenericChartView.xaml"
            this._viewDataGrid.ShowGridMenu += new DevExpress.Xpf.Grid.GridMenuEventHandler(this.OnShowGridMenu);
            
            #line default
            #line hidden
            return;
            case 23:
            this.lblheader = ((System.Windows.Controls.Label)(target));
            return;
            case 24:
            this.lblhierarchy = ((System.Windows.Controls.Label)(target));
            return;
            case 25:
            this.comboBoxEdit1 = ((DevExpress.Xpf.Editors.ComboBoxEdit)(target));
            
            #line 741 "..\..\..\View\GenericChartView.xaml"
            this.comboBoxEdit1.EditValueChanged += new DevExpress.Xpf.Editors.EditValueChangedEventHandler(this.comboBoxEdit1_EditValueChanged);
            
            #line default
            #line hidden
            
            #line 748 "..\..\..\View\GenericChartView.xaml"
            this.comboBoxEdit1.LostFocus += new System.Windows.RoutedEventHandler(this.comboBoxEdit1_LostFocus_1);
            
            #line default
            #line hidden
            return;
            case 26:
            this.cmboView = ((DevExpress.Xpf.Editors.ComboBoxEdit)(target));
            
            #line 765 "..\..\..\View\GenericChartView.xaml"
            this.cmboView.SelectedIndexChanged += new System.Windows.RoutedEventHandler(this.cmboView_SelectedIndexChanged);
            
            #line default
            #line hidden
            return;
            case 27:
            this.lblColorIndicator = ((System.Windows.Controls.Label)(target));
            return;
            case 28:
            this.rdoNegitve = ((DevExpress.Xpf.Editors.CheckEdit)(target));
            return;
            case 29:
            this.rdoPositve = ((DevExpress.Xpf.Editors.CheckEdit)(target));
            return;
            }
            this._contentLoaded = true;
        }
        
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Design", "CA1033:InterfaceMethodsShouldBeCallableByChildTypes")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1800:DoNotCastUnnecessarily")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Maintainability", "CA1502:AvoidExcessiveComplexity")]
        void System.Windows.Markup.IStyleConnector.Connect(int connectionId, object target) {
            switch (connectionId)
            {
            case 2:
            
            #line 86 "..\..\..\View\GenericChartView.xaml"
            ((DevExpress.Xpf.Editors.TextEdit)(target)).LostFocus += new System.Windows.RoutedEventHandler(this.OnRenameEditorLostFocus);
            
            #line default
            #line hidden
            break;
            }
        }
    }
}

