
using System.Windows;

using CommissionViewer.Client.Model;

namespace CommissionViewer.Client.View
{
    /// <summary>
    /// Interaction logic for NavDashboardSettingVisual.xaml
    /// </summary>
    public partial class CommissionViewerSettingVisual : Window
    {

        CommissionViewerSettingsViewModel _viewModel;
        CommissionViewerVisual _view;

        public CommissionViewerSettingVisual(CommissionViewerSettingsViewModel ViewModel, CommissionViewerVisual View)
        {
            InitializeComponent();
            this.DataContext = ViewModel;
            this._view = View;
            this._viewModel = ViewModel;

            this.txtXml.Text = _viewModel._ViewerModel.Parameters.XML;

          
        }

        private void Window_Unloaded(object sender, RoutedEventArgs e)
        {
            _view.XML = this.txtXml.Text;
            _viewModel._ViewerModel.Parameters.XML = this.txtXml.Text;
        }

       
    }
}
