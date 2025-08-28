gcloud config set project qwiklabs-gcp-03-fd4a2fe139e4
mkdir ~/webpack-lab && cd $_
mkdir dist
cat << EOF > dist/index.html
<!DOCTYPE html>
<html lang="en">
<head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Webpack Lab</title>
</head>
<body>
  <div class="main-content">
    <img id="imgBrand" alt="Brand Image"/>
    <header>
      <h3>Hectares to Acres<h3>
    <header>
    <form>
      <input placeholder="Hectares" type="number" maxlength="255">
      <button>Convert</button>
    </form>
    <p id=conversion></p>
  </div>
</body>
</html>
EOF

python3 -m http.server 8080 --directory dist
mkdir src
// Use the values from the HTML page
const formControl = document.querySelector('form');
const inputControl = document.querySelector('input');
const outputControl = document.querySelector('#conversion');
// Set the output to blank when the screen starts
outputControl.textContent = '';
// Handle form processing
formControl.addEventListener('submit', (event) => {
  event.preventDefault();
  if (parseInt(inputControl.value)) {
    const calcResult = (inputControl.value * 2.4711).toFixed(2);
    outputControl.textContent = inputControl.value.toString() + " Hectares is " + calcResult.toString() + " Acres";
  }
})
ls
cd src
nano index.js
cat index.js
cd ..
cd dist
nano index.js
ls
nano index.html
python3 -m http.server 8080 --directory dist
cd ..
python3 -m http.server 8080 --directory dist
npm init -y
npm install webpack webpack-cli --save-dev
nano package.json
nano package.json
cat package.json
npm run build
python3 -m http.server 8080 --directory dist
ls
cd dist
ls
cat main.js
cd ..
cd dist
cd ..
nano dist/index.html
nano dist/index.html
cat dist/index.html
nano webpack.config.js
npm run build
nano webpack.config.js
npm run build
nano webpack.config.js
npm run build
nano webpack.config.js
nano package.json
npm install --save-dev html-webpack-plugin style-loader css-loader @babel/core @babel/preset-env babel-loader
nano src/index.js
nano src/index.js
nano src/style.css
nano src/index.js
npm run build
mkdir src/assets
gsutil cp gs://spls/gsp1133/blueprint.png src/assets/house-design.png
nano src/index.js
nano src/index.js
