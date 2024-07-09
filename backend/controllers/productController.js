const slugify = require('slugify');
const AppError = require('../utils/appError');
const { pool } = require('../DBConnection');

exports.getAllProducts = async (req, res, next) => {
  try {
    const { category } = req.query;
    const [result] = await pool.query('CALL GetAllProducts(?);', [category]);
    res.status(200).json({
      data: {
        result,
      },
    });
  } catch (err) {
    return next(new AppError('Error', 500));
  }
};

exports.createProduct = async (req, res, next) => {
  try {
    const { name, quantity, price, description, categoryId } = req.body;
    const slug = slugify(name);
    console.log(categoryId);
    const [insertedProduct] = await pool.query(
      'CALL AddProduct(?,?,?,?,?,?);',
      [name, quantity, price, slug, description, categoryId],
    );

    res.status(201).json({
      data: {
        insertedProduct,
      },
    });
  } catch (err) {
    return next(new AppError(`Error Creating Product${err}`, 500));
  }
};

exports.getProduct = async (req, res, next) => {
  try {
    const productSlug = req.params.slug;
    const selectQuery = 'CALL GetProductBySlug(?)';

    const [result] = await pool.query(selectQuery, productSlug);

    res.status(200).json({
      result: result[0],
    });
  } catch (err) {
    return next(new AppError('Error Getting Product', 500));
  }
};

exports.deleteProduct = async (req, res, next) => {
  try {
    const productSlug = req.params.slug;

    const deleteQuery = 'CALL DeleteProduct(?)';

    const deletionResult = await pool.query(deleteQuery, [productSlug]);

    if (deletionResult.affectedRows === 0) {
      return res.status(404).json({ message: 'Product not found' });
    }

    res.status(200).json({
      message: 'Product deleted successfully',
      deletedProductSlug: productSlug,
    });
  } catch (err) {
    return next(new AppError('Error deleting product', 500));
  }
};

// exports.updateProduct = async (req, res, next) => {
//   try {
//     const productSlug = req.params.slug;

//     const updatedFields = req.body;

//     const keys = Object.keys(updatedFields);
//     const values = Object.values(updatedFields);

//     const updateQuery = `UPDATE product SET ${keys
//       .map((key) => `${key} = ?`)
//       .join(', ')} WHERE slug = ?`;
//     const updateValues = [...values, productSlug];

//     await pool.query(updateQuery, updateValues);

//     res.status(200).json({
//       message: 'Product updated successfully',
//       data: {
//         id: productSlug,
//         updatedFields,
//       },
//     });
//   } catch (err) {
//     return next(new AppError('Error updating product', 500));
//   }
// };
