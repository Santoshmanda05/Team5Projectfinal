using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Team5Project.Models;

namespace Team5Project.Controllers
{
    public class LoginController : Controller
    {
        // GET: Login
        List<Branch_Admin> blist = null;
        List<Customer_Profile> clist = null;
        static List<Vehicle_details> vlist = null;
        static List<VehicleSearch> vd = null;
        List<Customer_Vehicle_Booking1> cvblist = null;
        static List<Branch_Vehicle_Request> bvrlist = null;

        public ActionResult Login() //to show the login page,goes to login.cshtml
        {
            return View();
        }
        public ActionResult Customer() //to view the customer registration page,goes to customer.cshtml
        {
            Customer_Profile c = new Customer_Profile();
            return View();

        }
        public ActionResult AddCustomer(Customer_Profile c) //after clicking register button,this method is called and "thank you" messsage is displayed if all inputs are correct 
        {
            if(ModelState.IsValid)
            {
                c.Status = "Pending";
                c.Role_Type = "Customer";
                ViewBag.msg = DBOperations.InsertCustomer(c);


                return View("Customer");//displays 'thank you" msg on the same customer.cshtml 
            }


            return View("Customer");


        }
        public ActionResult BranchAdmin() //to view the branch admin registration page,goes to BranchAdmin.cshtml
        {
            Branch_Admin b = new Branch_Admin();
            return View();
        }


        public ActionResult AddBranchAdmin(Branch_Admin b)//after clicking register button,this method is called and "thank you" messsage is displayed if all inputs are correct 
        {
            if (ModelState.IsValid)
                {

                b.Status = "Pending";
                b.Role_Type = "BA";
                ViewBag.msg = DBOperations.InsertBranchAdmin(b);
                return View("BranchAdmin");//displays 'thank you" msg on the same BranchAdmin.cshtml
               }
            return View("BranchAdmin");
        }


        public ActionResult AdminLogin(UserLogin U,string userid, string password)//to check login credentials for all 3 roles
        {
            if (ModelState.IsValid)
            {


                User_Registration l = DBOperations.CheckRegistration(userid, password);

                if (l != null)
                {
                    Session["username"] = l.Userid;
                    if (l.Role_Type == "admin" && l.Status == "Approved")
                    {
                        return RedirectToAction("SuccessfulAdmin");
                    }
                    else if (l.Role_Type == "Customer" && l.Status == "Approved")
                    {
                        return RedirectToAction("SuccessfulCustomer");
                    }
                    else if (l.Role_Type == "BA" && l.Status == "Approved")
                    {
                        return RedirectToAction("SuccessfulBA");
                    }
                    else if (l.Status == "Rejected")
                    {
                        return RedirectToAction("RejectLogin");
                    }
                    else
                    {
                        return View("WrongLogin");
                    }

                }
                else
                {
                    return View("WrongLogin");
                }
            }
            else
            {
                return View("Login");
            }
            

        }
        public ActionResult RejectLogin()//shows reject msg to rejected status people,goes to RejectLogin.cshtml
        {


            return View();
        }
        public ActionResult WrongLogin()//if status is pending or wrong credentials.goes to WrongLogin.cshtml
        {

            return View();
        }

        public ActionResult SuccessfulAdmin()//shows both Customer_Profile and Branch_Admin table records with status=pending and checkbox for admin to approve or reject
        {
            clist = DBOperations.GetAll();
            ViewBag.clist = clist;

            blist = DBOperations.GetallB();
            ViewBag.blist = blist;
            return View();

        }
        [HttpPost]
        public ActionResult SuccessfulAdmin(string submit)//redirecting the two submit buttons to appropritae methods
        {
            switch (submit)
            {
                case "APPROVE":
                    return (AdminApprove());
                case "REJECT":
                    return (AdminReject());
                case "PENDING_REQUESTS":
                    return (AdminPending());
            }
            return View();
        }
        
        public ActionResult AdminPending()
        {
            bvrlist = DBOperations.ShowToAdminFromBA();
            ViewBag.L = bvrlist;
            return View("AdminPending");



        }
        [HttpPost]
        public ActionResult AdminApprove()//on clicking the "approve" button,all selected records will have status now as "approved" and they will be added in User_Registration table
        {



            var cid = Request.Form.Get("chckbox");
            var bid = Request.Form.Get("chckbox1");

            List<User_Registration> ulist = new List<User_Registration>();
            User_Registration U = null;
            clist = DBOperations.GetAll();
            blist = DBOperations.GetallB();


            foreach (var c in clist)
            {
                if (cid.Contains(c.Customer_id.ToString()))
                {
                    c.Status = "Approved";
                    U = new User_Registration();
                    U.Userid = c.Customer_id;
                    U.Password = c.Password;
                    U.Role_Type = c.Role_Type;
                    U.Status = "Approved";
                    U.Create_date = DateTime.Today;
                    ulist.Add(U);
                }
            }


            foreach (var b in blist)
            {
                if (bid.Contains(b.Branch_id.ToString()))
                {
                    b.Status = "Approved";
                    U = new User_Registration();
                    U.Userid = b.Branch_id;
                    U.Password = b.Password;
                    U.Status = "Approved";
                    U.Role_Type = b.Role_Type;
                    U.Create_date = DateTime.Today;
                    ulist.Add(U);
                }
            }

            string mesg = DBOperations.UserRegistration(ulist);
            ViewBag.message = mesg;
            return View("Login");
        }
        [HttpPost]
        public ActionResult AdminReject()//on clicking the "REJECT" button,all selected records will have status now as "rejected" and they will be added in User_Registration table

