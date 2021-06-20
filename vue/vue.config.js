const path = require('path');

module.exports = {
  lintOnSave: false,
  publicPath: '/',
  configureWebpack: {
    resolve: {
      alias: {
        '@': path.resolve(__dirname, 'src/'),
        '@views': path.resolve(__dirname, 'src/views/'),
        '@mixins': path.resolve(__dirname, 'src/mixins/'),
        '@common': path.resolve(__dirname, 'src/components/common/'),
        '@fonts': path.resolve(__dirname, 'src/assets/fonts/'),
      },
    },

    output: {
      filename: '[name].[hash].js',
      path: path.resolve(__dirname, 'dist'),
    },

    optimization: {
      runtimeChunk: 'single',
      splitChunks: {
        cacheGroups: {
          vendor: {
            test: /[\\/]node_modules[\\/]/,
            name: 'vendors',
            chunks: 'all',
          },
        },
      },
    },
  },
};
