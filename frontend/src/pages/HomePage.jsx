import React from "react";
import slugify from "react-slugify";
const HomePage = () => {
  return (
    <>
      <section className="w-full flex-center flex-col">
        <h1 className="head_text text-center">
          <span className="text-center font-bold" style={{ color: "#c8ad7e" }}>
            Ecommerce:{" "}
          </span>
          Where Stories, Beauty, and Fashion Collide
          <br className="max-md:hidden" />
        </h1>
        <p className=" desc text-center ">
          Bound to Beauty: Explore Books, Skincare, and Fashion Essentials
        </p>
        <div className="flex flex-row w-full justify-center content-center gap-16 m-10 h-[200px]">
          {categories.map((category) => (
            <CategoryCard category={category} key={category.id} />
          ))}
        </div>
      </section>
    </>
  );
};

const CategoryCard = ({ category }) => {
  const slug = slugify(category.categoryName);

  return (
    <a href={`/products/${slug}`}>
      <div className="flex w-1/3 recipe_card justify-center content-center">
        <div className="flex flex-col text-center">
          <img
            src={`/categories/${category.image}.jpeg`}
            alt="i"
            width={100}
            height={100}
            className="w-full rounded-xl object-contain"
          />
          <br />
          <h3 className="font-semibold text-xl text-gray-900 ">
            {category.categoryName}
          </h3>
        </div>
      </div>
    </a>
  );
};
const categories = [
  {
    id: 1,
    categoryName: "Accessories",
    image: "accessory",
  },
  {
    id: 2,
    categoryName: "Skin Care",
    image: "skincare",
  },
  {
    id: 3,
    categoryName: "Books",
    image: "books",
  },
];

export default HomePage;
