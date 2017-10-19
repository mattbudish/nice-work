import riot  from 'rollup-plugin-riot'
import resolve from 'rollup-plugin-node-resolve'
import commonjs from 'rollup-plugin-commonjs'
import buble from 'rollup-plugin-buble'
import replace from 'rollup-plugin-replace'
import postcss from 'rollup-plugin-postcss'

export default {
  entry: 'src/main.js',
  dest: 'public/bundle.js',
  plugins: [
    riot(),
    postcss({
      extensions: [ '.css' ]
    }),
    resolve({
      jsnext: true,
      main: true,
      browser: true,
    }),
    commonjs({
      namedExports: {
        'node_modules/bootstrap/dist/js/bootstrap.min.js' : ['bootstrap']
      }
    }),
    buble(),
    replace({
      exclude: 'node_modules/**',
      ENV: JSON.stringify(process.env.NODE_ENV || 'development'),
    })
  ],
  format: 'iife',
  sourceMap: false,
}
