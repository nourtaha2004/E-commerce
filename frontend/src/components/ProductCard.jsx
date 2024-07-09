import { useNavigate } from "react-router-dom";

const ProductCard = ({ product, handleTagClicked }) => {
  const router = useNavigate();
  console.log(product);
  return (
    <div className="recipe_card text-left">
      <div className="flex justify-between items-start gap-52">
        <div className="flex-1 flex justify-start items-center gap-3 cursor-pointer">
          <div className="flex flex-col">
            <img
              src={`/${product.category_name}/${product.slug}.jpg`}
              alt="i"
              width={100}
              height={100}
              className="w-full rounded-xl object-contain"
            />
            <br />
            <h3 className="font-semibold text-xl text-gray-900 ">
              {product.name}
            </h3>
            <p className="text-l text-gray-700">{product.description}</p>
            {/* <p className="text-l text-gray-500">{book.isbn}</p> */}
          </div>
        </div>
      </div>
      <div className="flex flex-row justify-between items-center">
        <p className="my-4 text-l font-semibold  text-gray-800 ">
          {product.price}💲
        </p>
        <button
          className="black_btn"
          onClick={() => router(`./${product.slug}`)}
        >
          View Product
        </button>
      </div>
    </div>
  );
};

export default ProductCard;
