class LoginModel{
  String userid;
  String password;

  bool isValid()
  {
    return userid=="akshay" && password=="123";
  }
  LoginModel(
      this.userid,
      this.password,
      // this.isValid,
      );

}