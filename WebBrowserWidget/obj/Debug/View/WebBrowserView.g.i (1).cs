﻿#pragma checksum "..\..\..\View\WebBrowserView.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "AD07B61D508DF27C5FCF166AC90F9E34"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using Linedata.Framework.Client.TestWebBrowserWidget.Helpers;
using Linedata.Framework.Client.TestWebBrowserWidget.Resources;
using Linedata.Framework.WidgetFrame.ThemesAndStyles;
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


namespace Linedata.Framework.Client.TestWebBrowserWidget.View {
    
    
    /// <summary>
    /// WebBrowserView
    /// </summary>
    public partial class WebBrowserView : System.Windows.Controls.UserControl, System.Windows.Markup.IComponentConnector {
        
        
        #line 91 "..\..\..\View\WebBrowserView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBlock TitleNameTextBlock;
        
        #line default
        #line hidden
        
        
        #line 108 "..\..\..\View\WebBrowserView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Grid SettingGrid;
        
        #line default
        #line hidden
        
        
        #line 152 "..\..\..\View\WebBrowserView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.WebBrowser webBrowser;
        
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
            System.Uri resourceLocater = new System.Uri("/Linedata.Framework.Client.TestWebBrowserWidget;component/view/webbrowserview.xam" +
                    "l", System.UriKind.Relative);
            
            #line 1 "..\..\..\View\WebBrowserView.xaml"
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
            
            #line 82 "..\..\..\View\WebBrowserView.xaml"
            ((System.Windows.Controls.Grid)(target)).MouseLeftButtonUp += new System.Windows.Input.MouseButtonEventHandler(this.OnMouseLeftButtonUp);
            
            #line default
            #line hidden
            return;
            case 2:
            this.TitleNameTextBlock = ((System.Windows.Controls.TextBlock)(target));
            
            #line 93 "..\..\..\View\WebBrowserView.xaml"
            this.TitleNameTextBlock.MouseEnter += new System.Windows.Input.MouseEventHandler(this.OnTitleMouseEnter);
            
            #line default
            #line hidden
            return;
            case 3:
            this.SettingGrid = ((System.Windows.Controls.Grid)(target));
            return;
            case 4:
            this.webBrowser = ((System.Windows.Controls.WebBrowser)(target));
            
            #line 157 "..\..\..\View\WebBrowserView.xaml"
            this.webBrowser.LoadCompleted += new System.Windows.Navigation.LoadCompletedEventHandler(this.OnEndNavigating);
            
            #line default
            #line hidden
            
            #line 158 "..\..\..\View\WebBrowserView.xaml"
            this.webBrowser.Navigating += new System.Windows.Navigation.NavigatingCancelEventHandler(this.OnBeginNavigating);
            
            #line default
            #line hidden
            
            #line 159 "..\..\..\View\WebBrowserView.xaml"
            this.webBrowser.Navigated += new System.Windows.Navigation.NavigatedEventHandler(this.OnNavigated);
            
            #line default
            #line hidden
            return;
            }
            this._contentLoaded = true;
        }
    }
}

