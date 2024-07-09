import { useState } from "react";
import { useNavigate } from "react-router-dom";
import Swal from "sweetalert2";

const Navbar = () => {
  const role = localStorage.getItem("role");
  const router = useNavigate();

  const signIn = () => {
    router("/log-in");
  };

  const signOut = () => {
    localStorage.removeItem("token");
    window.location.href = "/log-in";
  };

  const [toggle, setToggle] = useState(false);

  const isLogged = localStorage.getItem("token");
  return (
    <nav className="flex-between w-full mb-16 pt-3">
      <a href="/" className="flex flex-center">
        <img
          src="/logo.png"
          alt="logo"
          width={50}
          height={50}
          className="object-contain"
        />
        <p className="text-xl font-bold">Ecommerce</p>
      </a>

      {/* Desktop Nav */}
      <div className="sm:flex hidden">
        {isLogged ? (
          <div className="flex gap-3 md:gap-5">
            {role !== "admin" && (
              <a href="/cart" className="black_btn">
                Cart
              </a>
            )}

            <button
              type="button"
              onClick={() => {
                Swal.fire({
                  title: "Confirm Sign Out",
                  text: "Are you sure you want to sign out?",
                  icon: "question",
                  showCancelButton: true,
                  confirmButtonText: "Sign Out",
                  confirmButtonColor: "#dfa387",
                }).then((result) => {
                  if (result.isConfirmed) {
                    signOut();
                  }
                });
              }}
              className="outline_btn"
            >
              Sign Out
            </button>

            <a href={role === "admin" ? "/admin-page" : "/profile"}>
              <img
                src="/profile.png"
                alt="profile"
                width={37}
                height={37}
                className="rounded-full"
              ></img>
            </a>
          </div>
        ) : (
          <>
            <button
              type="button"
              onClick={() => signIn()}
              className="black_btn"
            >
              Sign In
            </button>
          </>
        )}
      </div>

      <div className="sm:hidden flex relative">
        {isLogged ? (
          <div className="flex">
            <img
              src="/profile.png"
              alt="profile"
              width={37}
              height={37}
              className="rounded-full"
              onClick={() => setToggle((prev) => !prev)}
            />
            {toggle && (
              <div className="dropdown">
                <a
                  href="/"
                  className="dropdown_link"
                  onClick={() => setToggle(false)}
                >
                  My Profile
                </a>
                <a
                  href="create-recipe"
                  className="dropdown_link"
                  onClick={() => setToggle(false)}
                >
                  Create Recipe
                </a>

                <button
                  type="button"
                  onClick={() => {
                    setToggle(false);
                    signOut();
                  }}
                  className="mt-5 w-full black_btn"
                >
                  Sign Out
                </button>
              </div>
            )}
          </div>
        ) : (
          <>
            <button
              type="button"
              onClick={() => signIn()}
              className="black_btn"
            >
              Sign In
            </button>
          </>
        )}
      </div>
    </nav>
  );
};

export default Navbar;
