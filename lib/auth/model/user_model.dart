// class UserModel {
//   String? name;
//   String? email;
//   String? password;
//   String? confirmPassword;
//
//   UserModel({
//     this.name,
//     this.email,
//     this.password,
//     this.confirmPassword,
//   });
//
//   // Convert to JSON for registration API request
//   Map<String, dynamic> toRegister() {
//     return {
//       'name': name,
//       'email': email,
//       'password': password,
//       'confirmPassword': confirmPassword,
//     };
//   }
//
//   // Convert to JSON for login API request
//   Map<String, dynamic> toLogin() {
//     return {
//       'email': email,
//       'password': password,
//     };
//   }
// }
