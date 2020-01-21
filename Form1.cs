using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using CliWrap;

namespace Pat
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
           DialogResult dr =  MessageBox.Show("Are you sure you want to exit the PAT", "EXIT", MessageBoxButtons.YesNo, MessageBoxIcon.Question);

            if (dr == DialogResult.Yes)
            {
                this.Close();
            }
           
        }

        private void button2_Click(object sender, EventArgs e)
        {
            DialogResult dr = MessageBox.Show("Restart?", "Restart", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            if (dr == DialogResult.Yes)
            {
                
                process.StartInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                process.StartInfo.FileName = "cmd.exe";
                process.StartInfo.Arguments = "/C shutdown /r";
                process.Start();

            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            DialogResult dr = MessageBox.Show("Run Main Script?", "Script", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            if(dr == DialogResult.Yes)
            {
                process.StartInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                process.StartInfo.FileName = "cmd.exe";
                process.StartInfo.UseShellExecute = true;
                process.StartInfo.Verb = "runas";
                process.StartInfo.Arguments = "/C start C:\\Users\\%USERNAME%\\Desktop\\PAT\\MS.bat";
                try
                {
                    process.Start();
                }
                catch (Exception)
                {
                    Console.WriteLine("USER CANCLED ERROR");
                }
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            DialogResult dr = MessageBox.Show("Install Chocolatey?", "Chocolatey", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            if (dr == DialogResult.Yes)
            {
                process.StartInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                process.StartInfo.FileName = "cmd.exe";
                process.StartInfo.UseShellExecute = true;
                process.StartInfo.Verb = "runas";
                process.StartInfo.Arguments = "/C start C:\\Users\\%USERNAME%\\Desktop\\PAT\\Backups\\Chocolatey.bat";
                try
                {
                    process.Start();
                }
                catch (Exception)
                {
                    Console.WriteLine("USER CANCLED ERROR");
                }
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            Form2 frm2 = new Form2();
            frm2.Show();
            
        }

        private void button6_Click(object sender, EventArgs e)
        {

            Form3 frm3 = new Form3();
            frm3.Show();

        }
    }
}
