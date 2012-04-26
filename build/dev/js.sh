../common/js-cat.sh > _temp.coffee
coffee -c _temp.coffee
cp _temp.js ../../wrangler.js
rm _temp.*
echo "Development JavaScript build complete."