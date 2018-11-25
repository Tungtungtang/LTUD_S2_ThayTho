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
    public partial class formaddNV : Form
    {
        public formaddNV()
        {
            InitializeComponent();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void formaddNV_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult r;
            r = MessageBox.Show("Do you want to close?", "Exit",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Question,
                MessageBoxDefaultButton.Button1);
            if (r == DialogResult.No)
                e.Cancel = true;
        }

        private void txtMaNV_Leave(object sender, EventArgs e)
        {
            Control ctr = (Control)sender;
            if (ctr.Text.Trim().Length == 0)
                this.errorProvider1.SetError(txtMaNV, "You must enter Your name");
            else
                this.errorProvider1.Clear();
        }

        private void txtHoTen_Leave(object sender, EventArgs e)
        {
            Control ctr = (Control)sender;
            if (ctr.Text.Trim().Length == 0)
                this.errorProvider1.SetError(txtHoTen, "You must enter Your name");
            else
                this.errorProvider1.Clear();
        }

        private void txtDiaChi_Leave(object sender, EventArgs e)
        {
            Control ctr = (Control)sender;
            if (ctr.Text.Trim().Length == 0)
                this.errorProvider1.SetError(txtDiaChi, "You must enter Your name");
            else
                this.errorProvider1.Clear();
        }

        private void txtSDT_TextChanged(object sender, EventArgs e)
        {
            Control ctr = (Control)sender;
            if (ctr.Text.Trim().Length > 0 && !char.IsDigit(ctr.Text, ctr.Text.Length - 1))
                this.errorProvider1.SetError(txtSDT, "This is not invalid number");
            else
                this.errorProvider1.Clear();
        }

        private void txtMCV_Leave(object sender, EventArgs e)
        {
            Control ctr = (Control)sender;
            if (ctr.Text.Trim().Length == 0)
                this.errorProvider1.SetError(txtDiaChi, "You must enter Your name");
            else
                this.errorProvider1.Clear();
        }

        private void txtMM_Leave(object sender, EventArgs e)
        {
            Control ctr = (Control)sender;
            if (ctr.Text.Trim().Length == 0)
                this.errorProvider1.SetError(txtDiaChi, "You must enter Your name");
            else
                this.errorProvider1.Clear();
        }

        private void toolStripMenuItem2_Click(object sender, EventArgs e)
        {
            FormNV frmadm = new FormNV();
            frmadm.Show();
            this.Close();
        }

        private void turnBackPageLoginToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormMain1 frmM = new FormMain1();
            frmM.Show();
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
