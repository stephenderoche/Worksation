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
using CurrentOrders.Client.ViewModel;
using CurrentOrders.Client.View;

using CurrentOrders.Client;
using CurrentOrders.Client.Model;

namespace CurrentOrders.Client.View
{
    /// <summary>
    /// Interaction logic for NavDashboardSettingVisual.xaml
    /// </summary>
    public partial class CurrentOrdersSettingVisual : Window
    {

        CurrentOrdersViewerSettingsViewModel _viewModel;
        CurrentOrdersViewerVisual _view;

        public CurrentOrdersSettingVisual(CurrentOrdersViewerSettingsViewModel ViewModel, CurrentOrdersViewerVisual View)
        {
            InitializeComponent();
            this.DataContext = ViewModel;
            this._view = View;
            this._viewModel = ViewModel;

          
        }

       
    }
}
