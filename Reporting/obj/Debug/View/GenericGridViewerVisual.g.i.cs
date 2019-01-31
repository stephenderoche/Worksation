﻿#pragma checksum "..\..\..\View\GenericGridViewerVisual.xaml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "9BEDB59F1894E16F283B67F354D495942457A442"
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
using Reporting.Client;
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


namespace Reporting.Client.View {
    
    
    /// <summary>
    /// GenericGridViewerVisual
    /// </summary>
    public partial class GenericGridViewerVisual : System.Windows.Controls.UserControl, System.Windows.Markup.IComponentConnector {
        
        
        #line 73 "..\..\..\View\GenericGridViewerVisual.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.GridSplitter lblborder;
        
        #line default
        #line hidden
        
        
        #line 75 "..\..\..\View\GenericGridViewerVisual.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Label lblheader;
        
        #line default
        #line hidden
        
        
        #line 81 "..\..\..\View\GenericGridViewerVisual.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Grid.GridControl _dataGrid;
        
        #line default
        #line hidden
        
        
        #line 92 "..\..\..\View\GenericGridViewerVisual.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Grid.TableView viewRoboDrift;
        
        #line default
        #line hidden
        
        
        #line 144 "..\..\..\View\GenericGridViewerVisual.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Editors.DateEdit txtenddate;
        
        #line default
        #line hidden
        
        
        #line 146 "..\..\..\View\GenericGridViewerVisual.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Editors.DateEdit txtstartdate;
        
        #line default
        #line hidden
        
        
        #line 150 "..\..\..\View\GenericGridViewerVisual.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Editors.ComboBoxEdit comboBoxEdit1;
        
        #line default
        #line hidden
        
        
        #line 173 "..\..\..\View\GenericGridViewerVisual.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ComboBox cmboDesk;
        
        #line default
        #line hidden
        
        
        #line 181 "..\..\..\View\GenericGridViewerVisual.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Editors.ComboBoxEdit SecurityComboBoxEdit;
        
        #line default
        #line hidden
        
        
        #line 203 "..\..\..\View\GenericGridViewerVisual.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ComboBox cmboReport;
        
