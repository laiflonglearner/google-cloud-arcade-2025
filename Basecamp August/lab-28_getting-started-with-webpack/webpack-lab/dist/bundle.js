/*
 * ATTENTION: The "eval" devtool has been used (maybe by default in mode: "development").
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
/******/ (() => { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/***/ (() => {

eval("{// Use the values from the HTML page\nconst formControl = document.querySelector('form');\nconst inputControl = document.querySelector('input');\nconst outputControl = document.querySelector('#conversion');\n\n// Set the output to blank when the screen starts\noutputControl.textContent = '';\n\n// Handle form processing\nformControl.addEventListener('submit', (event) => {\n  event.preventDefault();\n\n  if (parseInt(inputControl.value)) {\n    const calcResult = (inputControl.value * 2.4711).toFixed(2);\n    outputControl.textContent = inputControl.value.toString() + \" Hectares is \" + calcResult.toString() + \" Acres\";\n  }\n})\n\n\n//# sourceURL=webpack://webpack-lab/./src/index.js?\n}");

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module can't be inlined because the eval devtool is used.
/******/ 	var __webpack_exports__ = {};
/******/ 	__webpack_modules__["./src/index.js"]();
/******/ 	
/******/ })()
;