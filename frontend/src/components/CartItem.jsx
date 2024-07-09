import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import slugify from "react-slugify";
import swal from "sweetalert2";
const CartItem = ({ product }) => {
  const slug = slugify(product.name);
  const router = useNavigate();
  const [amount, setAmount] = useState(product.quantity);
  const dis = amount === 1;
  const disabledClass = dis
    ? "bg-gray-200 py-2 px-4 rounded-lg text-sm disabled_button"
    : "bg-gray-200 py-2 px-4 rounded-lg text-sm text-blue-800";

  const token = localStorage.getItem("token");
  const saveCart = async (e) => {
    e.preventDefault();

    try {
      const result = await fetch("http://localhost:5000/cart", {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
        method: "PATCH",
        body: JSON.stringify({
          productId: product.product_id,
          newQuantity: amount,
        }),
      });

      const r = await result.json();
      if (result.ok) {
        swal
          .fire({
            title: r.message,
            icon: "success",
            confirmButtonColor: "#dfa387",
          })
          .then((res) => {
            window.location.reload();
          });
      }
    } catch (error) {
      console.log(error);
    }
  };

  const handleDeleteItem = async () => {
    try {
      const result = await fetch(
        `http://localhost:5000/cart/remove/${product.product_id}`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
          method: "DELETE",
        }
      );
      const r = await result.json();
      console.log(r);
      if (result.ok) {
        swal
          .fire({
            icon: "success",
            title: "Item Removed From Cart",
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
    <div className="flex flex-row w-full ">
      <div className="cart_item text-left">
        <div className="flex-1 flex justify-between items-center gap-3 cursor-pointer">
          <div className="flex w-1/2">
            <img
              src={`/${product.category_name}/${slug}.jpg`}
              alt="i"
              width={50}
              height={50}
              className="w-full rounded-xl object-contain"
            />
          </div>
          <div className="flex w-1/2">
            <br />
            <h3 className="font-semibold text-2xl text-gray-900 ">
              {product.name}
            </h3>
          </div>
          <div className="flex flex-row justify-between items-center gap-16">
            <p className="my-4 text-l font-semibold  text-gray-800 ">
              {product.price}💲
            </p>
          </div>
          <div className="flex flex-row items-center gap-12">
            <div className="flex flex-row items-center">
              <button
                disabled={dis}
                className={disabledClass}
                onClick={() => setAmount((prev) => prev - 1)}
              >
                -
              </button>
              <span className="py-4 px-6 rounded-lg">{amount}</span>
              <button
                className="bg-gray-200 py-2 px-4 rounded-lg text-sm text-black"
                onClick={() => setAmount((prev) => prev + 1)}
              >
                +
              </button>
            </div>
            <button
              onClick={saveCart}
              className="bg-[#dfa387] text-white font-semibold py-3 px-16 rounded-xl h-full"
            >
              Save
            </button>
            <button
              className="w0full bg-red-300 rounded-md h-full p-2 text-2xl text-red-700"
              onClick={handleDeleteItem}
            >
              Remove
            </button>
          </div>
        </div>
        <p className="text-center text-2xl">Total: {product.total_price}</p>
      </div>
    </div>
  );
};

export default CartItem;
