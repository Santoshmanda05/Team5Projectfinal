using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Team5Project.Models
{
    public class UserLogin
    {
        string userid;
        string password;

        [Required(ErrorMessage = "Userid Required")]
        [RegularExpression("^[a-zA-Z0-9]{6,20}$", ErrorMessage = "Invalid Userid")]
        public string Userid { get => userid; set => userid = value; }

        [Required(ErrorMessage = "Password Required")]
        [RegularExpression(@"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$", ErrorMessage = "Invalid Password")]

        public string Password { get => password; set => password = value; }



    }
}