        #line default
        #line hidden
        
        
        #line 211 "..\..\..\View\GenericGridViewerVisual.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox BlockID;
        
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
            System.Uri resourceLocater = new System.Uri("/GenericGrid.Client;component/view/genericgridviewervisual.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\View\GenericGridViewerVisual.xaml"
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
            
            #line 14 "..\..\..\View\GenericGridViewerVisual.xaml"
            ((Reporting.Client.View.GenericGridViewerVisual)(target)).Loaded += new System.Windows.RoutedEventHandler(this.UserControl_Loaded);
            
            #line default
            #line hidden
            return;
            case 2:
            this.lblborder = ((System.Windows.Controls.GridSplitter)(target));
            return;
            case 3:
            this.lblheader = ((System.Windows.Controls.Label)(target));
            
            #line 75 "..\..\..\View\GenericGridViewerVisual.xaml"
            this.lblheader.MouseDoubleClick += new System.Windows.Input.MouseButtonEventHandler(this.lblheader_MouseDoubleClick);
            
            #line default
            #line hidden
            return;
            case 4:
            
            #line 78 "..\..\..\View\GenericGridViewerVisual.xaml"
            ((System.Windows.Controls.Button)(target)).Click += new System.Windows.RoutedEventHandler(this.Button_Click);
            
            #line default
            #line hidden
            return;
            case 5:
            this._dataGrid = ((DevExpress.Xpf.Grid.GridControl)(target));
            return;
            case 6:
            this.viewRoboDrift = ((DevExpress.Xpf.Grid.TableView)(target));
            
            #line 99 "..\..\..\View\GenericGridViewerVisual.xaml"
            this.viewRoboDrift.ShowGridMenu += new DevExpress.Xpf.Grid.GridMenuEventHandler(this.OnShowGridMenu);
            
            #line default
            #line hidden
            
            #line 102 "..\..\..\View\GenericGridViewerVisual.xaml"
            this.viewRoboDrift.CustomRowAppearance += new System.EventHandler<DevExpress.Xpf.Grid.CustomRowAppearanceEventArgs>(this.viewAccountTax_CustomRowAppearance);
            
            #line default
            #line hidden
            
            #line 103 "..\..\..\View\GenericGridViewerVisual.xaml"
            this.viewRoboDrift.CustomCellAppearance += new System.EventHandler<DevExpress.Xpf.Grid.CustomCellAppearanceEventArgs>(this.viewAccountTax_CustomCellAppearance);
            
            #line default
            #line hidden
            return;
            case 7:
            
            #line 142 "..\..\..\View\GenericGridViewerVisual.xaml"
            ((DevExpress.Xpf.Core.SimpleButton)(target)).Click += new System.Windows.RoutedEventHandler(this.SimpleButton_Click);
            
            #line default
            #line hidden
            return;
            case 8:
            this.txtenddate = ((DevExpress.Xpf.Editors.DateEdit)(target));
            
            #line 144 "..\..\..\View\GenericGridViewerVisual.xaml"
            this.txtenddate.EditValueChanged += new DevExpress.Xpf.Editors.EditValueChangedEventHandler(this.start_EditValueChanged);
            
            #line default
            #line hidden
            return;
            case 9:
            this.txtstartdate = ((DevExpress.Xpf.Editors.DateEdit)(target));
            
            #line 146 "..\..\..\View\GenericGridViewerVisual.xaml"
            this.txtstartdate.EditValueChanged += new DevExpress.Xpf.Editors.EditValueChangedEventHandler(this.end_EditValueChanged);
            
            #line default
            #line hidden
            return;
            case 10:
            this.comboBoxEdit1 = ((DevExpress.Xpf.Editors.ComboBoxEdit)(target));
            
            #line 153 "..\..\..\View\GenericGridViewerVisual.xaml"
            this.comboBoxEdit1.EditValueChanged += new DevExpress.Xpf.Editors.EditValueChangedEventHandler(this.comboBoxEdit1_EditValueChanged);
            
            #line default
            #line hidden
            
            #line 161 "..\..\..\View\GenericGridViewerVisual.xaml"
            this.comboBoxEdit1.LostFocus += new System.Windows.RoutedEventHandler(this.comboBoxEdit1_LostFocus);
            
            #line default
            #line hidden
            return;
            case 11:
            this.cmboDesk = ((System.Windows.Controls.ComboBox)(target));
            
            #line 173 "..\..\..\View\GenericGridViewerVisual.xaml"
            this.cmboDesk.SelectionChanged += new System.Windows.Controls.SelectionChangedEventHandler(this.cmboDesk_SelectedIndexChanged);
            
            #line default
            #line hidden
            return;
            case 12:
            this.SecurityComboBoxEdit = ((DevExpress.Xpf.Editors.ComboBoxEdit)(target));
            
            #line 191 "..\..\..\View\GenericGridViewerVisual.xaml"
            this.SecurityComboBoxEdit.LostFocus += new System.Windows.RoutedEventHandler(this.SecurityComboBoxEdit_LostFocus_1);
            
            #line default
            #line hidden
            
            #line 191 "..\..\..\View\GenericGridViewerVisual.xaml"
            this.SecurityComboBoxEdit.EditValueChanged += new DevExpress.Xpf.Editors.EditValueChangedEventHandler(this.SecurityComboBoxEdit_EditValueChanged_1);
            
            #line default
            #line hidden
            return;
            case 13:
            this.cmboReport = ((System.Windows.Controls.ComboBox)(target));
            
            #line 203 "..\..\..\View\GenericGridViewerVisual.xaml"
            this.cmboReport.SelectionChanged += new System.Windows.Controls.SelectionChangedEventHandler(this.cmboReport_SelectedIndexChanged);
            
            #line default
            #line hidden
            return;
            case 14:
            this.BlockID = ((System.Windows.Controls.TextBox)(target));
            return;
            case 15:
            
            #line 212 "..\..\..\View\GenericGridViewerVisual.xaml"
            ((DevExpress.Xpf.Core.SimpleButton)(target)).Click += new System.Windows.RoutedEventHandler(this.UpdateButton_Click);
            
            #line default
            #line hidden
            return;
            case 16:
            
            #line 213 "..\..\..\View\GenericGridViewerVisual.xaml"
            ((DevExpress.Xpf.Core.SimpleButton)(target)).Click += new System.Windows.RoutedEventHandler(this.SaveButton_Click);
            
            #line default
            #line hidden
            return;
            }
            this._contentLoaded = true;
        }
    }
}

