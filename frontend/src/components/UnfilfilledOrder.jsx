import axios from "axios";

const UnfilfilledOrder = ({ order }) => {
  console.log(order);
  const token = localStorage.getItem("token");

  const fulfilOrder = (e) => {
    e.preventDefault();
    axios
      .post(
        `http://localhost:5000/orders/${order.order_id}`,
        {},
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      )
      .then((res) => {
        console.log(res);
      })
      .catch((err) => {
        console.log(err);
      });

    window.location.reload();
  };

  return (
    <div className="flex flex-row w-full ">
      <div className="cart_item text-left">
        <div className="flex-1 flex justify-between items-center gap-3 cursor-pointer">
          <div className="flex w-1/2">
            <br />
            <h3 className="font-semibold text-xl text-gray-900 ">
              ID# {order.order_id}
            </h3>
          </div>
          <div className="flex flex-row justify-between items-center gap-16">
            <p className="my-4 text-xs font-semibold  text-gray-800 ">
              USER# {order.user_id}
            </p>
            <p className="my-4 text-xs font-semibold  text-gray-800 ">
              TOTAL {order.total_price}💲
            </p>
            <p className="my-4 text-xs font-semibold  text-gray-800 ">
              DATE <br />
              {order.order_date}
            </p>
          </div>
          <div className="flex flex-row items-center gap-12">
            <button
              onClick={fulfilOrder}
              className="bg-gray-500 text-white font-semibold py-3 px-16 rounded-xl h-full"
            >
              FULFIL
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default UnfilfilledOrder;
