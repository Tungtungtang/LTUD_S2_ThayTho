using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WFQLATM
{
    public partial class FormMain1 : Form
    {
        public FormMain1()
        {
            InitializeComponent();
        }


        private void btnlogin_Click(object sender, EventArgs e)
        {
            formadmin2 frmadmin = new formadmin2();
            frmadmin.Show();
        }

        private void txttaikhoan_Leave(object sender, EventArgs e)
        {
            Control ctr = (Control)sender;
            if (ctr.Text.Trim().Length == 0)
                this.errorProvider1.SetError(txttaikhoan, "You must enter Your name");
            else
                this.errorProvider1.Clear();
        }

        private void txtmatkhau_Leave(object sender, EventArgs e)
        {
            Control ctr = (Control)sender;
            if (ctr.Text.Trim().Length == 0)
                this.errorProvider1.SetError(txtmatkhau, "You must enter Your name");
            else
                this.errorProvider1.Clear();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void FormMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult r;
            r = MessageBox.Show("Do you want to close?", "Exit",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Question,
                MessageBoxDefaultButton.Button1);
            if (r == DialogResult.No)
                e.Cancel = true;
        }
        private void exitmeuStrip_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void exitcontextMenuStrip_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