        {
            var cid = Request.Form.Get("chckbox");
            var bid = Request.Form.Get("chckbox1");

            List<User_Registration> ulist = new List<User_Registration>();
            User_Registration U = null;
            clist = DBOperations.GetAll();
            blist = DBOperations.GetallB();


            foreach (var c in clist)
            {
                if (cid.Contains(c.Customer_id.ToString()))
                {
                    c.Status = "Rejected";
                    U = new User_Registration();
                    U.Userid = c.Customer_id;
                    U.Password = c.Password;
                    U.Role_Type = c.Role_Type;
                    U.Status = "Rejected";
                    U.Create_date = DateTime.Today;
                    ulist.Add(U);
                }
            }

            if (bid != null)
            {
                foreach (var b in blist)
                {
                    if (bid.Contains(b.Branch_id.ToString()))
                    {
                        b.Status = "Rejected";
                        U = new User_Registration();
                        U.Userid = b.Branch_id;
                        U.Password = b.Password;
                        U.Status = "Rejected";
                        U.Role_Type = b.Role_Type;
                        U.Create_date = DateTime.Today;
                        ulist.Add(U);
                    }
                }
            }
            string mesg = DBOperations.UserRegistration(ulist);
            ViewBag.message = mesg;
            return View("Login");

        }
        public ActionResult RequestApprove(Branch_Vehicle_Request bvr)//admin approves the requests of BA
        {
            int novA = int.Parse(Request.Form["txtnovA"]);
            bvr.Status = "Approved";
            string branchid = bvr.Branch_id;
            string bstatus = bvr.Status;
            int novR = (int)bvr.No_Of_Vehicles_Requested;
            string msg = DBOperations.AdminApproveToBA(bstatus, branchid, novA);

            return View("Approvemsg");


        }

        public ActionResult AdminApprovesBA()//after admin selects one radio button,it displays details in textboxes
        {
            string bid = Request.Form["rdb"];
            Branch_Vehicle_Request bvr = DBOperations.ExtractAdmin(bid);
            return View(bvr);

        }
        public ActionResult Approvemsg()//shows the approved msg for admin after successful approval
        {

            return View();
        }




        public ActionResult SuccessfulCustomer()//if userid and password is correct and status is approved, SuccessfulCustomer.cshtml
        {

            return View();

        }

        //[HttpPost]
        //public ActionResult SuccessfulCustomer(string submit)//two submit buttons,one to book vehicle and one to check status
        //{
        //    switch (submit)
        //    {
        //        case "SEARCH":
        //            return (VehicleSearch());
        //        case "STATUS":
        //            return (CustomerStatus());
        //    }
        //    return View();
        //}
        //[HttpPost]
        public ActionResult VehicleSearch()//shows search criteria with drop downs
        {
            blist = DBOperations.GetallBr();
            ViewBag.b = blist;

            vlist = DBOperations.getvehdetails();
            ViewBag.m = vlist;
            return View("VehicleSearch");
        }
        
        public ActionResult CustomerStatus()
        {
            string cid = Session["username"].ToString();
            cvblist = DBOperations.ShowStatus(cid);
            ViewBag.L = cvblist;

            return View("CustomerStatus");
        }


        public ActionResult SuccessfulBA()
        {


            return View();
        }
        //[HttpPost]
        //public ActionResult SuccessfulBA(string submit)
        //{
        //    switch (submit)
        //    {
        //        case "APPROVE":
        //            return (ShowToBA());
        //        case "REQUEST":
        //            return (RequestAdmin());
        //        case "CHECK":
        //            return (BAcheck());
        //    }
        //    return View();

        //}
        //[HttpPost]
        public ActionResult BAcheck()
        {
            string bid = Session["username"].ToString();
            bvrlist = DBOperations.GetALLBVR(bid);
            ViewBag.L = bvrlist;

            return View("BAcheck");
        }
       
        public ActionResult RequestAdmin()//showing vehicle_details to BA and making request
        {
            vlist = DBOperations.getvehdetails();
            ViewBag.L = vlist;
            return View("RequestAdmin");
        }
        
        public ActionResult ShowToBA()//showing pending records to branch admin
        {
            cvblist = DBOperations.ShowTOBranchAdmin();
            ViewBag.L = cvblist;
            return View("ShowToBA");
        }


