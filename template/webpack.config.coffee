path                          = require('path')
ExtractTextPlugin             = require('extract-text-webpack-plugin')
HtmlWebpackPlugin             = require('html-webpack-plugin')
_                             = require('lodash')
autoprefixer                  = require('autoprefixer')(map: true)

module.exports =
  context: path.resolve(__dirname, 'src')
  stats: children: false
  devtool: 'source-map'
  entry:
    app: './app.coffee'
  output:
    path: path.resolve(__dirname, 'build')
    filename: '[name].bundle.js'
  module: rules: [
    { test: /\.coffee/, use: 'coffee-loader' }
    { test: /\.pug/,    use: 'pug-loader' }
    {
      test: /\.(scss)$/
      use: ExtractTextPlugin.extract(
        fallback: 'style-loader'
        use: [
          {
            loader: 'css-loader'
            options:
              sourceMap: true
          }, {
            loader: 'postcss-loader'
            options:
              plugins: -> [ autoprefixer ]
              sourceMap: true
          }, {
            loader: 'fast-sass-loader'
            options:
              sourceMap: true
          }
        ]
      )
    }
  ]
  plugins: [
    new ExtractTextPlugin('[name].css')
    new HtmlWebpackPlugin(
      filename: 'index.html'
      template: 'app.pug'
      inject: 'body'
      chunks: ['app']
    )
  ]
