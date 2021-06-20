module.exports = {
    env: {
      browser: true,
      es2021: true,
    },
    extends: [
      'plugin:vue/recommended',
      'airbnb-base',
      'plugin:vue-scoped-css/base',
      'plugin:vue-scoped-css/recommended',
    ],
    parserOptions: {
      ecmaVersion: 12,
      sourceType: 'module',
    },
    plugins: [
      'vue',
    ],
    rules: {
      'max-len': 'off',
      'no-param-reassign': ['error', {
        props: true,
        ignorePropertyModificationsFor: [
          'state', // for vuex state
          'acc', // for reduce accumulators
          'e', // for e.returnvalue
        ],
      }],
    },
    settings: {
      'import/resolver': {
        alias: {
          map: [
            ['@', './src'],
            ['@views', './src/views'],
            ['@common', './src/components/common'],
          ],
          extensions: ['.js', '.vue'],
        },
      },
    },
  };
  