        public ActionResult AddToRequestTable(Vehicle_details vd)//adding the selected records to Branch_Vehicle_Request table
        {
            Branch_Vehicle_Request bvr = null;
            List<Branch_Vehicle_Request> bvlist = new List<Branch_Vehicle_Request>();
            bvr = new Branch_Vehicle_Request();


            string vid = vd.Vehicle_Code;
            string bid = Session["username"].ToString();
            string status = "Pending";
            int novR = int.Parse(Request.Form["txtnovR"]);
            int novA = 0;
            bvr.As_On_Date = DateTime.Today;
            bvr.Vehicle_id = vid;
            bvr.Branch_id = bid;
            bvr.Status = status;
            bvr.No_Of_Vehicles_Requested = novR;
            bvr.No_Of_Vehicles_Approved = novA;
            bvlist.Add(bvr);

            string res = DBOperations.GotoAdmin(bvlist);

            ViewBag.msg = res;
            return View("SuccessfulBA");


        }
        public ActionResult AddNumberOfVehicles()//after BA selects one radio button,it should display that in textboxes
        {
            string vid = Request.Form["rdb"];
            Vehicle_details vd1 = DBOperations.ExtractBranchAdminRequest(vid);


            return View(vd1);
        }


        public ActionResult SearchVehicleResults()//searching based on selected criteria and shows a view WITH A table with checkboxes
        {

            string s = null;
            string m = Request.Form["ddlmname"].ToString();
            if (Request.Form["ddlmname"].ToString() != "")
            {
                s = " Manufactures_name='" + Request.Form["ddlmname"].ToString() + "'";
            }

            if (Request.Form["ddlvcode"].ToString() != "")
            {
                if (s == null)
                    s = " Vehicle_Code='" + Request.Form["ddlvcode"].ToString() + "'";
                else
                    s = s + " or Vehicle_Code='" + Request.Form["ddlvcode"].ToString() + "'";
            }
            if (Request.Form["ddlbloc"].ToString() != "")
            {
                if (s == null)
                    s = " Branch_Location='" + Request.Form["ddlbloc"].ToString() + "'";
                else
                    s = s + " or Branch_Location='" + Request.Form["ddlbloc"].ToString() + "'";
            }



            if (Request.Form["MinPrice"].ToString().Length != 0 && Request.Form["MaxPrice"].ToString().Length != 0)
            {
                if (s == null)
                {
                    s = " PriceRange between " + int.Parse(Request.Form["MinPrice"].ToString()) + " and " + int.Parse(Request.Form["MaxPrice"].ToString());
                }
                else
                {
                    s = s + " or PriceRange between " + int.Parse(Request.Form["MinPrice"].ToString()) + " and " + int.Parse(Request.Form["MaxPrice"].ToString());
                }
            }
            if (Request.Form["ddlcolor"].ToString() != "")
            {
                if (s == null)
                    s = " Color='" + Request.Form["ddlcolor"].ToString() + "'";
                else
                    s = s + " or Color='" + Request.Form["ddlcolor"].ToString() + "'";
            }
            if (Request.Form["ddlcapacity"].ToString() != "")
            {
                if (s == null)
                    s = " Seating_Capacity='" + Request.Form["ddlcapacity"].ToString() + "'";
                else
                    s = s + " or Seating_Capacity='" + Request.Form["ddlcapacity"].ToString() + "'";
            }

            ViewBag.L = DBOperations.GetSearch(s);

            return View();

        }
        public ActionResult VehicleBooking(string[] chk)//send the selected checkbox data to view
        {
            vd = DBOperations.getvehiclelist(chk);
            return View(vd);
        }
        public ActionResult GoToBA()//adding the confirmed selected records to Customer_Vehicle_Booking table with status as pending
        {

            Customer_Vehicle_Booking1 cvb1 = new Customer_Vehicle_Booking1();
            cvb1.Status = "Pending";
            string status = cvb1.Status;
            string cid = Session["username"].ToString();
            string res = DBOperations.GoToBAdmin(vd, cid, status);

            ViewBag.msg = res;
            return View("SuccessfulCustomer");
        }

        public ActionResult BAApprove()//approving by BA
        {
            var bookingID = Request.Form.Get("chckboxBA");


            List<Customer_Vehicle_Booking1> cvblist1 = new List<Customer_Vehicle_Booking1>();
            Customer_Vehicle_Booking1 cb = null;
            cvblist = DBOperations.ShowTOBranchAdmin();



            foreach (var c in cvblist)
            {

                if (bookingID.Contains(c.Booking_id.ToString()))
                {

                    c.Status = "Approved";
                    string cstatus = c.Status;
                    int bookingid = c.Booking_id;
                    DBOperations.BAapprove(cstatus, bookingid);

                    // d.No_of_Vehicles_Available = d.No_of_Vehicles_Available - 1;




                }
            }


            return View("SuccessfulBA");





        }

    }
}

