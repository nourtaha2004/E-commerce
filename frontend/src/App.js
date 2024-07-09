import { Route, BrowserRouter as Router, Routes } from "react-router-dom";
import { RecoilRoot } from "recoil";
import Cart from "./components/Cart";
import Navbar from "./components/Navbar";
import AdminPage from "./pages/AdminPage";
import HomePage from "./pages/HomePage";
import LoginPage from "./pages/LoginPage";
import NotFoundPage from "./pages/NotFoundPage";
import ProductPage from "./pages/ProductPage";
import ProductsPage from "./pages/ProductsPage";
import Profile from "./pages/ProfilePage";
import SignupPage from "./pages/SignupPage";
function App() {
  return (
    <RecoilRoot>
      <div className="app">
        <Router>
          <Navbar />
          <Routes>
            <Route path="/" element={<HomePage />}></Route>
            <Route path="/log-in" element={<LoginPage />}></Route>
            <Route path="/sign-up" element={<SignupPage />}></Route>
            <Route path="/cart" element={<Cart />}></Route>
            <Route path="/profile" element={<Profile />}></Route>
            <Route path="/admin-page" element={<AdminPage />}></Route>
            <Route path="/products/:slug" element={<ProductsPage />}></Route>
            <Route
              path="/products/:category/:productSlug"
              element={<ProductPage />}
            ></Route>
            <Route path="*" element={<NotFoundPage />} />
          </Routes>
        </Router>
      </div>
    </RecoilRoot>
  );
}

export default App;
