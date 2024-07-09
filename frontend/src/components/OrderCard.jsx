import Accordion from "react-bootstrap/Accordion";

// {
//   order_id: 83,
//   items: [
//     {
//       product_id: 178,
//       name: 'Effaclar Serum',
//       price: 75,
//       slug: 'effaclar-serum',
//       total_price: 135,
//       fulfilled: 0,
//       order_date: '2024-01-18T13:34:32.000Z',
//       quantity: 1
//     },
//     {
//       product_id: 179,
//       name: 'Effaclar DUO',
//       price: 60,
//       slug: 'effaclar-duo',
//       total_price: 135,
//       fulfilled: 0,
//       order_date: '2024-01-18T13:34:32.000Z',
//       quantity: 1
//     }
//   ]
// }

const OrderRow = ({ product }) => {
  console.log(product);
  return (
    <>
      <div className="flex flex-row w-full">
        <span className="my-4 text-left w-1/2 text-base font-semibold  text-gray-800 ">
          {product.name}
        </span>
        <span className="my-4 text-left w-1/2 text-base font-semibold  text-gray-800 ">
          {product.price}💲
        </span>
        <span className="my-4 text-left w-1/2 text-base font-semibold  text-gray-800 ">
          {product.quantity}
        </span>
      </div>
    </>
  );
};

const OrderCard = ({ order }) => {
  const products = order.items;
  return (
    <div className="flex flex-row w-full">
      <Accordion className="w-3/4">
        <Accordion.Header>Order #{order.order_id}</Accordion.Header>
        <Accordion.Body>
          {products.length !== 0 &&
            products.map((product) => (
              <OrderRow product={product} key={product.product_id} />
            ))}
        </Accordion.Body>
      </Accordion>
      {order.items[0].fulfilled === 0 ? (
        <p className="not_fulfilled_order">Not Fulfilled</p>
      ) : (
        <p className="fulfilled_order">Fulfilled</p>
      )}
    </div>
  );
};

export default OrderCard;
