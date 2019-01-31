
using System.Windows;

using SpreadSheetWidget.Client.Model;

namespace SpreadSheetWidget.Client.View
{
    /// <summary>
    /// Interaction logic for NavDashboardSettingVisual.xaml
    /// </summary>
    public partial class SpreadSheetWidgetSettingVisual : Window
    {

        SpreadSheetWidgetViewModel _viewModel;
        SpreadSheetWidgetVisual _view;

        public SpreadSheetWidgetSettingVisual(SpreadSheetWidgetViewModel ViewModel, SpreadSheetWidgetVisual View)
        {
            InitializeComponent();
            this.DataContext = ViewModel;
            this._view = View;
            this._viewModel = ViewModel;

            this.txtXml.Text = _viewModel._ViewerModel.Parameters.XML;

          
        }

        private void Window_Unloaded(object sender, RoutedEventArgs e)
        {
           
            _viewModel._ViewerModel.Parameters.XML = this.txtXml.Text;
        }

       
    }
}
