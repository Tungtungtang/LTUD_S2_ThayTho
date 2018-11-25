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
    public partial class formadmin2 : Form
    {
        public formadmin2()
        {
            InitializeComponent();
        }
        private void btnqlnv_Click(object sender, EventArgs e)
        {
            FormNV frmNV = new FormNV();
            frmNV.Show();
        }

        private void btnqlkh_Click(object sender, EventArgs e)
        {
            FormKH frmKH = new FormKH();
            frmKH.Show();
        }

        private void btnqlatm_Click(object sender, EventArgs e)
        {
            FormqlATM frmATM = new FormqlATM();
            frmATM.Show();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void formadmin_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult r;
            r = MessageBox.Show("Do you want to close?", "Exit",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Question,
                MessageBoxDefaultButton.Button1);
            if (r == DialogResult.No)
                e.Cancel = true;
        }

        private void QLNV_Click(object sender, EventArgs e)
        {
            FormNV frmNV = new FormNV();
            frmNV.Show();
        }

        private void QLKH_Click(object sender, EventArgs e)
        {
            FormKH frmKH = new FormKH();
            frmKH.Show();
        }

        private void QLMATM_Click(object sender, EventArgs e)
        {
            FormqlATM frmATM = new FormqlATM();
            frmATM.Show();
        }
        private void ExitMN_Click(object sender, EventArgs e)
        {
            this.Close();
        }

    }
}
