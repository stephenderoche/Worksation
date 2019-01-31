using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using BlotterView.Client.ViewModel;
using BlotterView.Client.View;

using BlotterView.Client;
using BlotterView.Client.Model;

namespace BlotterView.Client.View
{
    /// <summary>
    /// Interaction logic for NavDashboardSettingVisual.xaml
    /// </summary>
    public partial class BlotterViewSettingVisual : Window
    {

        BlotterViewSettingsViewModel _viewModel;
        BlotterViewVisual _view;

        public BlotterViewSettingVisual(BlotterViewSettingsViewModel ViewModel, BlotterViewVisual View)
        {
            InitializeComponent();
            this.DataContext = ViewModel;
            this._view = View;
            this._viewModel = ViewModel;

          
        }

       
    }
}
