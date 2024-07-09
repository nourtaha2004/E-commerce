import axios from "axios";
import { useState } from "react";
import { useNavigate } from "react-router-dom";

// firstName,
//       lastName,
//       username,
//       email,
//       password,
//       confirmPassword,
//       role,

const SignupPage = () => {
  const navigate = useNavigate();
  const [user, setUser] = useState({
    firstName: "",
    lastName: "",
    username: "",
    email: "",
    password: "",
    confirmPassword: "",
  });
  const handleSignUp = async (e) => {
    e.preventDefault();
    axios
      .post("http://localhost:5000/users/signup", user)
      .then((res) => {
        console.log(res);
        const token = res.data.token;
        localStorage.setItem("role", res.data.data.user.role);
        localStorage.setItem("token", token);
        navigate("/");
      })
      .catch((err) => {
        console.log(err);
      });
  };

  return (
    <>
      <div className="flex items-center justify-center min-h-screen bg-gray-100">
        <div className="relative flex flex-col m-6 space-y-8 bg-white shadow-2xl rounded-2xl md:flex-row md:space-y-0">
          <div className="flex flex-col justify-center p-8 md:p-14">
            <span className="mb-3 text-4xl font-bold">Create Your Account</span>
            <span className="font-light text-gray-400 mb-8">
              Please enter your details.
            </span>
            <form onSubmit={handleSignUp}>
              <div className="flex flex-row gap-5">
                <div className="py-4">
                  <span className="mb-2 text-md">First Name</span>
                  <input
                    type="text"
                    value={user.firstName}
                    onChange={(e) =>
                      setUser({ ...user, firstName: e.target.value })
                    }
                    className="w-full p-2 border border-gray-300 rounded-md placeholder:font-light placeholder:text-gray-500"
                  />
                </div>
                <div className="py-4">
                  <span className="mb-2 text-md">Last Name</span>
                  <input
                    type="text"
                    value={user.lastName}
                    onChange={(e) =>
                      setUser({ ...user, lastName: e.target.value })
                    }
                    className="w-full p-2 border border-gray-300 rounded-md placeholder:font-light placeholder:text-gray-500"
                  />
                </div>
              </div>
              <div className="py-4">
                <span className="mb-2 text-md">Email</span>
                <input
                  type="text"
                  value={user.email}
                  onChange={(e) => setUser({ ...user, email: e.target.value })}
                  className="w-full p-2 border border-gray-300 rounded-md placeholder:font-light placeholder:text-gray-500"
                  name="email"
                />
              </div>
              <div className="py-4">
                <span className="mb-2 text-md">Username</span>
                <input
                  type="text"
                  value={user.username}
                  onChange={(e) =>
                    setUser({ ...user, username: e.target.value })
                  }
                  className="w-full p-2 border border-gray-300 rounded-md placeholder:font-light placeholder:text-gray-500"
                  name="username"
                />
              </div>
              <div className="py-4">
                <span className="mb-2 text-md">Password</span>
                <input
                  type="password"
                  value={user.password}
                  onChange={(e) =>
                    setUser({ ...user, password: e.target.value })
                  }
                  className="w-full p-2 border border-gray-300 rounded-md placeholder:font-light placeholder:text-gray-500"
                  name="pass"
                />
              </div>
              <div className="py-4">
                <span className="mb-2 text-md">Confirm Password</span>
                <input
                  type="password"
                  value={user.confirmPassword}
                  onChange={(e) =>
                    setUser({ ...user, confirmPassword: e.target.value })
                  }
                  className="w-full p-2 border border-gray-300 rounded-md placeholder:font-light placeholder:text-gray-500"
                  name="pass"
                />
              </div>
              <br />
              <div>
                <button
                  type="submit"
                  className="w-full h-10 p-2 rounded-lg mb-6 black_btn2"
                >
                  Sign Up
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </>
  );
};

export default SignupPage;
