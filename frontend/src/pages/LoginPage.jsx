import axios from "axios";
import { useState } from "react";
import { useNavigate } from "react-router-dom";

const LoginPage = () => {
  const navigate = useNavigate();
  const [user, setUser] = useState({
    email: "",
    password: "",
  });
  const handleLogin = async (e) => {
    e.preventDefault();
    axios
      .post("http://localhost:5000/users/login", user)
      .then((res) => {
        const token = res.data.token;
        localStorage.setItem("userId", res.data.data.user.user_id);
        localStorage.setItem("role", res.data.data.user.role);
        localStorage.setItem("token", token);
        if (res.data.data.user.role === "admin") {
          navigate("/admin-page");
        } else {
          navigate("/");
        }
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
            <span className="mb-3 text-4xl font-bold">Welcome back!</span>
            <span className="font-light text-gray-400 mb-8">
              Please enter your details.
            </span>
            <form onSubmit={handleLogin}>
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

              <button
                type="submit"
                className="w-full h-10 p-2 rounded-lg mb-6 black_btn2"
              >
                Sign in
              </button>

              <br />
              <div className="text-center text-gray-400">
                Dont have an account?
                <a href={"/sign-up"} className="font-bold text-black">
                  {" "}
                  Sign up for free
                </a>
              </div>
            </form>
          </div>
        </div>
      </div>
    </>
  );
};

export default LoginPage;
