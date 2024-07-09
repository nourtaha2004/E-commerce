import { useEffect, useState } from "react";
import ProductCard from "./ProductCard";

const ProductCardList = ({ data, handleTagClicked }) => {
  return (
    <div className="mt-5 recipe_layout">
      {data.map((product, index) => (
        <ProductCard
          key={index}
          product={product}
          handleTagClicked={handleTagClicked}
        />
      ))}
    </div>
  );
};

const Feed = ({ category }) => {
  const [searchText, setSearchText] = useState("");
  const [products, setProducts] = useState([]);

  const fetchProducts = async () => {
    try {
      const result = await fetch(
        `http://localhost:5000/products?category=${category}`
      );
      const p = await result.json();
      setProducts(p.data.result[0]);
    } catch (error) {
      console.log(error);
    }
  };

  useEffect(() => {
    fetchProducts();
  }, []);

  const filterPrompts = (searchtext) => {
    const regex = new RegExp(searchtext, "i");
    return products.filter(
      (item) => regex.test(item.name) || regex.test(item.description)
    );
  };

  const handleTagClick = (tagName) => {
    setSearchText(tagName);
  };

  const removeSearch = () => {
    setSearchText("");
  };

  return (
    <>
      <section className="feed">
        <form
          className="relative w-full flex-center"
          onSubmit={(e) => e.preventDefault()}
        >
          <input
            type="text"
            placeholder="Search for a tag or a username"
            value={searchText}
            onChange={(e) => setSearchText(e.target.value)}
            className="search_input peer"
          />
          <button onClick={removeSearch} className="x_btn rounded-full">
            X
          </button>
        </form>

        <ProductCardList
          // data={productsData}
          data={filterPrompts(searchText)}
          handleTagClicked={handleTagClick}
        />
      </section>
    </>
  );
};

export default Feed;
