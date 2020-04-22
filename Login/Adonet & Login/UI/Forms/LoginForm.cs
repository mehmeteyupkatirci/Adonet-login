using BusinessLayer.Repository.Concrete;
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
    public partial class LoginForm : Form
    {
        UserConcreteObject userService = new UserConcreteObject();
        public LoginForm()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            var result = userService.Login(textBox1.Text, textBox2.Text);

            if(result == -1)
            {
                MessageBox.Show("Kullanıcı adına ait şifre doğrulanamadı!!!");
            }
            else if (result == 0)
            {
                MessageBox.Show("Kullanıcı adını ve şifreyi kontrol ediniz!!");
            }
            else if(result == 1)
            {
                //check if the user is valideted
                ProductForm productForm = new ProductForm();
                productForm.MdiParent = this.MdiParent;
                productForm.Dock = DockStyle.Fill;
                productForm.Show();
                this.Close();
            }
            else
            {
                MessageBox.Show("Beklenmedik Hata!!!!!"); 
            }
           
        }
    }
}
