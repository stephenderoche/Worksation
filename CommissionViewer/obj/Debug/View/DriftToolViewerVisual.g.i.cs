﻿#pragma checksum "..\..\..\View\DriftToolViewerVisual.xaml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "46FEECD7CCFA0AC2849225FCE5569C7E3E0419B4"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using CurrentOrders.Client;
using DevExpress.Core;
using DevExpress.Mvvm;
using DevExpress.Mvvm.UI;
using DevExpress.Mvvm.UI.Interactivity;
using DevExpress.Mvvm.UI.ModuleInjection;
using DevExpress.Xpf.Core;
using DevExpress.Xpf.Core.ConditionalFormatting;
using DevExpress.Xpf.Core.DataSources;
using DevExpress.Xpf.Core.Serialization;
using DevExpress.Xpf.Core.ServerMode;
using DevExpress.Xpf.DXBinding;
using DevExpress.Xpf.Editors;
using DevExpress.Xpf.Editors.DataPager;
using DevExpress.Xpf.Editors.DateNavigator;
using DevExpress.Xpf.Editors.ExpressionEditor;
using DevExpress.Xpf.Editors.Filtering;
using DevExpress.Xpf.Editors.Flyout;
using DevExpress.Xpf.Editors.Popups;
using DevExpress.Xpf.Editors.Popups.Calendar;
using DevExpress.Xpf.Editors.RangeControl;
using DevExpress.Xpf.Editors.Settings;
using DevExpress.Xpf.Editors.Settings.Extension;
using DevExpress.Xpf.Editors.Validation;
using DevExpress.Xpf.Grid;
using DevExpress.Xpf.Grid.ConditionalFormatting;
using DevExpress.Xpf.Grid.LookUp;
using DevExpress.Xpf.Grid.TreeList;
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
using System.Windows.Interactivity;
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


namespace CurrentOrders.Client.View {
    
    
    /// <summary>
    /// DriftToolViewerVisual
    /// </summary>
    public partial class DriftToolViewerVisual : System.Windows.Controls.UserControl, System.Windows.Markup.IComponentConnector, System.Windows.Markup.IStyleConnector {
        
        
        #line 68 "..\..\..\View\DriftToolViewerVisual.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.GridSplitter lblborder;
        
        #line default
        #line hidden
        
        
        #line 74 "..\..\..\View\DriftToolViewerVisual.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Editors.ComboBoxEdit comboBoxEdit1;
        
        #line default
        #line hidden
        
        
        #line 93 "..\..\..\View\DriftToolViewerVisual.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Grid.GridControl _dataGrid;
        
        #line default
        #line hidden
        
        
        #line 108 "..\..\..\View\DriftToolViewerVisual.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Grid.TableView _viewDataGrid;
        
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
            System.Uri resourceLocater = new System.Uri("/DriftTool.Client;component/view/drifttoolviewervisual.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\View\DriftToolViewerVisual.xaml"
            System.Windows.Application.LoadComponent(this, resourceLocater);
            
            #line default
            #line hidden
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
            
            #line 14 "..\..\..\View\DriftToolViewerVisual.xaml"
            ((CurrentOrders.Client.View.DriftToolViewerVisual)(target)).Loaded += new System.Windows.RoutedEventHandler(this.UserControl_Loaded);
            
            #line default
            #line hidden
            return;
            case 3:
            this.lblborder = ((System.Windows.Controls.GridSplitter)(target));
            return;
            case 4:
            this.comboBoxEdit1 = ((DevExpress.Xpf.Editors.ComboBoxEdit)(target));
            
            #line 77 "..\..\..\View\DriftToolViewerVisual.xaml"
            this.comboBoxEdit1.EditValueChanged += new DevExpress.Xpf.Editors.EditValueChangedEventHandler(this.comboBoxEdit1_EditValueChanged);
            
            #line default
            #line hidden
            
            #line 84 "..\..\..\View\DriftToolViewerVisual.xaml"
            this.comboBoxEdit1.LostFocus += new System.Windows.RoutedEventHandler(this.comboBoxEdit1_LostFocus);
            
            #line default
            #line hidden
            return;
            case 5:
            this._dataGrid = ((DevExpress.Xpf.Grid.GridControl)(target));
            return;
            case 6:
            this._viewDataGrid = ((DevExpress.Xpf.Grid.TableView)(target));
            
            #line 115 "..\..\..\View\DriftToolViewerVisual.xaml"
            this._viewDataGrid.ShowGridMenu += new DevExpress.Xpf.Grid.GridMenuEventHandler(this.OnShowGridMenu);
            
            #line default
            #line hidden
            return;
            case 7:
            
            #line 155 "..\..\..\View\DriftToolViewerVisual.xaml"
            ((System.Windows.Controls.MenuItem)(target)).Click += new System.Windows.RoutedEventHandler(this.OpenReport_Click);
            
            #line default
            #line hidden
            return;
            case 8:
            
            #line 157 "..\..\..\View\DriftToolViewerVisual.xaml"
            ((System.Windows.Controls.MenuItem)(target)).Click += new System.Windows.RoutedEventHandler(this.Rebalance_Click);
            
            #line default
            #line hidden
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
            
            #line 47 "..\..\..\View\DriftToolViewerVisual.xaml"
            ((DevExpress.Xpf.Editors.TextEdit)(target)).LostFocus += new System.Windows.RoutedEventHandler(this.OnRenameEditorLostFocus);
            
            #line default
            #line hidden
            break;
            }
        }
    }
}

