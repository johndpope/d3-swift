const path = require('path');
//const webpack = require('webpack'); //Get rid of this?

module.exports = {
  devtool: 'source-map',
  entry: './index.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'bundle.js',
    publicPath: "/build/",
    libraryTarget: "var",
    library: "Paths"
  },
  module: {
    loaders: [{
      test: /\.(js)$/,
      loaders: ['babel'],
      include: path.join(__dirname, 'src')
    }]
  }
};
