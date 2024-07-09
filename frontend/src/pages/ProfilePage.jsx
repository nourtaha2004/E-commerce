import axios from "axios";
import React, { useEffect, useState } from "react";
import OrderCard from "../components/OrderCard";
const Profile = () => {
  const token = localStorage.getItem("token");
  const [orders, setOrders] = useState([]);
  const fetchOrders = () => {
    axios
      .get("http://localhost:5000/orders/my-orders", {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((res) => {
        setOrders(res.data.data);
      })
      .catch((err) => {
        console.log(err);
      });
  };

  useEffect(() => {
    fetchOrders();
  }, []);

  const groupedOrders = orders.reduce((acc, order) => {
    const { user_id, order_id, ...rest } = order;
    if (!acc[user_id]) {
      acc[user_id] = {};
    }
    if (!acc[user_id][order_id]) {
      acc[user_id][order_id] = [];
    }
    acc[user_id][order_id].push(rest);
    return acc;
  }, {});

  // Convert the object to an array of grouped orders
  const result = Object.keys(groupedOrders).map((user_id) => ({
    user_id: parseInt(user_id, 10),
    orders: Object.keys(groupedOrders[user_id]).map((order_id) => ({
      order_id: parseInt(order_id, 10),
      items: groupedOrders[user_id][order_id],
    })),
  }));

  return (
    <>
      <h1 className="head_text text-center">
        <span className="">Profile Page</span>
      </h1>
      <p className="desc text-center">Welcome User!</p>

      <div className=" flex flex-column justify-center items-center w-full">
        <h3 className="text-3xl  text-center">Orders</h3>
        {result.length !== 0 &&
          result[0].orders.map((order) => (
            <OrderCard order={order} key={order.order_id} />
          ))}
        <br />
      </div>
    </>
  );
};

export default Profile;
