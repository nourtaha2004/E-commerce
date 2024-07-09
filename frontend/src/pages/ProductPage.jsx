import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import swal from "sweetalert2";
const ProductPage = () => {
  const { category, productSlug } = useParams();
  const [amount, setAmount] = useState(1);
  const dis = amount === 1;
  const disabledClass = dis
    ? "bg-gray-200 py-2 px-4 rounded-lg text-3xl disabled_button"
    : "bg-gray-200 py-2 px-4 rounded-lg text-3xl text-black";
  const role = localStorage.getItem("role");
  const [product, setProduct] = useState({});
  const productId = product.product_id;
  const fetchProduct = async () => {
    try {
      const result = await fetch(
        `http://localhost:5000/products/${productSlug}`
      );

      const p = await result.json();
      setProduct(p.result[0]);
    } catch (error) {}
  };

  useEffect(() => {
    fetchProduct();
  }, []);

  const token = localStorage.getItem("token");

  const onAddToCart = async (e) => {
    e.preventDefault();

    const headers = {
      Authorization: `Bearer ${token}`,
    };

    const body = {
      productId: productId,
      quantity: amount,
    };
    try {
      const result = await fetch("http://localhost:5000/cart", {
        headers: {
          "Content-Type": "application/json",
          ...headers,
        },
        method: "POST",
        body: JSON.stringify(body),
      });

      const added = await result.json();
      if (result.ok) {
        swal.fire({
          title: added.message,
          icon: "success",
          confirmButtonColor: "#dfa387",
        });
      }
    } catch (error) {
      console.log(error);
    }
  };
  return (
    <div className="flex flex-col justify-between lg:flex-row gap-16 lg:items-center">
      <div className="flex flex-col gap-6 lg:w-2/4">
        <img
          src={`/${category}/${productSlug}.jpg`}
          alt=""
          width={400}
          height={400}
          className=" object-cover rounded-xl"
        />
      </div>
      <div className="flex flex-col gap-4 lg:w-2/4">
        <div>
          <h1 className="text-4xl font-bold">{product.name}</h1>
        </div>
        <p className="text-gray-700">{product.description}</p>
        <h6 className="text-2xl font-semibold">💲{product.price}</h6>
        <h6 className="text-sm font-semibold">#{category}</h6>
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
              className="bg-gray-200 py-2 px-4 rounded-lg text-black text-3xl"
              onClick={() => setAmount((prev) => prev + 1)}
            >
              +
            </button>
          </div>
          <button
            onClick={onAddToCart}
            disabled={role === "admin"}
            className="bg-[#dfa387] text-white font-semibold py-3 px-16 rounded-xl h-full text-xs w-full"
          >
            Add to Cart
          </button>
        </div>
      </div>
    </div>
  );
};

export default ProductPage;
