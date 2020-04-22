using BusinessLayer.Repository.Concrete;
using DataLayer;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace UI.Forms
{
    public partial class ProductForm : Form
    {
        public ProductForm()
        {
            InitializeComponent();
        }
        ProductConcreteObject pco = new ProductConcreteObject();
        Product product = new Product();
        private void ProductForm_Load(object sender, EventArgs e)
        {
           
        }
        private void LoadProduct()
        {
            dgvProduct.DataSource = pco.GetAll();
            dgvProduct.Refresh();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            product.ProductName = txtProductName.Text;
            product.Price = Convert.ToInt32( txtPrice.Text.Trim());
            product.Stock = Convert.ToInt32( txtStock.Text.Trim());
            pco.Create(product);
            LoadProduct();
        }

        private void btnSil_Click(object sender, EventArgs e)
        {
            DialogResult result = MessageBox.Show("Silmek istediğinizden emin misiniz?", "Onay", MessageBoxButtons.YesNoCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button3);
            if (result == DialogResult.Yes)
            {
                
                pco.Delete(Convert.ToInt32(txtId.Text));
                LoadProduct();
            }
            
        }

        private void dgvProduct_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
            DataGridViewRow selectedRow = dgvProduct.Rows[e.RowIndex];
            if (txtId.Text == null)
            {
                MessageBox.Show("Lütfen NULL olmayan bir değer seçiniz");
            }
            else
            {
                txtId.Text = selectedRow.Cells["Id"].Value.ToString();
            }
            txtProductName.Text= selectedRow.Cells["ProductName"].Value.ToString();
            txtPrice.Text = selectedRow.Cells["Price"].Value.ToString();
            txtStock.Text = selectedRow.Cells["Stock"].Value.ToString();
            
        }

        private void btnGet_Click(object sender, EventArgs e)
        {
            LoadProduct();
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            product.Id = Convert.ToInt32(txtId.Text);
            product.ProductName = txtProductName.Text;
            product.Price = Convert.ToInt32(txtPrice.Text);
            product.Stock = Convert.ToInt32(txtStock.Text);
            pco.Update(product);
            LoadProduct();
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }
    }
}
