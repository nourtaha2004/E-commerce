import React, { useEffect, useState } from "react";
import Modal from "react-bootstrap/Modal";
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import { useNavigate } from "react-router-dom";
import swal from "sweetalert2";
import CartItem from "./CartItem";

const PaymentPopUpForm = ({ payment, setPayment }) => {
  console.log(payment);
  const [show, setShow] = useState(false);
  const handleClose = () => setShow(false);
  const handleShow = () => setShow(true);
  const token = localStorage.getItem("token");

  const handleInputChange = (key, value) => {
    setPayment((prevPayment) => ({
      ...prevPayment,
      [key]: value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    console.log(payment);

    try {
      const result = await fetch("http://localhost:5000/users/payment", {
        method: "PUT",
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify(payment),
      });
      const r = await result.json();
      console.log(r);
      handleClose();
    } catch (error) {
      console.log(error);
    }
  };

  return (
    <>
      <button
        className="bg-[#dfa387] text-white font-semibold py-3 px-16 rounded-xl h-full"
        onClick={handleShow}
      >
        Payment Details
      </button>

      <Modal show={show} onHide={handleClose}>
        <Modal.Header closeButton>
          <Modal.Title>Enter Payment Details</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <form className="flex flex-col">
            <input
              type="text"
              className="search_input m-1"
              placeholder="Card Number"
              value={payment.card_number}
              onChange={(e) => handleInputChange("card_number", e.target.value)}
            />
            <DatePicker
              className="search_input"
              selected={payment.expiration_date}
              onChange={(date) => {
                handleInputChange("expiration_date", date);
              }}
              dateFormat="yyyy-MM-dd"
              value={payment.expiration_date}
            />
            <input
              type="text"
              className="search_input m-1"
              placeholder="Card Holder Name"
              value={payment.cardholder_name}
              onChange={(e) =>
                handleInputChange("cardholder_name", e.target.value)
              }
            />
            <input
              type="text"
              className="search_input m-1"
              placeholder="CVV"
              value={payment.cvv}
              onChange={(e) => handleInputChange("cvv", e.target.value)}
            />
          </form>
        </Modal.Body>
        <Modal.Footer>
          <button
            className="bg-gray-800 text-white font-semibold py-1 px-5 rounded-xl h-full"
            onClick={handleClose}
          >
            Close
          </button>
          <button
            className="bg-green-800 text-white font-semibold py-1 px-5 rounded-xl h-full"
            onClick={handleSubmit}
          >
            Confirm
          </button>
        </Modal.Footer>
      </Modal>
    </>
  );
};

const DeliveryPopUpForm = ({ delivery, setDelivery }) => {
  console.log(delivery);
  const [show, setShow] = useState(false);
  const token = localStorage.getItem("token");
  const handleClose = () => setShow(false);
  const handleShow = () => setShow(true);

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const result = await fetch("http://localhost:5000/users/delivery", {
        method: "PUT",
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify(delivery),
      });
      const r = await result.json();

      console.log(r);
      handleClose();
    } catch (error) {
      console.log(error);
    }
  };

  return (
    <>
      <button
        className="bg-[#dfa387] text-white font-semibold py-3 px-16 rounded-xl h-full"
        onClick={handleShow}
      >
        Delivery Details
      </button>

      <Modal show={show} onHide={handleClose}>
        <Modal.Header closeButton>
          <Modal.Title>Enter Delivery Details</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <form className="flex flex-col">
            <input
              type="text"
              className="search_input m-1"
              placeholder="City"
              value={delivery.city}
              onChange={(e) =>
                setDelivery({ ...delivery, city: e.target.value })
              }
            />
            <input
              type="text"
              placeholder="Street"
              className="search_input m-1"
              value={delivery.street}
              onChange={(e) =>
                setDelivery({ ...delivery, street: e.target.value })
              }
            />
            <input
              type="text"
              className="search_input m-1"
              placeholder="apartment"
              value={delivery.apartment}
              onChange={(e) =>
                setDelivery({ ...delivery, apartment: e.target.value })
              }
            />
            <input
              type="text"
              className="search_input m-1"
              placeholder="Phone Number"
              value={delivery.phone_number}
              onChange={(e) =>
                setDelivery({ ...delivery, phone_number: e.target.value })
              }
            />
          </form>
        </Modal.Body>
        <Modal.Footer>
          <button
            className="bg-gray-800 text-white font-semibold py-1 px-5 rounded-xl h-full"
            onClick={handleClose}
          >
            Close
          </button>
          <button
            className="bg-green-800 text-white font-semibold py-1 px-5 rounded-xl h-full"
            // type="submit"
            onClick={handleSubmit}
          >
            Confirm
          </button>
        </Modal.Footer>
      </Modal>
    </>
  );
};

const Cart = () => {
  const token = localStorage.getItem("token");

  const navigate = useNavigate();
  const [cartItems, setCartItems] = useState();

  const [delivery, setDelivery] = useState({
    city: "",
    street: "",
    apartment: "",
    phone_number: "",
  });
  const [payment, setPayment] = useState({
    card_number: "",
    expiration_date: new Date(),
    cardholder_name: "",
    cvv: "",
  });

  const fetchDelivery = async () => {
    try {
      const result = await fetch("http://localhost:5000/users/delivery", {
        method: "GET",
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
      });

      const d = await result.json();
      if (d.data.result[0]) setDelivery(d.data.result[0]);
    } catch (error) {
      console.log(error);
    }
  };

  const fetchPayment = async () => {
    try {
      const result = await fetch("http://localhost:5000/users/payment", {
        method: "GET",
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
      });

      const d = await result.json();
      console.log(d.result[0]);
      if (d.result[0]) {
        const date = d.result[0].expiration_date;
        const newPayment = {
          ...d.result[0],
          expiration_date: new Date(date),
        };
        setPayment(newPayment);
      }
    } catch (error) {
      console.log(error);
    }
  };

  const fetchCart = async () => {
    try {
      const result = await fetch("http://localhost:5000/cart", {
        method: "GET",
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      const c = await result.json();
      setCartItems(c.result[0]);
    } catch (error) {
      console.log(error);
    }
  };

  // const fetchPaymentData

  useEffect(() => {
    fetchCart();
    fetchDelivery();
    fetchPayment();
  }, []);

  const orderInfo = {
    ...payment,
    ...delivery,
  };
  delete orderInfo.payment_id;
  delete orderInfo.order_id;
  const handleCreateOrder = async () => {
    try {
      const result = await fetch("http://localhost:5000/orders/my-orders", {
        method: "POST",
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify(orderInfo),
      });
      const r = await result.json();
      if (result.ok) {
        swal
          .fire({
            title: "Order Confirmed!",
            text: r.message,
            icon: "success",
          })
          .then((result) => {
            window.location.reload();
          });
      }
    } catch (error) {
      console.log(error);
    }
  };

  return (
    <>
      <h1 className="head_text text-left">
        <span style={{ color: "#dfa387" }}>Cart</span>
      </h1>
      <br />

      <div>
        {cartItems &&
          cartItems.map((item, index) => (
            <CartItem product={item} key={index} />
          ))}
      </div>
      <br />

      <br />
      <div className="flex flex-row gap-16">
        <PaymentPopUpForm payment={payment} setPayment={setPayment} />
        <DeliveryPopUpForm delivery={delivery} setDelivery={setDelivery} />
      </div>
      <br />
      <button
        className="bg-[#dfa387] text-white font-semibold py-3 px-16 rounded-xl h-full"
        onClick={handleCreateOrder}
      >
        Confirm Order
      </button>
      <br />
      <br />
      <br />
    </>
  );
};

export default Cart;
