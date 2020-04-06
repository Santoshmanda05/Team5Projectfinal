using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Team5Project.Models
{
    public class DBOperations
    {

        static Team5ProjectEntities8 v = new Team5ProjectEntities8();
        public static string InsertCustomer(Customer_Profile c) //to insert customer details into Customer_Profile table
        {
            try
            {
                v.Customer_Profile.Add(c);
                v.SaveChanges();

                return "Thank you for registering with us!You can login after your approval.";
            }
            catch(Exception){ }
            return null;
        }
        public static string InsertBranchAdmin(Branch_Admin b)//to insert BranchAdmin details into Branch_Admin table
        {
            try
            {
                v.Branch_Admin.Add(b);
                v.SaveChanges();

                return "Thank you for registering with us!You can login after your approval.";
            }
            catch (Exception) { }
            return null;
        }
        public static List<Customer_Profile> GetAll()//shows all pending records of Customer_Profile table
        {
            var c = from cl in v.Customer_Profile
                    where cl.Status == "Pending"
                    select cl;

            return c.ToList();

        }
        public static List<Branch_Vehicle_Request> GetALLBVR(string bid)
        {
            try
            {
                var b = from bvr in v.Branch_Vehicle_Request
                        where bvr.Branch_id == bid
                        select bvr;

                return b.ToList();
            }
            catch (Exception) { }
            return null;


        }
        public static List<Branch_Admin> GetallB()//shows all pending records of Branch_Admin table
        {
            try
            {
                var b = from bl in v.Branch_Admin
                        where bl.Status == "Pending"
                        select bl;
                return b.ToList();
            }
            catch (Exception) { }
            return null;
        }

        public static User_Registration CheckRegistration(string userid, string password)//to check valid userid n password in User_Registration table
        {
            try
            {
                User_Registration u = new User_Registration();
                var l = from v in v.User_Registration
                        where v.Userid == userid && v.Password == password
                        select v;
                if (l == null)
                {
                    return null;
                }
                else
                    return l.FirstOrDefault();
            }
            catch (Exception) { }
            return null;

        }
        public static string UserRegistration(List<User_Registration> U)
        {
            try
            {
                if (U != null)
                {
                    foreach (var row in U)
                    {
                        if (row.Status != "Pending")
                            v.User_Registration.Add(row);
                    }
                    v.SaveChanges();
                    return "Submitted Successfully";
                }
                else
                    return "Unsucessful";
            }
            catch (Exception) { }
            return null;

        }
        public static List<Branch_Admin> GetallBr()//to get all branch_location in drop down for search
        {
            try
            {
                var b = from bl in v.Branch_Admin
                        select bl;
                return b.ToList();
            }
            catch (Exception) { }
            return null;
        }
        public static List<Vehicle_details> getvehdetails()//to get all vehicle_details data like manfactures name,color etc.. into drop down 
        {
            try
            {
                var veh = from vl in v.Vehicle_details
                          select vl;
                return veh.ToList();
            }
            catch (Exception) { }
            return null;
        }

        public static List<VehicleSearch> GetSearch(string s)//shows all records based on the search criteria selected
        {
            try
            {
                return v.Fn_VehicleSearch(s).ToList();
            }
            catch (Exception) { }
            return null;
        }

        public static string BAapprove(string cstatus, int bookingid)//BA approve customer reuquests
        {
            try
            {
                var b = from cl in v.Customer_Vehicle_Booking1
                        where cl.Booking_id == bookingid
                        select cl;
                Customer_Vehicle_Booking1 cvb = (Customer_Vehicle_Booking1)b.FirstOrDefault();
                cvb.Status = cstatus;
                v.SaveChanges();
                return "APPROVED";
            }
            catch (Exception) { }
            return null;


        }
        public static string AdminApproveToBA(string bstatus, string bid, int novA)//Admin approve requests of BA
        {
            try
            {
                var b = from cl in v.Branch_Vehicle_Request
                        where cl.Branch_id == bid
                        select cl;
                Branch_Vehicle_Request bvr = new Branch_Vehicle_Request();
                foreach (var i in b)
                {
                    i.Status = bstatus;
                    i.No_Of_Vehicles_Approved = novA;
                }
                v.SaveChanges();
                return "APPROVED SUCCESSFULLY";
            }
            catch (Exception) { }
            return null;
        }


        public static List<VehicleSearch> getvehiclelist(string[] id)//shows checked records
        {
            try
            {
                Customer_Vehicle_Booking1 cvb = new Customer_Vehicle_Booking1();
                var e = (from l in v.VehicleSearches
                         where id.Contains(l.Vehicle_Code) == true
                         select l).ToList();
                return e;
            }
            catch (Exception) { }
            return null;
        }


        public static string GoToBAdmin(List<VehicleSearch> vs, string cid, string status)//adding confirmed records to Customer_Vehicle_Booking table
        {
            try
            {
                Customer_Vehicle_Booking1 cvb1 = new Customer_Vehicle_Booking1();
                foreach (var item in vs)
                {
                    cvb1.Branch_Location = item.Branch_Location;
                    cvb1.Vehicle_id = item.Vehicle_Code;
                    cvb1.Customer_id = cid;
                    cvb1.Status = status;
                    v.Customer_Vehicle_Booking1.Add(cvb1);
                    v.SaveChanges();
                }
                return "Thank You for booking! You can see your booking status here!";
            }
            catch (Exception) { }
            return null;
        }
        public static string GotoAdmin(List<Branch_Vehicle_Request> bvlist)//adding to Branch_Vehicle_Request table
        {
            try
            {
                //Branch_Vehicle_Request bvr = new Branch_Vehicle_Request();
                if (bvlist != null)
                {
                    foreach (var row in bvlist)
                    {
                        if (row.Status != "Approved")
                            v.Branch_Vehicle_Request.Add(row);
                    }
                    v.SaveChanges();
                    return "Submitted Successfully";
                }
                else
                    return "Unsucessful";
            }
            catch (Exception) { }
            return null;


            //return "Your Request has been accepted.Contact Admin for further details";
        }
        public static List<Customer_Vehicle_Booking1> ShowStatus(string cid)//showing customer his status
        {
            try
            {
                var cvblist = from c in v.Customer_Vehicle_Booking1
                              where c.Customer_id == cid
                              select c;
                return cvblist.ToList();
            }
            catch (Exception) { }
            return null;


        }
        public static List<Customer_Vehicle_Booking1> ShowTOBranchAdmin()//showing BA the pending records
        {
            try
            {
                var cvblist = from c in v.Customer_Vehicle_Booking1
                              where c.Status == "Pending"
                              select c;
                return cvblist.ToList();
            }
            catch (Exception) { }
            return null;


        }
        public static List<Branch_Vehicle_Request> ShowToAdminFromBA()//showing pending requests from BA to Admin
        {
            try
            {
                var bvrlist = from c in v.Branch_Vehicle_Request
                              where c.Status == "Pending"
                              select c;

                return bvrlist.ToList();
            }
            catch (Exception) { }
            return null;



        }
        public static Vehicle_details ExtractBranchAdminRequest(string vid)
        {
            try
            {
                var b = from bl in v.Vehicle_details
                        where bl.Vehicle_Code == vid
                        select bl;
                return b.First();
            }
            catch (Exception) { }
            return null;
        }
        public static Branch_Vehicle_Request ExtractAdmin(string bid)
        {
            try
            {
                var b = from bl in v.Branch_Vehicle_Request
                        where bl.Branch_id == bid
                        select bl;
                return b.First();
            }
            catch (Exception) { }
            return null;

        }

    }

}