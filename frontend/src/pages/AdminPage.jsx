import axios from "axios";
import React, { useEffect, useState } from "react";
import slugify from "react-slugify";
import swal from "sweetalert2";
import UnfilfilledOrder from "../components/UnfilfilledOrder";

const categoriesMap = {
  books: 1,
  "skin-care": 2,
  accessories: 3,
};

const AdminPage = () => {
  const [orders, setOrders] = useState([]);
  const token = localStorage.getItem("token");

  const fetchOrders = () => {
    axios
      .get("http://localhost:5000/orders", {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((result) => {
        console.log(result.data.data[0]);
        setOrders(result.data.data[0]);
      })
      .catch((err) => {
        console.log(err);
      });
  };

  useEffect(() => {
    fetchOrders();
  }, []);

  const [product, setProduct] = useState({
    name: "",
    description: "",
    categoryId: "",
    quantity: undefined,
    slug: "",
    price: undefined,
  });
  const addProductSubmit = (e) => {
    e.preventDefault();
    axios
      .post("http://localhost:5000/products", product, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((result) => {
        swal
          .fire({
            title: "PRDDUCT ADDED",
            icon: "success",
          })
          .then((res) => {
            if (res.isConfirmed) window.location.reload();
          });
      })
      .catch((err) => {
        console.log(err);
      });
  };
  return (
    <>
      <div className="w-full flex justify-center content-center text-center gap-16">
        <div className="flex w-1/2">
          <form
            className="relative w-full flex-center flex-col gap-3"
            onSubmit={addProductSubmit}
          >
            <input
              placeholder="Product Name"
              className="search_input"
              type="text"
              name="name"
              value={product.name}
              onChange={(e) =>
                setProduct({
                  ...product,
                  name: e.target.value,
                  slug: slugify(e.target.value),
                })
              }
            />
            <input
              placeholder="Product Description"
              className="search_input"
              type="text"
              name="description"
              value={product.description}
              onChange={(e) =>
                setProduct({ ...product, description: e.target.value })
              }
            />
            <input
              placeholder="Categroy"
              className="search_input"
              type="text"
              name="categoryId"
              value={product.categoryId}
              onChange={(e) => {
                const id = categoriesMap[e.target.value.toLocaleLowerCase()];
                setProduct({ ...product, categoryId: id });
              }}
            />
            <input
              placeholder="Price"
              className="search_input"
              type="text"
              name="price"
              value={product.price}
              onChange={(e) =>
                setProduct({ ...product, price: e.target.value })
              }
            />
            <input
              placeholder="Quantity"
              className="search_input"
              type="text"
              name="quantity"
              value={product.quantity}
              onChange={(e) =>
                setProduct({ ...product, quantity: e.target.value })
              }
            />

            <button type="submit" className="blue_btn rounded-full">
              Submit
            </button>
          </form>
        </div>
        <div className="flex w-1/2">
          <div className="flex flex-col w-full">
            {orders.length !== 0 &&
              orders.map((order) => {
                if (order.fulfilled === 0)
                  return (
                    <UnfilfilledOrder order={order} key={order.order_id} />
                  );
              })}
            {orders.length === 0 && <div>No Orders</div>}
          </div>
        </div>
      </div>
    </>
  );
};

export default AdminPage;
