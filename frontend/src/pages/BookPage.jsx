import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import swal from "sweetalert2";

import axios from "axios";

const BookPage = () => {
  const { slug } = useParams();
  const [amount, setAmount] = useState(1);
  const dis = amount === 1;
  const disabledClass = dis
    ? "bg-gray-200 py-2 px-4 rounded-lg text-3xl disabled_button"
    : "bg-gray-200 py-2 px-4 rounded-lg text-3xl text-blue-800";

  const [book, setBook] = useState({});
  const fetchBook = () => {
    axios
      .get(`http://localhost:5000/books/${slug}`)
      .then((res) => {
        setBook(res.data.result);
      })
      .catch((err) => {
        console.log(err);
      });
  };

  useEffect(() => {
    fetchBook();
  }, []);

  const token = localStorage.getItem("token");

  const onAddToCart = (e) => {
    const data = {
      bookId: book.book_id,
      quantity: amount,
    };
    console.log(data);
    e.preventDefault();
    console.log(amount);
    axios
      .post("http://localhost:5000/cart", data, {
        headers: { Authorization: `Bearer ${token}` },
      })
      .then((result) => {
        console.log(result);
        if (result.status === 200) {
          swal.fire({
            title: result.data.message,
            icon: "success",
            confirmButtonColor: "#dfa387",
          });
        }
      })
      .catch((err) => {
        console.log(err);
      });
  };

  return (
    <div className="flex flex-col justify-between lg:flex-row gap-16 lg:items-center">
      <div className="flex flex-col gap-6 lg:w-2/4">
        <img
          src={`/bookcovers/${book.isbn}.png`}
          alt=""
          className="w-full h-full object-cover rounded-xl"
        />
      </div>
      <div className="flex flex-col gap-4 lg:w-2/4">
        <div>
          <h1 className="text-4xl font-bold">{book.title}</h1>
          <p className=" text-blue-600 text-xl font-semibold">{book.author}</p>
          <p className=" text-blue-400 font-semibold">{book.isbn}</p>
        </div>
        <p className="text-gray-700">{book.description}</p>
        <p className="text-blue-500">
          {book.genre &&
            book.genre.map((genre) => (
              <span key={genre.toString()}>#{genre} </span>
            ))}
        </p>
        <h6 className="text-2xl font-semibold">💲 {book.price}</h6>
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
              className="bg-gray-200 py-2 px-4 rounded-lg text-blue-800 text-3xl"
              onClick={() => setAmount((prev) => prev + 1)}
            >
              +
            </button>
          </div>
          <button
            onClick={onAddToCart}
            className="bg-blue-800 text-white font-semibold py-3 px-16 rounded-xl h-full"
          >
            Add to Cart
          </button>
        </div>
      </div>
    </div>
  );
};

export default BookPage;
