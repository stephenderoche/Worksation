﻿#pragma checksum "..\..\..\..\View\GuagesView.xaml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "534956DC28FBF3D87D7A4587A70C57024667FC55"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using DevExpress.Xpf.DXBinding;
using DevExpress.Xpf.Gauges;
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


namespace Guages.Client.View {
    
    
    /// <summary>
    /// GuagesView
    /// </summary>
    public partial class GuagesView : System.Windows.Controls.UserControl, System.Windows.Markup.IComponentConnector {
        
        
        #line 16 "..\..\..\..\View\GuagesView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Gauges.CircularGaugeControl GuageRev;
        
        #line default
        #line hidden
        
        
        #line 18 "..\..\..\..\View\GuagesView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Gauges.ArcScale ScaleReverse;
        
        #line default
        #line hidden
        
        
        #line 20 "..\..\..\..\View\GuagesView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Gauges.ArcScaleNeedle needleReverse;
        
        #line default
        #line hidden
        
        
        #line 53 "..\..\..\..\View\GuagesView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Gauges.CircularGaugeControl GuageNotRev;
        
        #line default
        #line hidden
        
        
        #line 55 "..\..\..\..\View\GuagesView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Gauges.ArcScale Scale;
        
        #line default
        #line hidden
        
        
        #line 57 "..\..\..\..\View\GuagesView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal DevExpress.Xpf.Gauges.ArcScaleNeedle needle;
        
        #line default
        #line hidden
        
        
        #line 90 "..\..\..\..\View\GuagesView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Label lblheader1;
        
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
            System.Uri resourceLocater = new System.Uri("/Guages.Client;component/view/guagesview.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\..\View\GuagesView.xaml"
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
            
            #line 8 "..\..\..\..\View\GuagesView.xaml"
            ((Guages.Client.View.GuagesView)(target)).Loaded += new System.Windows.RoutedEventHandler(this.UserControl_Loaded);
            
            #line default
            #line hidden
            return;
            case 2:
            this.GuageRev = ((DevExpress.Xpf.Gauges.CircularGaugeControl)(target));
            return;
            case 3:
            this.ScaleReverse = ((DevExpress.Xpf.Gauges.ArcScale)(target));
            return;
            case 4:
            this.needleReverse = ((DevExpress.Xpf.Gauges.ArcScaleNeedle)(target));
            
            #line 20 "..\..\..\..\View\GuagesView.xaml"
            this.needleReverse.ValueChanged += new DevExpress.Xpf.Gauges.ValueChangedEventHandler(this.needle_ValueChanged);
            
            #line default
            #line hidden
            return;
            case 5:
            this.GuageNotRev = ((DevExpress.Xpf.Gauges.CircularGaugeControl)(target));
            return;
            case 6:
            this.Scale = ((DevExpress.Xpf.Gauges.ArcScale)(target));
            return;
            case 7:
            this.needle = ((DevExpress.Xpf.Gauges.ArcScaleNeedle)(target));
            
            #line 57 "..\..\..\..\View\GuagesView.xaml"
            this.needle.ValueChanged += new DevExpress.Xpf.Gauges.ValueChangedEventHandler(this.needle_ValueChanged);
            
            #line default
            #line hidden
            return;
            case 8:
            this.lblheader1 = ((System.Windows.Controls.Label)(target));
            return;
            }
            this._contentLoaded = true;
        }
    }
}

