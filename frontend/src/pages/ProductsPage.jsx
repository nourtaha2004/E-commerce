import React from "react";
import { useParams } from "react-router-dom";
import Feed from "../components/Feed";

const ProductsPage = ({ product }) => {
  const { slug } = useParams();
  const title = slug.toUpperCase();

  return (
    <>
      <h1 className="head_text text-left">
        <span style={{ color: "#c8ad7e" }}>{title} Page</span>
      </h1>
      <Feed category={slug} />
    </>
  );
};

export default ProductsPage;
